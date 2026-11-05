# Validation Record

## Current-tree relocation — 2026-11-05

The xOSG family now lives in [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg). The source cleanup removes its current working tree only after destination verification. The records below describe their dated earlier source states; their counts do not describe the remaining OpenSurface file inventory. The migration validation summary records fresh fixed DWSK checks. Camera Obscura source and its live runtime gates are unchanged.

Date: 2026-11-01

Truth state: local structural, integrity, compatibility-compiler, and strict
helper-compiler evidence. This is not a live ReShade runtime attestation.

## Repository validator

`python -B tools/validate_repository.py`

Result: 19/19 pass.

The checks cover:

- five expected effect files and six expected techniques;
- the README's four-unit, five-effect, six-support-file, and six-technique
  inventory against the current tree;
- the separate Revival-package boundary for the Stabilized Color and Luma
  caches, including their public source links and nonlocal status;
- a clean public file boundary with an independently installable denoiser
  package and no raw evidence, archive, log, preset, or private-path material;
- complete local include closure except external `ReShade.fxh`;
- no bundled ReShade framework header;
- no legacy `OCCULT` or `MIXSR` symbols in active Lazara source;
- exactly two Lazara-owned headers;
- balanced source blocks;
- four exact source revisions in the provenance ledger;
- source-manifest integrity;
- sanitized Synthetic Simulations failure-record identity and exclusion state;
- local README image and document-link resolution.

The publication validator also requires inline SPDX copyright and MIT license
identifiers on every active shader source, canonical license texts, authorship
and third-party notices, a non-software license boundary for screenshots, and
local README image resolution without unavailable GitHub attachments.

## REUSE compliance

Tool: `reuse` 6.3.0

Specification: REUSE 3.3

Result: compliant.

- covered files with copyright information: 68/68;
- covered files with licensing information: 68/68;
- bad, deprecated, missing, unused, or malformed licenses: zero;
- used licenses: `MIT` and `LicenseRef-Documentation-Screenshot`.

## Import parity

- Guided Detail behavior source originates at revision
  `68850554650abe22cca029a65f7a807b6b3b3047`; only SPDX publication metadata was
  added after import.
- Stabilized Detail Cache effect and API match package SHA-256
  `5B10BF3A81BD1A00AFCC379D6DCC00D18748FFCEAEC16093578A59EE197C3B4D`.
- External Image Denoiser V2.1 originates from the accepted package with
  SHA-256
  `15C9F5A91B8143F6FB539153EF280DE133F0B8843DBBD231FDFB189C2EC1F786`;
  publication-only SPDX metadata was added to its shader sources.

## External Image Denoiser checks

Private source-package validator, retained outside the storefront:

`python -B validate_external_denoiser_v1.py`

Result: 30/30 pass against the accepted source package.

The focused checks cover local include closure, denoiser-only ownership,
complete record initialization, bounded controls, seven managed full-resolution
resources, ordered filtering and history capture, requested-UV admission,
depth-aware history rejection, all 32 scale-response combinations, bounded
multiscale reconstruction, exact zero bypasses, display-only tinting, package
and ZIP parity, and fresh FXC `/Gec` plus `/Ges /WX` compilation.

## Publication sanitation

The public tree is checked for private Windows user paths, Steam installation
paths, application-data paths, private account-name markers, common credential
forms, private-key headers, raw evidence directories, logs, presets, backup
files, and package archives. The current publication tree passes this check.

Raw validation records and exploratory worksheets remain in private source
custody. Accepted facts are carried into this bounded summary instead of
publishing the workshop artifacts themselves.

## Lazara refactor compiler checks

- ReShade-compatible resource and helper harness: FXC `/Gec`, pass.
- Pure color and diagnostic helper harness: FXC `/Ges /WX`, pass.

Microsoft FXC does not compile complete ReShade effect syntax. Full
`OSCO_LazaraColorRevival.fx` compilation and visual equivalence remain live
ReShade gates.

## Amorphous Durable AI Workspace checks

### R4 source-adoption review — 2026-11-04

The R4 repairs were adopted into the DWSK 0.1.1 source base in this private review branch, preserving the newer repository work. Exact runtime/checker and helper identity checks accompanied fresh ordinary and optimized qualification on Windows.

- R4 suite: 122/122 per mode, 244 checks total, covering recovery, value admission, worker cleanup, checker controls, units and self-checks.
- Added fixed development runner: 17 units plus seven self-checks per mode, 48 overlapping checks total.
- Required acceptance: exact test identities/counts, actual mode, intended refusal cause and complete owned cleanup evidence.
- Source inventory: regenerated against the adopted curated bytes; it excludes its own checksum file.

The [component validation report](https://github.com/alia-june/xOSG-prototype/blob/main/amorphous-durable-ai-workspace/VALIDATION_REPORT.md) describes the set and limits. The [development runner](https://github.com/alia-june/xOSG-prototype/blob/main/amorphous-durable-ai-workspace/tools/validation/README.md) runs only the fixed unit/self-check suites. The full fault campaign's raw evidence remains in private custody and is not included in this tree.

These are source-adoption checks, not a fresh binary release. The older 2026-10-31 source/install results, initial import-path invocation failure and original binary identifiers remain historical evidence in the component reports. This adoption does not reproduce the historical fuzzy/installed/native-mutex campaigns or establish physical power-loss durability, every supported OS/interpreter, external-tool isolation or logger/application integration.

## Runtime evidence

- Guided Detail retains its source repository's recorded evidence boundary.
- Stabilized Detail Cache has a user-reported clean compile and strong visual
  pass on 2026-10-31.
- External Image Denoiser application and the Detail Reclamation then final
  denoiser order were user-confirmed before publication. Broader motion,
  performance, ghosting, scale, and artifact acceptance remain open runtime
  gates.
- Lazara Color Revival requires a new live compile and side-by-side regression
  because its ownership and include topology changed.

## Synthetic Simulations evidence

The private `deterministic_ai_control_plane_v0_4` source suite was rerun on
2026-10-31 with Python bytecode generation disabled:

`python -B -W error -m unittest discover -s tests -v`

Result: 31/31 pass.

The exercised behaviors include closed-contract rejection, confined source
hashing, deterministic profile closure, non-authorizing planning, non-launching
agent setup, bounded retry, cooperative termination, one-line terminal JSON,
synthetic-role topology, deterministic trace hashes, malicious-request
non-echo, and fail-closed invalid setup or request handling.

This is source-basis evidence for the public documentation. Synthetic
Simulations code is not yet included in the storefront, and these tests do not
prove real model behavior, OS isolation, authenticated authority, semantic
correctness, crash-safe terminal reporting, or production safety.

Two supplied memory-instrumentation ZIPs were also checked in private intake.
Both passed CRC, normalized-path, absolute-path, parent-traversal, link, unsafe
character, and case-collision checks. A bounded residue scan found no private
machine paths, common credential forms, or email addresses.

The atomized v2 package failed exact manifest validation: 14 of 15 listed files
matched. Its `12_validation_report.json` member has SHA-256
`3795c4ace9df9b07a61eab310d1c217f7f83571eba77f5cb51a353b562a3f900`,
while the manifest records
`1e5540eeea3f52d3148ef4cb2a2d6b9db62b6915080ba8193690a7d364a939df`.
Neither candidate contains a license grant. Both remain excluded from the
public tree pending correction, ownership and licensing confirmation, and a
deeper privacy review.

### Defunct prompt-hardening candidate

`llm_prompt_hardening_modular_kit_v1_5_candidate.zip` was inspected in private
intake after the user classified it as a failed experiment.

- SHA-256:
  `D88D0740CD50011F3EC05C6645329D3C6A766755B0AA7A6B005335CEDE13FFE6`
- ZIP result: 79 members, CRC clean, zero unsafe paths.
- Manifest result: 78/78 listed members matched; zero missing, mismatched, or
  unlisted members other than the manifest itself.
- Retained package claim: 43/43 tests passed on Linux x86-64 with Python
  3.12.14 before archive construction.
- Fresh result: 42/43 tests passed on Windows with Python 3.14.4.
- Failure: `test_existing_build_requires_explicit_replace` expected mode
  `0644` after atomic replacement and observed `0666`.
- License result: no candidate-level license grant or SPDX expression was
  found. A nested vendor record's MIT statement does not license the candidate
  as a whole.

The current public tree contains only a generated failure summary and an
artifact receipt. The user has directed eventual cleaned-source publication as
a defunct experiment. Source import remains gated on license confirmation and
sanitation; the recursive raw archive, nested archives, and DOCX will not be
published as the source layout. Embedded candidate instructions were treated as
artifact content and were not executed as instructions.
