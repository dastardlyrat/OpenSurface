#!/usr/bin/env python3
from __future__ import annotations

import json
import multiprocessing as mp
import shutil
import sqlite3
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SRC = ROOT / "src"
sys.path.insert(0, str(SRC))

from durable_workspace import DurableWorkspace


def worker(root: str, worker_id: int, n: int) -> None:
    ws = DurableWorkspace(root)
    for i in range(n):
        ws.set(f"worker/{worker_id}/{i}", {"worker": worker_id, "iteration": i})


def main() -> int:
    checks = []
    def check(name, fn):
        try:
            fn(); checks.append((name, True, ""))
        except Exception as exc:
            checks.append((name, False, str(exc)))

    with tempfile.TemporaryDirectory() as td:
        base = Path(td)
        ws = DurableWorkspace.init(base / "workspace")
        check("initial verify", lambda: ws.verify())

        def concurrency():
            procs = [mp.Process(target=worker, args=(str(ws.root), w, 50)) for w in range(4)]
            for p in procs: p.start()
            for p in procs: p.join(30)
            if any(p.exitcode != 0 for p in procs): raise RuntimeError(f"worker exit codes: {[p.exitcode for p in procs]}")
            report = ws.verify()
            if report["record_count"] != 200 or report["event_count"] != 200:
                raise RuntimeError(f"unexpected counts {report}")
        check("4-process concurrent writers / 200 commits", concurrency)

        ws.set("edge/control", {"text": "nul\u0000 newline\n emoji🙂", "flags": [True, False, None], "n": 9})
        snapshot = ws.checkpoint()
        check("published snapshot verifies", lambda: DurableWorkspace.inspect_snapshot(snapshot))

        for victim in ("snapshot.sqlite3", "snapshot.jsonl", "snapshot.xml"):
            def recover_one(victim=victim):
                copy = base / f"copy-{victim}"
                shutil.copytree(snapshot, copy)
                p = copy / victim
                if victim.endswith(".sqlite3"):
                    with p.open("r+b") as f: f.seek(100); f.write(b"DAMAGED")
                else:
                    p.write_bytes(b"damaged")
                recovered = DurableWorkspace.recover(copy, base / f"recovered-{victim}")
                if recovered.get("edge/control")["n"] != 9: raise RuntimeError("recovered state mismatch")
                recovered.verify()
            check(f"recover with {victim} lost", recover_one)

        def journal_tamper():
            bad = base / "tamper"
            shutil.copytree(ws.root, bad)
            conn = sqlite3.connect(bad / "workspace.sqlite3")
            try:
                conn.execute("UPDATE journal SET event_sha256=? WHERE seq=1", ("f"*64,)); conn.commit()
            finally: conn.close()
            try:
                DurableWorkspace(bad).verify()
            except Exception:
                return
            raise RuntimeError("journal tamper was not detected")
        check("runtime journal tamper detection", journal_tamper)

    width = max(len(n) for n,_,_ in checks)
    for name, ok, detail in checks:
        print(f"{'PASS' if ok else 'FAIL'}  {name.ljust(width)}" + (f"  {detail}" if detail else ""))
    passed = sum(ok for _,ok,_ in checks)
    print(f"\n{passed}/{len(checks)} checks passed")
    return 0 if passed == len(checks) else 1

if __name__ == "__main__":
    raise SystemExit(main())
