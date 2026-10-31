# Validation Record

Date: 2026-10-31

Truth state: local structural, integrity, compatibility-compiler, and strict
helper-compiler evidence. This is not a live ReShade runtime attestation.

## Repository validator

`python -B tools/validate_repository.py`

Result: 16/16 pass.

The checks cover:

- five expected effect files and six expected techniques;
- a clean public file boundary with an independently installable denoiser
  package and no raw evidence, archive, log, preset, or private-path material;
- complete local include closure except external `ReShade.fxh`;
- no bundled ReShade framework header;
- no legacy `OCCULT` or `MIXSR` symbols in active Lazara source;
- exactly two Lazara-owned headers;
- balanced source blocks;
- four exact source revisions in the provenance ledger;
- source-manifest integrity.
- local README image and document-link resolution.

The publication validator also requires inline SPDX copyright and MIT license
identifiers on every active shader source, canonical license texts, authorship
and third-party notices, a non-software license boundary for screenshots, and
local README image resolution without unavailable GitHub attachments.

## REUSE compliance

Tool: `reuse` 6.3.0

Specification: REUSE 3.3

Result: compliant.

- covered files with copyright information: 35/35;
- covered files with licensing information: 35/35;
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
