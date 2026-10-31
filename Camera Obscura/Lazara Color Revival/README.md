# Camera Obscura Lazara Color Revival

**Source-derived color recovery with an intentional degradation mode**

Lazara Color Revival is a ReShade color effect for scenes whose color is
present but muted, muddy, or poorly separated. It reads the source pixel and a
small local palette, measures chroma, contrast, and hue relationships, then
applies a bounded color correction without assigning a preferred hue family.

Its inverse mode is a real output mode, not a diagnostic: **Degrade Color**
turns recovery off and removes admitted chroma while preserving the source luma
structure.

![Lazara Color Revival comparison](docs/images/lazara-color-revival-comparison.png)

## What It Is

Lazara can:

- strengthen colors already supported by the source or local palette;
- lift weak but non-neutral color without recoloring neutral surfaces;
- favor analogous, complementary, triadic, and split-complement relationships;
- migrate a weak hue slightly toward stronger nearby observed evidence;
- protect bright highlights from color wash;
- apply a muddy-region-only chromatic separation accent;
- deliberately degrade admitted color for testing or creative use.

Lazara is not a LUT, fixed palette, white-balance solver, HDR conversion, or
license to invent color that is absent from the image.

## Install

Keep the three-file ownership capsule together:

```text
Lazara Color Revival/
|-- effects/
|   `-- OSCO_LazaraColorRevival.fx
`-- header/
    |-- OSCO_LazaraColorRevival_Common.fxh
    `-- OSCO_LazaraColorRevival_DebugVisibility.fxh
```

1. Copy the component into a stable location beneath ReShade's shader tree.
2. Add its `effects` directory to the effect search paths.
3. Keep the sibling `header` directory in place for the relative includes.
4. Keep the installation's existing `ReShade.fxh`; it is not bundled here.
5. Reload ReShade and enable `OSCO_LazaraColorRevival`.

## Quick Start

1. Begin with the defaults and `View` set to `Final Composite`.
2. Toggle `Enable Color Revival` to confirm exact source versus effect output.
3. Inspect `Mud Mask`, `Invigorate Mask`, and `Local Palette` before changing
   global strength.
4. Use `Color Result` to isolate the recovered or degraded result.
5. Compare `Recover Color` with `Degrade Color` to confirm the inverse switch.
6. Return to `Final Composite` and test several lighting conditions.

## How It Works

The effect samples the center plus four immediate neighbors. It derives local
contrast and selects the strongest chromatic neighbor whose luma remains
compatible with the center. The source and selected palette are converted to
hue-based evidence for three related decisions:

1. **Invigoration** increases supported chroma while retaining the source luma
   direction.
2. **Harmony support** increases recovery where observed source and local hues
   form recognized relationships.
3. **Hue migration** permits a weak, non-neutral source hue to move slightly
   toward stronger nearby observed evidence.

A separate mud mask favors low-saturation, low-contrast midtones. That mask
admits the optional red/blue sample separation. Highlight protection reduces
the final authority near bright peaks.

In Degrade Color mode, the recovery path is killed and the admitted chroma is
reduced against the source luma. Diagnostic visibility processing occurs after
the production calculation and does not feed back into it.

## Controls

| Control | Function | Practical use |
|---|---|---|
| `Enable Color Revival` | Master production bypass | Off returns the source |
| `Invert Color Recovery` | Chooses Recover Color or Degrade Color | Use Degrade to prove or intentionally remove admitted color |
| `Color Strength` | Overall correction authority | Raise only after masks identify the intended regions |
| `Muted Color Lift` | Extra recovery for weak existing chroma | Increase for washed-out color |
| `Dominant Hue Vibrancy` | Luma-aware vividness for the best-supported hue | Watch saturated objects and highlights |
| `Muted Hue Migration` | Movement of weak source hue toward local observed hue | Keep low for conservative recovery |
| `Tone Contrast` | Small pre-recovery tone-shape adjustment | Keep near one when color is the only goal |
| `Manual Temperature Bias` | Optional warm or cool artistic override | Zero leaves palette selection source-driven |
| `Harmony Boost` | Strength added by recognized hue relationships | Increase when a varied palette remains dull |
| `Harmony Guidance` | Amount of harmony support entering authority | Lower when local palettes feel over-coordinated |
| `Harmony Tolerance` | Width around recognized hue relationships | Narrower is more selective |
| `Highlight Protect` | Suppression near bright peaks | Raise when bright areas become colored wash |
| `Mud Saturation Ceiling` | Highest saturation still classified as muddy | Lower targets flatter neutrals only |
| `Mud Contrast Ceiling` | Highest local contrast admitted by the mud mask | Lower protects detailed edges |
| `Mud Midpoint` | Luma center of muddy-region treatment | Move toward the affected tonal range |
| `Mud Mid Width` | Luma width around the mud midpoint | Lower isolates a narrower tonal band |
| `Chromatic Split Pixels` | Red/blue sample separation distance | Zero disables the spatial split |
| `Chromatic Split Blend` | Amount of muddy-region split entering output | Keep low unless the accent is deliberate |

## Diagnostic Views

| View | What to inspect |
|---|---|
| `Final Composite` | Production output |
| `Color Result` | Recovered or degraded color before diagnostic mapping |
| `Mud Mask` | Low-saturation, low-contrast midtone admission |
| `Invigorate Mask` | Where source-derived recovery has authority |
| `Local Contrast` | Edge/detail evidence used to reject muddy treatment |
| `Chromatic Split Only` | Contribution from muddy-region channel separation |
| `Local Palette` | Strongest admitted neighboring color evidence |
| `Harmony Support` | Strength of observed hue relationships |
| `Vibrancy Drive` | Supported vividness pressure |
| `Hue Migration` | Amount of weak-hue movement toward local evidence |

Non-final views can be made readable with `Debug Visibility Mode`, exposure,
bias, contrast, gamma, floor, and threshold. Those controls affect diagnostic
display only.

## Tuning Order

1. Leave temperature bias at zero.
2. Find the problem with `Mud Mask`, `Invigorate Mask`, and `Local Palette`.
3. Tune mud ceilings and midpoint before raising recovery strength.
4. Set `Muted Color Lift`, then `Color Strength`.
5. Add vibrancy and harmony support only after the base correction is stable.
6. Introduce hue migration conservatively.
7. Add chromatic split last and verify it does not crawl on edges.
8. Test highlights, neutral armor, skin, fog, foliage, and strong single-color
   scenes before accepting a preset.

## Failure Patterns

| Symptom | Likely cause | First response |
|---|---|---|
| Entire image becomes over-saturated | Global strength or vibrancy is too high | Inspect `Invigorate Mask`, then reduce both |
| Neutral surfaces take nearby color | Hue migration or mud admission is too broad | Lower migration and tighten mud ceilings |
| Highlights look painted or glowing | Recovery reaches bright peaks | Raise `Highlight Protect` |
| Edges show red/blue separation | Chromatic split is too wide or broadly admitted | Lower split pixels/blend and tighten contrast ceiling |
| Temperature feels biased | Manual override is nonzero | Return `Manual Temperature Bias` to zero |
| Degrade Color appears unchanged | Current regions have little admitted chroma | Inspect `Invigorate Mask` and `Color Result` |
| A diagnostic is too dark to read | Evidence is weak, not necessarily absent | Use debug exposure or heat mapping |

## Refactor Boundary

This is the Camera Obscura-owned refactor of the public Lazara effect. The
effect was renamed from `OCCULT_lazara` to `OSCO_LazaraColorRevival`, and its
implementation namespace is `OSCO_LCR`.

The prior package carried a broad RM header closure. This version owns only one
color texture and sampler, pixel-size and clamped color access, luma/chroma
helpers, and diagnostic visibility mapping. It does not import depth, tracing,
material, SSR, SSGI, ray marching, or other unrelated runtime systems.

## Validation State

The namespace and dependency refactor is generated implementation. Repository
validation confirms local include closure and the absence of legacy `OCCULT`
or `MIXSR` identifiers in active source. The reduced helper capsule passes a
ReShade-compatible FXC harness and a strict `/Ges /WX` math/diagnostic harness.

A fresh live ReShade compile and side-by-side visual regression against the
public Lazara build remain required before this refactor supersedes it. The
screenshot demonstrates the documented project lineage; it is not independent
attestation of the current refactored source.

## Removal

Disable `OSCO_LazaraColorRevival` or remove its one effect and two owned
headers. No shared Camera Obscura runtime is required.

## License

Published under the MIT License as a continuation of project-owned Lazara work.
The original repository, revision, and refactor boundary remain in the
OpenSurface provenance ledger. The documentation screenshot is not included in
the MIT software grant.
