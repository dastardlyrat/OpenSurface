#!/usr/bin/env python3
"""Validate the hosted Camera Obscura API publication package."""

from __future__ import annotations

import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path
from urllib.parse import unquote


PROJECT_ROOT = Path(__file__).resolve().parents[1]
SHADER_ROOT = PROJECT_ROOT / "reshade-shaders" / "Shaders" / "camera_obscura"
API_ROOT = SHADER_ROOT / "api"
HEADER_ROOT = SHADER_ROOT / "header"
DOC_ROOT = PROJECT_ROOT / "docs"
ORIGIN_MANIFEST = DOC_ROOT / "SOURCE_ORIGIN.sha256"
SPDX_LICENSE_MARKER = "SPDX-" + "License-Identifier:"
PUBLICATION_PREFIX = (
    b"// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors\n"
    + f"// {SPDX_LICENSE_MARKER} MIT\n\n".encode("ascii")
)


def relative(path: Path) -> str:
    return path.relative_to(PROJECT_ROOT).as_posix()


def digest_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest().upper()


def report(name: str, passed: bool, detail: str) -> bool:
    print(f"{'PASS' if passed else 'FAIL'}|{name}|{detail}")
    return passed


def shader_files() -> list[Path]:
    return sorted(SHADER_ROOT.rglob("*.fxh"), key=lambda path: relative(path).lower())


def load_origin_manifest() -> dict[str, str]:
    entries: dict[str, str] = {}
    if not ORIGIN_MANIFEST.is_file():
        return entries
    for line in ORIGIN_MANIFEST.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        hash_value, path_value = line.split("  ", 1)
        entries[path_value] = hash_value.upper()
    return entries


def validate_origin_parity(files: list[Path]) -> tuple[bool, str]:
    expected = load_origin_manifest()
    actual_paths = {relative(path) for path in files}
    missing = sorted(set(expected) - actual_paths)
    extra = sorted(actual_paths - set(expected))
    changed: list[str] = []
    prefix_failures: list[str] = []
    for path in files:
        rel = relative(path)
        data = path.read_bytes()
        if not data.startswith(PUBLICATION_PREFIX):
            prefix_failures.append(rel)
            continue
        implementation = data[len(PUBLICATION_PREFIX) :]
        if expected.get(rel) != digest_bytes(implementation):
            changed.append(rel)
    passed = bool(expected) and not missing and not extra and not changed and not prefix_failures
    return (
        passed,
        f"entries={len(files)}; missing={len(missing)}; extra={len(extra)}; "
        f"implementation_changed={len(changed)}; prefix_failures={len(prefix_failures)}",
    )


def validate_include_closure(files: list[Path]) -> tuple[bool, str]:
    include_pattern = re.compile(r'^\s*#include\s+"([^"]+)"', re.MULTILINE)
    missing: list[str] = []
    includes = 0
    for path in files:
        text = path.read_text(encoding="utf-8")
        for include in include_pattern.findall(text):
            includes += 1
            if include == "ReShade.fxh":
                continue
            target = (path.parent / include).resolve()
            if not target.is_file():
                missing.append(f"{relative(path)} -> {include}")
    return not missing, f"includes={includes}; missing={len(missing)}"


def validate_links() -> tuple[bool, str]:
    markdown_link = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
    broken: list[str] = []
    documents = sorted([PROJECT_ROOT / "README.md", *DOC_ROOT.glob("*.md")])
    for document in documents:
        text = document.read_text(encoding="utf-8")
        for reference in markdown_link.findall(text):
            if re.match(r"^(?:https?://|mailto:|#)", reference):
                continue
            path_value = reference.split("#", 1)[0].strip("<>")
            if not path_value:
                continue
            target = (document.parent / unquote(path_value)).resolve()
            if not target.exists():
                broken.append(f"{relative(document)} -> {reference}")
    return not broken, f"documents={len(documents)}; broken={len(broken)}"


def validate_public_boundary() -> tuple[bool, str]:
    patterns = {
        "windows_user_path": re.compile(r"[A-Za-z]:\\Users\\", re.IGNORECASE),
        "private_username": re.compile("private" + "user", re.IGNORECASE),
        "application_data": re.compile(r"AppData[\\/]", re.IGNORECASE),
        "github_token": re.compile(r"(?:ghp_|github_pat_)[A-Za-z0-9_]{20,}"),
        "private_key": re.compile(r"BEGIN [A-Z ]*PRIVATE KEY"),
    }
    hits: list[str] = []
    for path in sorted(PROJECT_ROOT.rglob("*")):
        if not path.is_file():
            continue
        if path.suffix.lower() not in {"", ".csv", ".fxh", ".json", ".md", ".py", ".sha256", ".txt"}:
            continue
        text = path.read_text(encoding="utf-8")
        for name, pattern in patterns.items():
            if pattern.search(text):
                hits.append(f"{relative(path)}:{name}")
    return not hits, f"private_hits={len(hits)}"


def main() -> int:
    files = shader_files()
    api_files = sorted(API_ROOT.glob("*.fxh"))
    header_files = sorted(HEADER_ROOT.glob("*.fxh"))
    checks: list[bool] = []

    checks.append(report(
        "expected_hosted_surface",
        len(api_files) == 29 and len(header_files) == 9 and len(files) == 38,
        f"api={len(api_files)}; support={len(header_files)}; total={len(files)}",
    ))

    origin_passed, origin_detail = validate_origin_parity(files)
    checks.append(report("origin_implementation_parity", origin_passed, origin_detail))

    include_passed, include_detail = validate_include_closure(files)
    checks.append(report("local_include_closure", include_passed, include_detail))

    spdx_gaps = [
        relative(path)
        for path in files
        if f"{SPDX_LICENSE_MARKER} MIT" not in path.read_text(encoding="utf-8")
    ]
    checks.append(report(
        "source_license_metadata",
        not spdx_gaps,
        f"covered={len(files) - len(spdx_gaps)}/{len(files)}",
    ))

    build_docs = PROJECT_ROOT / "tools" / "build_docs.py"
    generated = subprocess.run(
        [sys.executable, "-B", str(build_docs), "--check"],
        cwd=PROJECT_ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    checks.append(report(
        "generated_documentation_current",
        generated.returncode == 0,
        "SOURCE_INVENTORY, SYMBOLS, and DECLARATIONS match source"
        if generated.returncode == 0
        else generated.stdout.strip() or generated.stderr.strip(),
    ))

    index_path = DOC_ROOT / "SYMBOLS.json"
    index = json.loads(index_path.read_text(encoding="utf-8"))
    summary = index["summary"]
    expected_summary = {
        "source_files": 29,
        "core_umbrella_files": 7,
        "source_present_not_in_core_umbrella": 22,
        "includes": 41,
        "unresolved_includes": 0,
        "macros": 170,
        "structs": 24,
        "struct_fields": 611,
        "functions": 120,
        "resources": 0,
    }
    checks.append(report(
        "declaration_inventory",
        summary == expected_summary,
        ", ".join(f"{name}={summary.get(name)}" for name in expected_summary),
    ))

    links_passed, links_detail = validate_links()
    checks.append(report("local_documentation_links", links_passed, links_detail))

    boundary_passed, boundary_detail = validate_public_boundary()
    checks.append(report("publication_boundary", boundary_passed, boundary_detail))

    required = [
        PROJECT_ROOT / "README.md",
        PROJECT_ROOT / "LICENSE",
        DOC_ROOT / "CORE_REFERENCE.md",
        DOC_ROOT / "DECLARATIONS.md",
        DOC_ROOT / "SOURCE_INVENTORY.csv",
        DOC_ROOT / "SOURCE_ORIGIN.sha256",
        DOC_ROOT / "SYMBOLS.json",
        DOC_ROOT / "VALIDATION.md",
    ]
    missing_required = [relative(path) for path in required if not path.is_file()]
    checks.append(report(
        "package_artifacts",
        not missing_required,
        f"required={len(required)}; missing={len(missing_required)}",
    ))

    passed = sum(checks)
    failed = len(checks) - passed
    print(f"SUMMARY|passed={passed}|failed={failed}")
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    raise SystemExit(main())
