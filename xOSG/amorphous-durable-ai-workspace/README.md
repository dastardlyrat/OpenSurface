# Amorphous Durable AI Workspace

This project contains the Durable Workspace Development Kit (DWSK) 0.1.1.

DWSK supplies durable storage for per-project AI instrumentation and sustained human–AI work. Applications can persist working state, conversation-log records, evidence references, decisions and other ledgers as opaque canonical records. The application supplies capture, schemas, permissions and interpretation; DWSK supplies persistence and recovery mechanics. This library and CLI does not automatically capture ChatGPT conversations or operate an agent service.

## Capabilities

- SQLite runtime store with WAL and synchronous=FULL.
- State mutations and hash-chained journal events in the same transaction.
- DWSK-CJ-1 canonical data: NFC text, signed 64-bit integers and explicit Boolean/integer distinction; floats are rejected.
- SQLite, JSONL and typed XML snapshots with manifest-last publication.
- Replay/value consistency checks during verification, checkpoint, inspection and recovery.
- Recovery requires two valid agreeing representations and the manifest digest; no format is inherently authoritative.
- Windows pointer promotion coordinated by a named mutex, with bounded acquisition and replacement retry.
- No third-party runtime dependency. Python >=3.11 is required; this build is validated on Windows/Python 3.14, not every interpreter or OS.

## Install and use

Install the accompanying wheel into an environment of your choice:

```text
python -m pip install --no-deps ./durable_workspace_development_kit-0.1.1-py3-none-any.whl
dwsk init ./demo-workspace
dwsk verify ./demo-workspace
dwsk checkpoint ./demo-workspace
```

Use the Python API for structured values without shell quoting concerns:

```python
from durable_workspace import DurableWorkspace
workspace = DurableWorkspace("./demo-workspace")
workspace.set("project", {"phase": "review", "sequence": 1})
snapshot = workspace.checkpoint()
recovered = DurableWorkspace.recover(snapshot, "./new-recovery-target")
assert recovered.get("project")["phase"] == "review"
```

The CLI also provides set, get, delete, verify-snapshot and recover. Recover into a new or empty directory and preserve the damaged original first. Documentation, schemas, examples and workspace-control templates accompany the source distribution and source ZIP.

## Windows publication and boundaries

Snapshot construction stays parallel. A five-second mutex wait precedes pointer promotion; Windows errors 5/32/33 receive a two-second bounded replacement retry. The old pointer is never pre-deleted. When Windows reports abandonment, DWSK inspects any existing pointer and its complete generation before proceeding; inconsistent state is refused. Persistent failures remain errors and may retain complete unreferenced generations.

Coordination covers cooperating publishers using the same normalized workspace path, user and Windows session. Other aliases, sessions/users and external programs are outside it. Windows directory handles are not synchronized; these checks do not establish physical power-loss durability or independent backup recovery. See DURABILITY_CONTRACT.md and RECOVERY_PLAYBOOK.md.

## Validation and integration

VALIDATION_REPORT.md records the source-validation basis. Installed artifact results belong to the accompanying BUILD_REPORT.md and artifact inventory. The original 0.1.0 report is retained under docs/ as historical material, not acceptance of this build.

Keep state per project and designate a writer for higher-level decisions. Publication locking does not resolve semantic conflicts or grant authority. MODULE_BOUNDARY.md and DEVELOPMENT_GUIDANCE.md define that separation. Retain original artifact bytes separately when byte identity matters; canonical records can retain hashes and locations.

## Repository and build provenance

This source repository is prepared from the validated 0.1.1 build. The Python
distribution remains `durable-workspace-development-kit` and the CLI is `dwsk`.
See BUILD_REPORT.md for actual installed-wheel checks. docs/build/ARTIFACTS.json
and docs/build/SHA256SUMS retain hashes of the original built distributions;
those binaries are not stored in this source repository. The build report records
the local build at its stated date, rather than subsequent repository activity.
Repository files are covered by SOURCE_SHA256SUMS.
