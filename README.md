<div align="center">

# OpenSurface

### Camera Obscura image tools for ReShade

**Recover detail. Stabilize the image. Revive supported color. Keep every correction inspectable.**

[![ReShade FX](https://img.shields.io/badge/ReShade-FX-4b6b88?style=for-the-badge)](https://reshade.me/)
[![Projects](https://img.shields.io/badge/projects-5-6f42c1?style=for-the-badge)](Camera%20Obscura/README.md)
[![Validation](https://img.shields.io/badge/validation-20%2F20-2da44e?style=for-the-badge)](docs/VALIDATION.md)
[![License: MIT](https://img.shields.io/badge/license-MIT-0b7285?style=for-the-badge)](LICENSE)

[Explore the projects](#choose-a-project) · [Install](#installation) · [Build a pipeline](#a-practical-pipeline) · [Read the evidence](#evidence-not-magic)

</div>

<p align="center">
  <img src="Camera%20Obscura/Lazara%20Color%20Revival/docs/images/lazara-color-revival-comparison.png" width="100%" alt="Split-screen Lazara Color Revival comparison">
</p>

<p align="center"><sub><strong>Lazara Color Revival:</strong> a repository-owned split comparison showing controlled, source-supported color revival.</sub></p>

---

OpenSurface is the public distribution home for **Camera Obscura**: a family of
ReShade image tools built around visible evidence, bounded corrections, exact
bypass paths, and reversible installation.

This repository is a **storefront, not a development dump**. It carries reviewed
source, installation guidance, licensing, provenance, integrity records, and
bounded validation results while keeping private workshop material outside the
public tree.

Current shader surface: **5 project units · 5 `.fx` effect files · 44 `.fxh`
API/header files · 6 ReShade techniques**.

> Camera Obscura does not ask you to trust a mysterious final image. Its tools
> expose the support, authority, rejection, and applied contribution that led
> there.

## Choose A Project

| Project | Reach for it when… | What it is not | Published boundary |
|---|---|---|---|
| **[Camera Obscura API](Camera%20Obscura/API/)** | A consuming ReShade effect needs explicit surface, provider, cohesion, debug, or evidence contracts | A standalone effect, technique, or declaration that every hosted symbol is stable | Install-ready include library with 29 API headers, nine support headers, three dormant examples, 10/10 package checks, and a seven-file core umbrella |
| **[External Image Denoiser](Camera%20Obscura/External%20Image%20Denoiser/)** | Fine-detail shimmer, temporal instability, or spatial noise remains in the completed image | GI, ray tracing, donor transport, or lighting reconstruction | Install-ready `reshade-shaders` tree; accepted V2.1 package recorded 30/30 focused checks and confirmed live application/order |
| **[Guided Detail](Camera%20Obscura/Guided%20Detail/)** | Stable texture or contours need deliberate recovery or coherent line emphasis | A blind universal sharpener or automatic art-style filter | Accepted public staging source with documented compile and visual-test procedure |
| **[Stabilized Detail Cache](Camera%20Obscura/Stabilized%20Detail%20Cache/)** | Selected detail should survive later color or image effects and return near the end | Temporal accumulation or storage across frames, loading screens, or sessions | 19/19 source-package checks plus a user-reported clean compile and visual pass |
| **[Lazara Color Revival](Camera%20Obscura/Lazara%20Color%20Revival/)** | Existing scene color is present but muted, muddy, or poorly separated | A LUT, fixed palette, white-balance solver, or permission to invent absent color | Local helper/compiler harnesses pass; full ReShade compile and side-by-side regression remain open after the namespace/include refactor |

Start with the [Camera Obscura family guide](Camera%20Obscura/README.md) for the
shared method, diagnostic conventions, test discipline, and complete workflow.

## Four Image Tools And One Include Library

### Camera Obscura API

A hosted ReShade FX include library for explicit context, capability and surface
services, separate refined DDA and March providers, inspectable cohesion,
bounded composite wrappers, centralized diagnostics, and gated transmigration.
Its 29 API headers and nine support headers are source and documentation
surfaces—not a standalone visible effect. Only seven files belong to the core
umbrella; the remaining headers retain their documented cold or source-present
boundaries.

### External Image Denoiser

A completed-image denoiser with five independently controlled spatial size
bands, temporal history, depth-aware rejection, combination modes, exact bypass
paths, and diagnostics that separate detection, authority, candidate change,
and applied change. It filters existing image instability rather than creating
new lighting.

### Guided Detail

Two RGB-neutral tonal tools. **Guided Detail Reclamation** restores bounded
signed structure where depth confidence and same-surface support permit it.
**Guided Ink Lines** adds optional coherent contour emphasis from the same
evidence model.

<p align="center">
  <img src="Camera%20Obscura/Guided%20Detail/docs/images/guided-detail-diagnostic.png" width="88%" alt="Guided Detail diagnostic view displaying admitted structure and contours">
</p>

<p align="center"><sub>A Guided Detail diagnostic view. Diagnostics show evidence and admitted structure; they are not the production composite.</sub></p>

### Stabilized Detail Cache

A same-frame **Capture/Reapply** pair. Capture stores a bounded signed `RGBA16F`
detail residual after selection and denoising. Reapply can restore that residual
after later color or image effects without claiming long-term temporal storage.

### Lazara Color Revival

A source-derived color effect that strengthens color already supported by the
current pixel and a small local palette. Its deliberate degradation mode removes
admitted chroma while preserving source luma, making the effect easier to inspect
and tune.

## A Practical Pipeline

The most developed combined order is:

```text
Guided Detail Reclamation
          │
          ▼
External Image Denoiser
          │
          ▼
Stabilized Detail Capture
          │
          ▼
Color, tone, and other intervening effects
          │
          ▼
Stabilized Detail Reapply
```

This order chooses structure first, stabilizes the resulting image, stores a
bounded same-frame residual, allows color and tone work, and then restores only
the stored detail.

**Lazara has no universal position.** Put it before Capture when its result
should influence the captured detail. Put it between Capture and Reapply when
stored structure should return after the color work. Test both placements
against the complete preset.

Guided Ink Lines is optional. It can follow reclamation when the lines should be
denoised and cached, or run later when its graphic character should remain
untouched.

## Installation

OpenSurface currently uses two shader installation models plus one include-only
library layout.

### Install-ready tree

**External Image Denoiser** contains a `reshade-shaders` directory.

1. Merge that directory into the game's existing `reshade-shaders` directory.
2. Reload ReShade.
3. Enable `CAMERA_OBSCURA_ExternalImageDenoiseV1`.
4. Confirm a clean compile before judging the image.

### Source units

**Guided Detail**, **Stabilized Detail Cache**, and **Lazara Color Revival**
retain project-local `effects`, `header`, or `api` folders.

1. Copy the selected unit without flattening its sibling directories.
2. Add its `effects` directory to ReShade's effect search paths.
3. Add its `header` or `api` directory to the shader search paths as described
   by the unit README.
4. Enable only the techniques you intend to test.

Keep the installation's known-good `ReShade.fxh`. OpenSurface does not bundle,
download, or replace that framework header. Every unit is independently
removable; Stabilized Detail Capture and Reapply should be installed, disabled,
and removed together.

### Include-only API library

**Camera Obscura API** ships an install-ready `reshade-shaders` directory but no
loadable effect or technique. Merge that directory into the game's existing
`reshade-shaders` tree, then include
`camera_obscura/api/CAMERA_OBSCURA_API_All.fxh` from a consuming effect. Preserve
the adjacent `api` and `header` directories. See the
[API landing page](Camera%20Obscura/API/) before adopting headers outside the
seven-file core umbrella. Three `.fx.example` consumers are available for
deliberate copy-and-rename testing; they are not loaded by installation alone.

## Evidence, Not Magic

Camera Obscura effects generally follow the same visible chain:

1. **Sample** an explicit current, neighboring, depth, or history signal.
2. **Measure** support, difference, scale, stability, or color evidence.
3. **Decide** whether that evidence has enough authority to act.
4. **Reconstruct** a bounded correction instead of replacing the source without
   limits.
5. **Expose** the decision and applied result through diagnostic views.
6. **Return the source** when the effect, authority, or contribution is zero.

A visible detection mask does not prove that the final image changed. Inspect
the applied-contribution view too. Diagnostic exposure, bias, contrast, gamma,
floor, threshold, and invert controls improve readability without changing the
production result.

### Test discipline

For a new game or preset:

1. Confirm a clean ReShade compile.
2. Begin from documented defaults or a named tuning target.
3. Verify depth-dependent views when the effect uses depth.
4. Inspect support before increasing strength.
5. Inspect the applied contribution before deciding an effect does nothing.
6. Test motion, disocclusion, thin geometry, foliage, screen borders, loading
   transitions, and bright contrast where relevant.
7. Return every diagnostic to the final composite before judging the preset.
8. Record the game, resolution, technique order, settings, and observation.

## What Is Actually Shipped

The current tree contains exactly **49 tracked shader sources**: five effects
and 44 API/header files. It contains no preset, no ReShade binaries, and no
installation-provided `ReShade.fxh`.

The root [source manifest](SOURCE_MANIFEST.sha256) records the exact bytes of all
49 shader sources. Project READMEs preserve their installation layouts,
technique names, validation evidence, known limitations, and recovery paths.

### Additional Camera Obscura effects in Lazara Revival

The public
[Lazara ReShade Revival package](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package)
contains two additional project-owned Camera Obscura effect files. They belong
to that package's install-ready 18-technique preset closure but are **not part of
the current OpenSurface tree** or `SOURCE_MANIFEST.sha256`.

| Package-only effect | Techniques | Purpose |
|---|---|---|
| [Stabilized Color Cache](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/blob/main/reshade-shaders/Shaders/camera_obscura_reapply/effects/CAMERA_OBSCURA_StabilizedColorCacheV1.fx) | `CAMERA_OBSCURA_StabilizedColorCaptureV1`, `CAMERA_OBSCURA_StabilizedColorReapplyV1` | Captures same-frame chroma relative to source luma, then reapplies bounded chroma while preserving current luma |
| [Stabilized Luma Cache](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/blob/main/reshade-shaders/Shaders/camera_obscura_reapply/effects/CAMERA_OBSCURA_StabilizedLumaCacheV1.fx) | `CAMERA_OBSCURA_StabilizedLumaCaptureV1`, `CAMERA_OBSCURA_StabilizedLumaReapplyV1` | Captures same-frame Rec. 709 luma, then reapplies a bounded scalar correction while retaining channel separation |

Both files are MIT-identified, depend only on the installation's `ReShade.fxh`,
and were introduced by
[`364ef539`](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/commit/364ef53991081cec444e2dc0d6aa595fa5d733a0).
The Revival package's 5/5 structural validator covers 18 techniques, 15 effect
files, and a closed 110-file shader surface. It does not establish standalone
live compile or visual acceptance for these cache pairs, so their presence is
documented here without silently promoting them into OpenSurface.

The Revival package otherwise reconciles as follows: External Image Denoiser
and Stabilized Detail Cache are byte-identical to OpenSurface; Guided Detail
differs only by OpenSurface's added SPDX copyright line; its Lazara effect is the
earlier `OCCULT_lazara` implementation rather than the active OpenSurface
refactor; and Black Wand, Golden Weave, and FoolsGold remain pinned Occult Box
package material rather than OpenSurface units.

## Validation And Publication Boundary

Run the repository validator from the root:

```powershell
python -B tools/validate_repository.py
```

Current result: **20/20 passed**.

The validator checks the exact effect and technique sets, documented public
surface, local include closure, external `ReShade.fxh` boundary, source hashes,
SPDX/license coverage, provenance identifiers, local documentation links and
images, xOSG relocation boundary, and publication sanitation.

These checks prove bounded structural, integrity, documentation, and source
properties. They do not prove universal ReShade compilation, game-specific
depth behavior, motion stability, performance, memory headroom, or visual
acceptance.

- [Publishing boundary](PUBLISHING.md)
- [Provenance ledger](docs/PROVENANCE.md)
- [Validation ledger](docs/VALIDATION.md)
- [Licensing record](LICENSING.md)

## Related Publications

- [Lazara ReShade Revival](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package)
  packages a broader install-ready preset closure using selected OpenSurface
  effects alongside separately governed shader material.
- [Twin Lanterns](https://github.com/alia-june/Lunar-Flower/tree/main/Twin-Lanterns)
  is published separately through Lunar Flower with Stable 1.4, Fidelity
  Overdrive, Full Resolution Dual Ray Alpha, and a versioned ReShade FX API.
- The xOSG AI instrumentation family moved to
  [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg)
  on 2026-11-05. OpenSurface does not carry a current xOSG working tree;
  earlier commits remain historical repository evidence.

## Removal And Recovery

Disable the selected technique and remove only that unit's installed files.
Camera Obscura projects do not require a shared runtime. If behavior regresses,
restore the last known-good files and technique order before changing controls.

## License

Original Camera Obscura software is available under the [MIT License](LICENSE)
unless an individual file states otherwise. See [AUTHORS.md](AUTHORS.md),
[LICENSING.md](LICENSING.md), and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)
for authorship, continuation, dependencies, and screenshot boundaries.

The repository follows the [REUSE specification](https://reuse.software/spec/)
for machine-readable copyright and licensing metadata.

---

<div align="center">

**OpenSurface · Camera Obscura**<br>
*Inspectable inputs. Bounded corrections. Reversible experiments.*

</div>
