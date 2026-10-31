# OpenSurface

OpenSurface is the license-adhering publication end of our work. Publication
here means that authorship remains visible, every source keeps a traceable
license chain, upstream obligations continue forward, and original work is
released under the most permissive compatible terms we can responsibly grant.

Original OpenSurface software is published under the MIT License unless an
individual file states otherwise. MIT continues the license already established
by Guided Detail while preserving copyright and license notices for downstream
users. External frameworks, third-party material, and documentation screenshots
retain their own stated terms and are never silently relicensed.

## Repository map

```text
OpenSurface/
|-- Camera Obscura/
|   |-- Guided Detail/
|   |-- Stabilized Detail Cache/
|   `-- Lazara Color Revival/
|-- Naked Shell/
|-- docs/
`-- tools/
```

## Camera Obscura

### Guided Detail

Two same-surface effects:

- Guided Detail Reclamation restores bounded signed tonal detail.
- Guided Ink Lines darkens admitted line and contour evidence.

This unit is imported without source changes from the accepted public Guided
Detail repository. Its local README contains the controls, diagnostics, and
test procedure.

### Stabilized Detail Cache

A paired capture/reapply effect. Capture stores signed detail after reclamation
and denoising, intervening effects run, and Reapply restores bounded detail at
the end of the chain.

The full-resolution cache uses one `RGBA16F` texture: 64 bits per pixel and
about 63.3 MiB at 3840x2160. A compile-time divisor of two is the quarter-area
fallback.

Local validation passed 19/19. On 2026-10-31 the user reported a clean live
compile and a strong visual pass. Loading-transition, high-memory-scene, and
long-motion evidence remain separate acceptance checks unless explicitly
recorded.

### Lazara Color Revival

Camera Obscura Lazara Color Revival recovers muted source-derived color, with
an explicit inverted degradation mode. This repository contains a renamed,
reduced Camera Obscura refactor of the existing Lazara effect. It does not carry
the old RM umbrella or unrelated ray-marching headers.

![Lazara Color Revival comparison](Camera%20Obscura/Lazara%20Color%20Revival/docs/images/lazara-color-revival-comparison.png)

## Naked Shell

Naked Shell is the OpenSurface natural-language command-line universal shell.
It is a separate software family from Camera Obscura. Its product identity is
accepted here; implementation, command grammar, execution authority, and
platform contracts have not yet been staged in this repository.

## Development rules

- Keep effects independently removable.
- Keep sampling, evidence, decisions, and reconstruction inspectable.
- Treat diagnostics as observation, not production authority.
- Preserve exact source bypasses for disabled or denied paths.
- Record live compile, visual, motion, and memory evidence separately.
- Do not promote generated or locally validated work as runtime-proven.

## Validation

From the repository root:

```powershell
python -B tools/validate_repository.py
```

The validator checks local include closure, expected effects and techniques,
the Lazara namespace reduction, the absence of a bundled ReShade framework
header, and source-manifest integrity. It does not replace a live ReShade
compile or visual test.

## Local installation

1. Place this repository folder under `reshade-shaders/Shaders/OpenSurface`.
2. Add `reshade-shaders/Shaders/OpenSurface/**` to the ReShade effect search
   path if recursive shader discovery is not already enabled.
3. Keep each component's `effects`, `header`, and `api` folders together.
4. Reload ReShade and review compile diagnostics before enabling effects.

## License-adhering publication

See [docs/PROVENANCE.md](docs/PROVENANCE.md) for exact source revisions and
truth states. See [AUTHORS.md](AUTHORS.md), [LICENSE](LICENSE),
[LICENSING.md](LICENSING.md), and
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for authorship, continuation,
and dependency boundaries.

Publication checks require:

- a recognized SPDX identifier on active source;
- a file-level copyright holder or a precise repository annotation;
- an exact license text in `LICENSES/`;
- source provenance and revision identity;
- explicit treatment for material outside the software grant;
- validation that licensing metadata survives packaging and refactoring.

The repository follows the current [REUSE specification](https://reuse.software/spec/)
for machine-readable copyright and licensing metadata.
