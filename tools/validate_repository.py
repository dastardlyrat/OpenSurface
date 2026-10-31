# SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
# SPDX-License-Identifier: MIT

from __future__ import annotations

import hashlib
import re
import sys
from pathlib import Path
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "SOURCE_MANIFEST.sha256"

EXPECTED_EFFECTS = {
    "Camera Obscura/External Image Denoiser/reshade-shaders/Shaders/camera_obscura_external/effects/CAMERA_OBSCURA_ExternalImageDenoiseV1.fx",
    "Camera Obscura/Guided Detail/effects/OSCO_GuidedDetailReclamation.fx",
    "Camera Obscura/Guided Detail/effects/OSCO_GuidedInkLines.fx",
    "Camera Obscura/Stabilized Detail Cache/effects/CAMERA_OBSCURA_StabilizedDetailCacheV1.fx",
    "Camera Obscura/Lazara Color Revival/effects/OSCO_LazaraColorRevival.fx",
}

EXPECTED_TECHNIQUES = {
    "CAMERA_OBSCURA_ExternalImageDenoiseV1",
    "OSCO_GuidedDetailReclamation",
    "OSCO_GuidedInkLines",
    "CAMERA_OBSCURA_StabilizedDetailCaptureV1",
    "CAMERA_OBSCURA_StabilizedDetailReapplyV1",
    "OSCO_LazaraColorRevival",
}


def digest(path: Path) -> str:
    hasher = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            hasher.update(block)
    return hasher.hexdigest().upper()


def source_files() -> list[Path]:
    return sorted(
        (path for path in ROOT.rglob("*") if path.suffix.lower() in {".fx", ".fxh"}),
        key=lambda path: path.as_posix().lower(),
    )


def relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def report(name: str, passed: bool, detail: str) -> bool:
    print(f"{'PASS' if passed else 'FAIL'}|{name}|{detail}")
    return passed


def validate_include_closure(files: list[Path]) -> tuple[bool, str]:
    missing: list[str] = []
    include_pattern = re.compile(r'^\s*#include\s+"([^"]+)"', re.MULTILINE)
    for path in files:
        text = path.read_text(encoding="utf-8")
        for include in include_pattern.findall(text):
            if include == "ReShade.fxh":
                continue
            target = (path.parent / include).resolve()
            if not target.is_file():
                missing.append(f"{relative(path)} -> {include}")
    return not missing, "zero missing local includes" if not missing else "; ".join(missing)


def validate_manifest() -> tuple[bool, str]:
    if not MANIFEST.is_file():
        return False, "SOURCE_MANIFEST.sha256 is missing"

    expected: dict[str, str] = {}
    for line in MANIFEST.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        hash_value, path_value = line.split("  ", 1)
        expected[path_value] = hash_value.upper()

    actual = {relative(path): digest(path) for path in source_files()}
    missing = sorted(set(expected) - set(actual))
    extra = sorted(set(actual) - set(expected))
    changed = sorted(path for path in expected.keys() & actual.keys() if expected[path] != actual[path])
    passed = not missing and not extra and not changed
    detail = f"entries={len(actual)}; missing={len(missing)}; extra={len(extra)}; changed={len(changed)}"
    return passed, detail


def validate_publication_boundary() -> tuple[bool, str]:
    denied_directories = {
        "backup",
        "evidence",
        "inbox",
        "mill",
        "outbox",
        "recovery",
        "staging",
    }
    denied_suffixes = {".bak", ".ini", ".log", ".zip"}
    text_suffixes = {
        "",
        ".csv",
        ".fx",
        ".fxh",
        ".json",
        ".md",
        ".py",
        ".sha256",
        ".toml",
        ".txt",
    }
    private_patterns = {
        "windows_user_path": re.compile(r"[A-Za-z]:\\Users\\", re.IGNORECASE),
        "steam_library_path": re.compile(r"[A-Za-z]:\\SteamLibrary\\", re.IGNORECASE),
        "private_username": re.compile("private" + "user", re.IGNORECASE),
        "application_data_path": re.compile(r"AppData[\\/]", re.IGNORECASE),
        "codex_private_path": re.compile(r"\.codex[\\/]", re.IGNORECASE),
        "github_classic_token": re.compile(r"ghp_[A-Za-z0-9]{20,}"),
        "github_fine_grained_token": re.compile(r"github_pat_[A-Za-z0-9_]{20,}"),
        "aws_access_key": re.compile(r"AKIA[0-9A-Z]{16}"),
        "private_key": re.compile(r"BEGIN [A-Z ]*PRIVATE KEY"),
    }

    denied_paths: list[str] = []
    private_hits: list[str] = []
    for path in sorted(ROOT.rglob("*")):
        if not path.is_file() or ".git" in path.parts:
            continue
        rel = relative(path)
        lowered_parts = {part.lower() for part in path.relative_to(ROOT).parts[:-1]}
        if lowered_parts & denied_directories or path.suffix.lower() in denied_suffixes:
            denied_paths.append(rel)
        if path.suffix.lower() not in text_suffixes:
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            private_hits.append(f"{rel}:non_utf8_text")
            continue
        for name, pattern in private_patterns.items():
            if pattern.search(text):
                private_hits.append(f"{rel}:{name}")

    required_package_files = [
        ROOT / "Camera Obscura" / "External Image Denoiser" / "LICENSE",
        ROOT / "Camera Obscura" / "External Image Denoiser" / "README.md",
        ROOT / "Camera Obscura" / "External Image Denoiser" / "reshade-shaders" / "Shaders"
        / "camera_obscura_external" / "api" / "CAMERA_OBSCURA_API_ExternalImageDenoise.fxh",
        ROOT / "Camera Obscura" / "External Image Denoiser" / "reshade-shaders" / "Shaders"
        / "camera_obscura_external" / "effects" / "CAMERA_OBSCURA_ExternalImageDenoiseV1.fx",
        ROOT / "PUBLISHING.md",
    ]
    missing = [relative(path) for path in required_package_files if not path.is_file()]
    passed = not denied_paths and not private_hits and not missing
    detail = (
        "clean public tree; denoiser package is independently installable"
        if passed
        else f"denied_paths={denied_paths}; private_hits={private_hits}; missing={missing}"
    )
    return passed, detail


def main() -> int:
    files = source_files()
    effects = {relative(path) for path in files if path.suffix.lower() == ".fx"}
    all_text = "\n".join(path.read_text(encoding="utf-8") for path in files)
    techniques = set(re.findall(r"\btechnique\s+([A-Za-z_][A-Za-z0-9_]*)", all_text))

    lazara_root = ROOT / "Camera Obscura" / "Lazara Color Revival"
    lazara_files = sorted(lazara_root.rglob("*.fx")) + sorted(lazara_root.rglob("*.fxh"))
    lazara_text = "\n".join(path.read_text(encoding="utf-8") for path in lazara_files)

    checks: list[bool] = []
    checks.append(report(
        "expected_effect_set",
        effects == EXPECTED_EFFECTS,
        f"effects={len(effects)}",
    ))
    checks.append(report(
        "expected_technique_set",
        techniques == EXPECTED_TECHNIQUES,
        f"techniques={sorted(techniques)}",
    ))

    boundary_passed, boundary_detail = validate_publication_boundary()
    checks.append(report("publication_boundary", boundary_passed, boundary_detail))

    include_passed, include_detail = validate_include_closure(files)
    checks.append(report("local_include_closure", include_passed, include_detail))

    bundled_reshade = [relative(path) for path in ROOT.rglob("ReShade.fxh")]
    checks.append(report(
        "external_reshade_dependency",
        not bundled_reshade,
        "ReShade.fxh is supplied by the installation" if not bundled_reshade else str(bundled_reshade),
    ))

    legacy_tokens = sorted(set(re.findall(r"\b(?:OCCULT|MIXSR)_[A-Za-z0-9_]+", lazara_text)))
    checks.append(report(
        "lazara_namespace_reduced",
        not legacy_tokens and "OSCO_LCR_" in lazara_text,
        "legacy symbols=0" if not legacy_tokens else f"legacy symbols={legacy_tokens}",
    ))

    lazara_headers = sorted(relative(path) for path in lazara_root.rglob("*.fxh"))
    checks.append(report(
        "lazara_minimal_header_capsule",
        len(lazara_headers) == 2,
        f"headers={len(lazara_headers)}",
    ))

    license_tag = "SPDX-License-" + "Identifier: MIT"
    source_license_gaps = [
        relative(path)
        for path in files
        if "SPDX-FileCopyrightText:" not in path.read_text(encoding="utf-8")
        or license_tag not in path.read_text(encoding="utf-8")
    ]
    checks.append(report(
        "source_license_metadata",
        not source_license_gaps,
        "all active shader sources carry copyright and MIT SPDX metadata"
        if not source_license_gaps
        else f"missing={source_license_gaps}",
    ))

    required_license_files = [
        ROOT / "LICENSE",
        ROOT / "LICENSING.md",
        ROOT / "LICENSES" / "MIT.txt",
        ROOT / "LICENSES" / "LicenseRef-Documentation-Screenshot.txt",
        ROOT / "AUTHORS.md",
        ROOT / "THIRD_PARTY_NOTICES.md",
        ROOT / "REUSE.toml",
    ]
    missing_license_files = [relative(path) for path in required_license_files if not path.is_file()]
    checks.append(report(
        "publication_license_files",
        not missing_license_files,
        "canonical license, authorship, dependency, and REUSE files present"
        if not missing_license_files
        else f"missing={missing_license_files}",
    ))

    reuse_text = (ROOT / "REUSE.toml").read_text(encoding="utf-8")
    screenshot_boundary = (
        "Camera Obscura/Lazara Color Revival/docs/images/*.png" in reuse_text
        and "Camera Obscura/Guided Detail/docs/images/*.png" in reuse_text
        and "LicenseRef-Documentation-Screenshot" in reuse_text
        and "does not grant rights to reuse underlying" in
        (ROOT / "LICENSES" / "LicenseRef-Documentation-Screenshot.txt").read_text(encoding="utf-8")
    )
    checks.append(report(
        "screenshot_license_boundary",
        screenshot_boundary,
        "documentation screenshot is excluded from the MIT software grant",
    ))

    readmes = sorted(ROOT.rglob("README.md"))
    missing_images: list[str] = []
    attachment_images: list[str] = []
    markdown_image_pattern = re.compile(r"!\[[^\]]*\]\(([^)]+)\)")
    html_image_pattern = re.compile(r'<img\b[^>]*\bsrc="([^"]+)"', re.IGNORECASE)
    for readme in readmes:
        readme_text = readme.read_text(encoding="utf-8")
        references = markdown_image_pattern.findall(readme_text)
        references += html_image_pattern.findall(readme_text)
        for reference in references:
            if "github.com/user-attachments/" in reference:
                attachment_images.append(f"{relative(readme)} -> {reference}")
                continue
            if reference.startswith(("http://", "https://")):
                continue
            image_path = (readme.parent / unquote(reference)).resolve()
            if not image_path.is_file():
                missing_images.append(f"{relative(readme)} -> {reference}")
    image_links_pass = not missing_images and not attachment_images
    checks.append(report(
        "local_readme_images",
        image_links_pass,
        "all local README images resolve; no GitHub attachment dependency"
        if image_links_pass
        else f"missing={missing_images}; attachments={attachment_images}",
    ))

    missing_links: list[str] = []
    markdown_link_pattern = re.compile(r"(?<!!)\[[^\]]+\]\(([^)]+)\)")
    for readme in readmes:
        readme_text = readme.read_text(encoding="utf-8")
        for reference in markdown_link_pattern.findall(readme_text):
            target_reference = reference.split("#", 1)[0]
            if (
                not target_reference
                or target_reference.startswith(("http://", "https://", "mailto:"))
            ):
                continue
            target = (readme.parent / unquote(target_reference)).resolve()
            if not target.exists():
                missing_links.append(f"{relative(readme)} -> {reference}")
    checks.append(report(
        "local_readme_links",
        not missing_links,
        "all local README links resolve" if not missing_links else f"missing={missing_links}",
    ))

    root_readme = (ROOT / "README.md").read_text(encoding="utf-8")
    xosg_readme = (ROOT / "xOSG" / "README.md").read_text(encoding="utf-8")
    naked_shell_readme = (ROOT / "xOSG" / "Naked Shell" / "README.md").read_text(encoding="utf-8")
    durable_workspace_readme = (
        ROOT / "xOSG" / "amorphous-durable-ai-workspace" / "README.md"
    ).read_text(encoding="utf-8")
    synthetic_simulations_readme = (
        ROOT / "xOSG" / "Synthetic Simulations" / "README.md"
    ).read_text(encoding="utf-8")
    publication_identity = (
        "storefront, not a development dump" in root_readme
        and "OpenSurface Publishing Boundary" in (ROOT / "PUBLISHING.md").read_text(encoding="utf-8")
        and "expert Overlay System Gestalt" in xosg_readme
        and "AI instrumentation toolset" in xosg_readme
        and "natural-language command-line universal shell" in naked_shell_readme
        and "Amorphous Durable AI Workspace" in durable_workspace_readme
        and "Synthetic Simulations" in synthetic_simulations_readme
        and "deterministic AI control-plane simulation" in synthetic_simulations_readme
        and "can_launch: false" in synthetic_simulations_readme
        and "7BC0651F4432F55DE1A9877DCB800723D032DC5F865A616EA9EC51A7822B6DA0"
        in synthetic_simulations_readme
        and "3CC411DB83C68E33FC0C8201769EA217B99C45FC508A36A56D2E478DA7BDC15B"
        in synthetic_simulations_readme
        and "BC1087C3332E32EE7699AB2FB79BF99134260E32A56D0198ED2CFF612436D61C"
        in synthetic_simulations_readme
        and "14/15 manifest hashes match" in synthetic_simulations_readme
    )
    checks.append(report(
        "publication_and_xosg_identity",
        publication_identity,
        "publication purpose and xOSG identity are explicit",
    ))

    balanced = all(text.count("{") == text.count("}") for text in (path.read_text(encoding="utf-8") for path in files))
    checks.append(report("balanced_source_blocks", balanced, f"source files={len(files)}"))

    provenance = (ROOT / "docs" / "PROVENANCE.md").read_text(encoding="utf-8")
    revisions_present = all(
        revision in provenance
        for revision in (
            "68850554650abe22cca029a65f7a807b6b3b3047",
            "d6f80edec87178a9522fb6682765bf2a854f998f",
            "5B10BF3A81BD1A00AFCC379D6DCC00D18748FFCEAEC16093578A59EE197C3B4D",
            "15C9F5A91B8143F6FB539153EF280DE133F0B8843DBBD231FDFB189C2EC1F786",
        )
    )
    checks.append(report("source_provenance", revisions_present, "four source revisions recorded"))

    manifest_passed, manifest_detail = validate_manifest()
    checks.append(report("source_manifest", manifest_passed, manifest_detail))

    passed = sum(checks)
    failed = len(checks) - passed
    print(f"SUMMARY|passed={passed}|failed={failed}")
    return 0 if failed == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
