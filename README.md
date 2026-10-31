# OpenSurface

OpenSurface is a development repository for inspectable ReShade effects. It
keeps effect families separate while giving them one place to evolve, share
tests, and document runtime evidence.

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

`Naked Shell` is intentionally reserved as the second OpenSurface family. It
contains no effect implementation yet.

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

## Provenance and licensing

See [docs/PROVENANCE.md](docs/PROVENANCE.md) for exact source revisions and
truth states. Licensing is recorded per component in [licenses/README.md](licenses/README.md);
there is no silent repository-wide relicensing.
