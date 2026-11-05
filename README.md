# OpenSurface

**Public Camera Obscura image tools for ReShade**

OpenSurface is the current public distribution tree for Camera Obscura. It is a
storefront, not a development dump: the repository carries reviewed source,
installation guidance, licensing, provenance, integrity records, and bounded
validation results rather than the private workshop.

Current shader surface: **4 project units · 5 `.fx` effect files · 6 `.fxh`
API/header files · 6 ReShade techniques**.

Start with the [Camera Obscura guide](Camera%20Obscura/README.md) for the shared
method, practical pipeline, diagnostic conventions, and test discipline.

## What Is Actually Provided

| Unit | Shipped source | ReShade techniques | Distribution state | Current evidence boundary |
|---|---|---|---|---|
| [External Image Denoiser](Camera%20Obscura/External%20Image%20Denoiser/) | 1 effect + 1 API include | `CAMERA_OBSCURA_ExternalImageDenoiseV1` | Install-ready `reshade-shaders` tree | Accepted V2.1 package recorded 30/30 focused checks; live application and order were confirmed; universal motion, quality, and performance remain open |
| [Guided Detail](Camera%20Obscura/Guided%20Detail/) | 2 effects + 2 headers | `OSCO_GuidedDetailReclamation`, `OSCO_GuidedInkLines` | Source unit; preserve sibling `effects` and `header` folders | Accepted public staging source with a documented compile and visual-test procedure; no universal runtime claim |
| [Stabilized Detail Cache](Camera%20Obscura/Stabilized%20Detail%20Cache/) | 1 effect + 1 API include | `CAMERA_OBSCURA_StabilizedDetailCaptureV1`, `CAMERA_OBSCURA_StabilizedDetailReapplyV1` | Source unit; preserve sibling `effects` and `api` folders | 19/19 source-package checks and a user-reported clean compile and visual pass; loading, long-motion, and high-memory gates remain open |
| [Lazara Color Revival](Camera%20Obscura/Lazara%20Color%20Revival/) | 1 effect + 2 headers | `OSCO_LazaraColorRevival` | Source unit; preserve sibling `effects` and `header` folders | Local helper/compiler harnesses pass; full ReShade compile and side-by-side visual regression remain open after the namespace/include refactor |

The current tree contains exactly eleven tracked shader sources. It does not
contain a preset, ReShade itself, or the installation-provided `ReShade.fxh`.
The root [source manifest](SOURCE_MANIFEST.sha256) records the exact bytes of all
five effects and six support files.

## Additional Camera Obscura Effects In Lazara Revival

The public
[Lazara ReShade Revival package](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package)
contains two additional project-owned Camera Obscura effect files. They are
part of that package's install-ready 18-technique preset closure, but are **not
part of the current OpenSurface tree or `SOURCE_MANIFEST.sha256`**.

| Package-only effect | Techniques | Purpose |
|---|---|---|
| [Stabilized Color Cache](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/blob/main/reshade-shaders/Shaders/camera_obscura_reapply/effects/CAMERA_OBSCURA_StabilizedColorCacheV1.fx) | `CAMERA_OBSCURA_StabilizedColorCaptureV1`, `CAMERA_OBSCURA_StabilizedColorReapplyV1` | Captures same-frame chroma relative to source luma, then reapplies bounded chroma while preserving current luma |
| [Stabilized Luma Cache](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/blob/main/reshade-shaders/Shaders/camera_obscura_reapply/effects/CAMERA_OBSCURA_StabilizedLumaCacheV1.fx) | `CAMERA_OBSCURA_StabilizedLumaCaptureV1`, `CAMERA_OBSCURA_StabilizedLumaReapplyV1` | Captures same-frame Rec. 709 luma, then reapplies a bounded scalar luma correction while retaining channel separation |

Both files are MIT-identified, depend only on the installation's
`ReShade.fxh`, and were introduced by
[`364ef539`](https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package/commit/364ef53991081cec444e2dc0d6aa595fa5d733a0).
The Revival package currently passes its 5/5 structural package validator for
18 techniques, 15 effect files, and a closed 110-file shader surface. That does
not establish standalone live compile or visual acceptance for these two cache
pairs, so this README records them without silently promoting them into the
OpenSurface manifest.

The rest of the Revival package reconciles as follows: its External Image
Denoiser and Stabilized Detail Cache effects are byte-identical to OpenSurface;
its Guided Detail effects differ only by OpenSurface's added SPDX copyright
line; its Lazara effect is the earlier `OCCULT_lazara` implementation rather
than the active OpenSurface refactor; and Black Wand, Golden Weave, and
FoolsGold remain pinned Occult Box package material rather than OpenSurface
units.

## What The Units Do

### External Image Denoiser

A completed-image denoiser with five independently controlled spatial size
bands, temporal history, depth-aware rejection, combination modes, exact bypass
paths, and diagnostics that separate detection, authority, candidate change,
and applied change. It filters existing image instability; it does not generate
lighting, trace rays, or reconstruct GI.

### Guided Detail

Two RGB-neutral tonal tools. Guided Detail Reclamation restores bounded signed
structure where depth confidence and same-surface support permit it. Guided Ink
Lines adds optional coherent contour emphasis from the same evidence model.
Neither should be treated as a blind universal sharpener.

### Stabilized Detail Cache

A same-frame Capture/Reapply pair. Capture stores a bounded signed `RGBA16F`
detail residual after selection and denoising; Reapply can restore that residual
after later color or image effects. It is not temporal accumulation or storage
across frames, loading screens, or sessions.

### Lazara Color Revival

A source-derived color effect that strengthens color already supported by the
current pixel and a small local palette. Its deliberate degradation mode removes
admitted chroma while preserving source luma. It is not a LUT, fixed palette,
white-balance solver, or license to invent absent color.

## Installation Models

The repository currently uses two installation models:

1. **Install-ready tree — External Image Denoiser.** Merge its
   `reshade-shaders` directory into the game's existing `reshade-shaders`
   directory, reload ReShade, and enable the documented technique.
2. **Source units — Guided Detail, Stabilized Detail Cache, and Lazara Color
   Revival.** Copy the selected unit without flattening its sibling folders,
   then add its `effects` directory to ReShade's effect search paths and its
   `header` or `api` directory to the shader search paths as described in the
   unit README.

Keep the installation's known-good `ReShade.fxh`. OpenSurface does not bundle
or replace it. Install only the unit you intend to test, confirm a clean compile,
and use that unit's diagnostics before judging the image.

## Practical Detail Workflow

The most developed combined order is:

1. Guided Detail Reclamation.
2. External Image Denoiser.
3. Stabilized Detail Capture.
4. Color, tone, and other intervening effects.
5. Stabilized Detail Reapply.

Guided Ink Lines is optional. Lazara has no universal position: place it before
Capture when its result should influence captured detail, or between Capture
and Reapply when stored structure should return after color work. This is a
recommended workflow, not a hidden dependency; every unit remains independently
removable.

## Related Publications

- [Twin Lanterns](https://github.com/alia-june/Lunar-Flower/tree/main/Twin-Lanterns)
  is published separately through Lunar Flower. Its page contains Stable 1.4,
  Fidelity Overdrive, Full Resolution Dual Ray Alpha, and the versioned ReShade
  FX include API.
- The xOSG AI instrumentation family moved to
  [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg)
  on 2026-11-05. No current xOSG working tree is provided by OpenSurface;
  earlier commits remain historical repository evidence.

## Publication And Validation

OpenSurface preserves an explicit public boundary. Current files exclude raw
workshop records, private machine paths, credentials, presets, logs, archives,
and unaccepted implementation artifacts. Existing license and authorship
obligations continue forward; publication never silently replaces them.

Run the current-tree validator from the repository root:

```powershell
python -B tools/validate_repository.py
```

Current result: **19/19 passed**.

The validator checks the exact effect and technique sets, documented public
surface, local include closure, external `ReShade.fxh` boundary, source hashes,
SPDX/license coverage, provenance identifiers, local documentation links and
images, xOSG relocation boundary, and publication sanitation.

These are structural, integrity, documentation, and bounded source checks. They
do not prove universal ReShade compilation, game-specific depth behavior,
motion stability, performance, memory headroom, or visual acceptance.

See the [publishing boundary](PUBLISHING.md), [provenance ledger](docs/PROVENANCE.md),
and [validation ledger](docs/VALIDATION.md) for the governing evidence and
remaining gates.

## Removal And Recovery

Disable the selected technique and remove only that unit's installed files. The
projects do not require a shared Camera Obscura runtime. Install, disable, and
remove Stabilized Detail Capture and Reapply together. If behavior regresses,
restore the last known-good files and technique order before changing controls.

## License

Original Camera Obscura software is available under the [MIT License](LICENSE)
unless an individual file states otherwise. See [AUTHORS.md](AUTHORS.md),
[LICENSING.md](LICENSING.md), and
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for authorship, continuation,
external dependencies, and screenshot boundaries. The repository follows the
[REUSE specification](https://reuse.software/spec/) for machine-readable
copyright and licensing metadata.
