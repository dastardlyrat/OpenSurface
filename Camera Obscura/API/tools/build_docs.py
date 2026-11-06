#!/usr/bin/env python3
"""Build evidence-bounded Camera Obscura API declaration documentation."""

from __future__ import annotations

import argparse
import csv
import hashlib
import io
import json
import re
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
TRACK_ROOT = PROJECT_ROOT / "reshade-shaders" / "Shaders" / "camera_obscura"
API_ROOT = TRACK_ROOT / "api"
DOC_ROOT = PROJECT_ROOT / "docs"
UMBRELLA = "CAMERA_OBSCURA_API_All.fxh"


FILE_ROLES = {
    "CAMERA_OBSCURA_API_All.fxh": "Core API umbrella include.",
    "CAMERA_OBSCURA_API_Common.fxh": "Scaffold version, stage identifiers, context record, and context construction.",
    "CAMERA_OBSCURA_API_Services.fxh": "Capability, surface, direction, request, control, and ray-construction wrappers.",
    "CAMERA_OBSCURA_API_Providers.fxh": "Refined DDA and March traversal-provider wrappers.",
    "CAMERA_OBSCURA_API_Cohesion.fxh": "Dual-hit, contribution, fallback, resolve, and composite wrappers.",
    "CAMERA_OBSCURA_API_Debug.fxh": "Central debug-view wrapper.",
    "CAMERA_OBSCURA_API_Transmigration.fxh": "Mined-shape state and admission-gate record.",
}


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def line_number(source: str, offset: int) -> int:
    return source.count("\n", 0, offset) + 1


def extract_includes(source: str) -> list[dict[str, object]]:
    return [
        {"target": match.group(1), "line": line_number(source, match.start())}
        for match in re.finditer(r'^[ \t]*#include[ \t]+"([^"]+)"', source, re.MULTILINE)
    ]


def extract_macros(source: str) -> list[dict[str, object]]:
    macros: list[dict[str, object]] = []
    for match in re.finditer(
        r"^[ \t]*#define[ \t]+([A-Z][A-Z0-9_]+)(?:[ \t]+(.*?))?[ \t]*$",
        source,
        re.MULTILINE,
    ):
        name = match.group(1)
        macros.append(
            {
                "name": name,
                "value": (match.group(2) or "").strip(),
                "include_guard": name.endswith("_FXH"),
                "line": line_number(source, match.start()),
            }
        )
    return macros


def extract_structs(source: str) -> list[dict[str, object]]:
    structs: list[dict[str, object]] = []
    pattern = re.compile(
        r"^[ \t]*struct[ \t]+([A-Za-z_]\w*)\s*\{(.*?)^[ \t]*\};",
        re.MULTILINE | re.DOTALL,
    )
    field_pattern = re.compile(
        r"^[ \t]*([A-Za-z_]\w*)[ \t]+([A-Za-z_]\w*)(?:[ \t]*\[[ \t]*([^\]]+)[ \t]*\])?[ \t]*;",
        re.MULTILINE,
    )
    for match in pattern.finditer(source):
        body = match.group(2)
        body_offset = match.start(2)
        fields = []
        for field in field_pattern.finditer(body):
            array_extent = field.group(3)
            fields.append(
                {
                    "type": field.group(1),
                    "name": field.group(2),
                    "array_extent": array_extent,
                    "line": line_number(source, body_offset + field.start()),
                }
            )
        structs.append(
            {
                "name": match.group(1),
                "line": line_number(source, match.start()),
                "fields": fields,
            }
        )
    return structs


def extract_functions(source: str) -> list[dict[str, object]]:
    pattern = re.compile(
        r"^[ \t]*(?!(?:return|else|if|for|while|switch)\b)(?:static[ \t]+|inline[ \t]+)?([A-Za-z_]\w*)[ \t]+([A-Za-z_]\w*)[ \t]*\((.*?)\)\s*\{",
        re.MULTILINE | re.DOTALL,
    )
    functions = []
    for match in pattern.finditer(source):
        parameters = " ".join(match.group(3).split())
        functions.append(
            {
                "return_type": match.group(1),
                "name": match.group(2),
                "parameters": parameters,
                "signature": f"{match.group(1)} {match.group(2)}({parameters})",
                "line": line_number(source, match.start()),
            }
        )
    return functions


def extract_resources(source: str) -> list[dict[str, object]]:
    pattern = re.compile(
        r"^[ \t]*((?:texture|sampler|storage)[A-Za-z0-9_]*)[ \t]+([A-Za-z_]\w*)[ \t]*(?:\{|;)",
        re.MULTILINE,
    )
    return [
        {
            "kind": match.group(1),
            "name": match.group(2),
            "line": line_number(source, match.start()),
        }
        for match in pattern.finditer(source)
    ]


def source_paths() -> list[Path]:
    return sorted(API_ROOT.glob("*.fxh"), key=lambda path: path.name.lower())


def umbrella_members(entries: list[dict[str, object]]) -> set[str]:
    graph: dict[str, list[str]] = {}
    names = {str(entry["file"]) for entry in entries}
    for entry in entries:
        graph[str(entry["file"])] = [
            Path(str(include["target"])).name
            for include in entry["includes"]
            if Path(str(include["target"])).name in names
        ]
    visited: set[str] = set()
    pending = [UMBRELLA]
    while pending:
        current = pending.pop()
        if current in visited:
            continue
        visited.add(current)
        pending.extend(graph.get(current, []))
    return visited


def build_index() -> dict[str, object]:
    entries: list[dict[str, object]] = []
    for path in source_paths():
        source = path.read_text(encoding="utf-8-sig")
        includes = extract_includes(source)
        for include in includes:
            resolved = (path.parent / str(include["target"])).resolve()
            include["resolved"] = (
                resolved.relative_to(PROJECT_ROOT).as_posix()
                if resolved.is_relative_to(PROJECT_ROOT)
                else str(resolved)
            )
            include["exists"] = resolved.is_file()
        entries.append(
            {
                "file": path.name,
                "path": path.relative_to(PROJECT_ROOT).as_posix(),
                "sha256": sha256(path),
                "bytes": path.stat().st_size,
                "lines": len(source.splitlines()),
                "includes": includes,
                "macros": extract_macros(source),
                "structs": extract_structs(source),
                "functions": extract_functions(source),
                "resources": extract_resources(source),
            }
        )

    members = umbrella_members(entries)
    for entry in entries:
        name = str(entry["file"])
        if name == UMBRELLA:
            classification = "CORE_UMBRELLA"
        elif name in members:
            classification = "CORE_UMBRELLA_MEMBER"
        else:
            classification = "SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA"
        entry["classification"] = classification
        entry["role"] = FILE_ROLES.get(
            name,
            "Additional API/evidence/proof source; lifecycle must be resolved from system records.",
        )

    summary = {
        "source_files": len(entries),
        "core_umbrella_files": len(members),
        "source_present_not_in_core_umbrella": len(entries) - len(members),
        "includes": sum(len(entry["includes"]) for entry in entries),
        "unresolved_includes": sum(
            1
            for entry in entries
            for include in entry["includes"]
            if not include["exists"]
        ),
        "macros": sum(len(entry["macros"]) for entry in entries),
        "structs": sum(len(entry["structs"]) for entry in entries),
        "struct_fields": sum(
            len(struct["fields"])
            for entry in entries
            for struct in entry["structs"]
        ),
        "functions": sum(len(entry["functions"]) for entry in entries),
        "resources": sum(len(entry["resources"]) for entry in entries),
    }
    return {
        "schema": "camera-obscura-api-symbol-index-v0.1",
        "documentation_status": "STARTED_NOT_SEMANTICALLY_COMPLETE",
        "source_root": API_ROOT.relative_to(PROJECT_ROOT).as_posix(),
        "source_authority": "hosted OpenSurface development API snapshot; not the accepted frozen runtime rail",
        "truth_states": {
            "declarations": "SOURCE",
            "hashes_and_counts": "DERIVED",
            "umbrella_membership": "DERIVED_FROM_INCLUDE_GRAPH",
            "file_roles": "GENERATED_SYNTHESIS_BOUNDED_BY_SOURCE",
        },
        "summary": summary,
        "sources": entries,
    }


def inventory_csv(index: dict[str, object]) -> str:
    output = io.StringIO(newline="")
    fields = [
        "Identifier",
        "Location",
        "Type",
        "VersionStatus",
        "Authority",
        "Accessibility",
        "IntegritySHA256",
        "Relevance",
        "UmbrellaStatus",
    ]
    writer = csv.DictWriter(output, fieldnames=fields, lineterminator="\n")
    writer.writeheader()
    for source in index["sources"]:
        writer.writerow(
            {
                "Identifier": source["file"],
                "Location": source["path"],
                "Type": "ReShade FX header",
                "VersionStatus": "source-present; consult system registry for lifecycle",
                "Authority": "hosted development snapshot; not frozen runtime canon",
                "Accessibility": "readable",
                "IntegritySHA256": source["sha256"],
                "Relevance": source["role"],
                "UmbrellaStatus": source["classification"],
            }
        )
    return output.getvalue()


def declaration_reference(index: dict[str, object]) -> str:
    summary = index["summary"]
    lines = [
        "# Camera Obscura API Declaration Reference",
        "",
        "Status: **generated declaration inventory; semantic documentation is incomplete**.",
        "",
        "This reference is generated from the current development headers under",
        "`reshade-shaders/Shaders/camera_obscura/api`. Exact declarations are `SOURCE`; hashes,",
        "counts, and umbrella reachability are `DERIVED`. File-role summaries are bounded",
        "`GENERATED_SYNTHESIS`. Hosting does not promote the scaffold to frozen runtime canon.",
        "",
        "## Coverage",
        "",
        f"- Source files: **{summary['source_files']}**",
        f"- Core umbrella files: **{summary['core_umbrella_files']}**",
        f"- Source-present headers outside the core umbrella: **{summary['source_present_not_in_core_umbrella']}**",
        f"- Includes: **{summary['includes']}** ({summary['unresolved_includes']} unresolved)",
        f"- Macros: **{summary['macros']}**",
        f"- Structs: **{summary['structs']}**",
        f"- Struct fields: **{summary['struct_fields']}**",
        f"- Functions: **{summary['functions']}**",
        f"- Resources: **{summary['resources']}**",
        "",
        "The tables below prove declaration coverage, not semantic correctness, stable",
        "public-API status, compilation, runtime behavior, performance, or visual quality.",
        "",
    ]
    for source in index["sources"]:
        lines.extend(
            [
                f"## `{source['file']}`",
                "",
                f"Classification: `{source['classification']}`  ",
                f"Role: {source['role']}  ",
                f"Source: [`{source['path']}`](../{source['path']})  ",
                f"SHA-256: `{source['sha256']}`",
                "",
            ]
        )
        if source["includes"]:
            lines.extend(["### Includes", "", "| Line | Target | Resolved | Exists |", "|---:|---|---|---:|"])
            for include in source["includes"]:
                lines.append(
                    f"| {include['line']} | `{include['target']}` | `{include['resolved']}` | "
                    f"{'yes' if include['exists'] else 'no'} |"
                )
            lines.append("")
        if source["macros"]:
            lines.extend(["### Macros", "", "| Line | Name | Value | Kind |", "|---:|---|---|---|"])
            for macro in source["macros"]:
                value = macro["value"] or "—"
                kind = "include guard" if macro["include_guard"] else "constant"
                lines.append(f"| {macro['line']} | `{macro['name']}` | `{value}` | {kind} |")
            lines.append("")
        for struct in source["structs"]:
            lines.extend(
                [
                    f"### Struct `{struct['name']}`",
                    "",
                    "Field meanings are not yet asserted here unless covered by the hand-written core reference.",
                    "",
                    "| Line | Scoped field | Type |",
                    "|---:|---|---|",
                ]
            )
            for field in struct["fields"]:
                field_type = field["type"]
                if field["array_extent"]:
                    field_type += f"[{field['array_extent']}]"
                lines.append(
                    f"| {field['line']} | `{struct['name']}.{field['name']}` | `{field_type}` |"
                )
            lines.append("")
        if source["functions"]:
            lines.extend(["### Functions", "", "| Line | Exact signature | Semantic status |", "|---:|---|---|"])
            for function in source["functions"]:
                status = "documented in `CORE_REFERENCE.md`" if source["file"] in FILE_ROLES else "not yet semantically documented"
                lines.append(f"| {function['line']} | `{function['signature']}` | {status} |")
            lines.append("")
        if source["resources"]:
            lines.extend(["### Resources", "", "| Line | Declaration |", "|---:|---|"])
            for resource in source["resources"]:
                lines.append(f"| {resource['line']} | `{resource['kind']} {resource['name']}` |")
            lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def generated_outputs() -> dict[Path, str]:
    index = build_index()
    return {
        DOC_ROOT / "SOURCE_INVENTORY.csv": inventory_csv(index),
        DOC_ROOT / "SYMBOLS.json": json.dumps(index, indent=2) + "\n",
        DOC_ROOT / "DECLARATIONS.md": declaration_reference(index),
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    outputs = generated_outputs()
    if args.check:
        failed = False
        for path, expected in outputs.items():
            current = path.read_text(encoding="utf-8") if path.is_file() else ""
            if current != expected:
                print(f"FAIL|generated_current|{path}")
                failed = True
            else:
                print(f"PASS|generated_current|{path}")
        return 1 if failed else 0
    DOC_ROOT.mkdir(parents=True, exist_ok=True)
    for path, content in outputs.items():
        path.write_text(content, encoding="utf-8", newline="\n")
        print(f"WROTE|{path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
