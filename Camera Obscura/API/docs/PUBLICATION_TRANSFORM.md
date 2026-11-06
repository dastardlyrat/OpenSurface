# Publication Transform

The hosted API is a clean public export of the reviewed Camera Obscura current
development tree.

## Source set

- 29 files from the source `camera_obscura/api` directory
- nine files from the adjacent source `camera_obscura/header` directory
- source identities recorded in `SOURCE_ORIGIN.sha256`

## Authorized public transform

Each hosted `.fxh` file prepends exactly:

```text
// SPDX-FileCopyrightText: 2026 dastardlyrat and OpenSurface contributors
// SPDX-License-Identifier: MIT

```

The remaining implementation bytes must hash to the corresponding entry in
`SOURCE_ORIGIN.sha256`. `tools/validate_package.py` strips the exact prefix and
checks that parity for every hosted header.

Documentation paths and generated hashes are regenerated against the public
layout. Those documentation changes do not change shader implementation.

## Generated additions

Three example consumers are newly authored publication material rather than
recovered source. They remain outside the install tree and use the dormant
`.fx.example` suffix. Their role is to demonstrate explicit core, Twin Lantern
parity, and bounded-composite adoption; they are not included in the 38-file
origin-parity claim.

## Exclusions

The export does not include loadable effects, presets, compiler logs, runtime logs,
private workshop records, mill artifacts, inbox or outbox packages, machine
paths, credentials, or the accepted frozen runtime tree.

## Authority boundary

Publication authorizes hosting and MIT distribution of this snapshot. It does
not declare every source-present symbol stable, wire cold receptors through the
core umbrella, supersede the frozen runtime rail, or establish compile/runtime
acceptance.
