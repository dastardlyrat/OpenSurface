# Validation Record

Date: 2026-10-31

Truth state: local structural, integrity, compatibility-compiler, and strict
helper-compiler evidence. This is not a live ReShade runtime attestation.

## Repository validator

`python -B tools/validate_repository.py`

Result: 13/13 pass.

The checks cover:

- four expected effect files and five expected techniques;
- complete local include closure except external `ReShade.fxh`;
- no bundled ReShade framework header;
- no legacy `OCCULT` or `MIXSR` symbols in active Lazara source;
- exactly two Lazara-owned headers;
- balanced source blocks;
- three exact source revisions in the provenance ledger;
- source-manifest integrity.

The publication validator also requires inline SPDX copyright and MIT license
identifiers on every active shader source, canonical license texts, authorship
and third-party notices, and a non-software license boundary for screenshots.

## REUSE compliance

Tool: `reuse` 6.3.0

Specification: REUSE 3.3

Result: compliant.

- covered files with copyright information: 30/30;
- covered files with licensing information: 30/30;
- bad, deprecated, missing, unused, or malformed licenses: zero;
- used licenses: `MIT` and `LicenseRef-Documentation-Screenshot`.

## Import parity

- Guided Detail behavior source originates at revision
  `68850554650abe22cca029a65f7a807b6b3b3047`; only SPDX publication metadata was
  added after import.
- Stabilized Detail Cache effect and API match package SHA-256
  `5B10BF3A81BD1A00AFCC379D6DCC00D18748FFCEAEC16093578A59EE197C3B4D`.

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
- Lazara Color Revival requires a new live compile and side-by-side regression
  because its ownership and include topology changed.
