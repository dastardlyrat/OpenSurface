# Camera Obscura External Image Denoiser V2.1 Multiscale

Date: 2026-10-30
Imported into OpenSurface: 2026-10-31

Status: generated denoiser-only multiscale implementation; local validation
recorded separately; live application and ordering confirmed by the user;
broader quality and performance acceptance pending

## Boundary

This effect filters the already-composited image. It contains no Twin Lantern
GI generation:

- no ray traversal;
- no donor sampling or transport;
- no reconstruction or resolve pipeline;
- no indirect-light strength or energy application;
- no additive GI composite.

Place it after Twin Lantern TL09, or after another effect whose final image
needs denoising.

## Multiscale Algorithm

The spatial path builds five admitted neighborhood levels at one, two, four,
eight, and sixteen pixels. Differences between successive levels form separate
Tiny, Small, Medium, Large, and Extra Large frequency bands. Each response
slider can be set independently from zero to one, so every subset of the five
bands is representable.

Selected band differences are removed through one telescoping reconstruction.
With every response at zero the candidate equals the source exactly. With all
bands fully admitted the reconstruction reaches the broadest accepted level.
Border coverage, luma separation, depth separation, opposite-tap coherence,
and support gate every radius before it contributes.

V2.1 adds a final `Denoise Output Multiplier` from zero through four. One
preserves the V2 result; zero returns the source exactly; values above one
provide aggressive headroom after the bounded denoiser has chosen its result.

`Show Applied Pixels Tint` overlays a configurable bright color wherever the
final correction exceeds its threshold. The tint is applied only by the final
display pass. It is not captured into denoised history and does not alter
detection or authority.

The temporal path performs a bounded five-position search in the previous
source image, samples the matched previous denoised image, and rejects history
through match confidence, residual disagreement, and a current local color
envelope.

Both paths require the current source-domain noise target. Neither path adds
light; each only interpolates between bounded source-image candidates.

## Install And Order

1. Merge `reshade-shaders` into the ReShade installation.
2. Retain the host's known-good `ReShade.fxh`.
3. Disable the withdrawn TL08 V4/V4.1 denoiser techniques.
4. Run Detail Reclamation before this effect.
5. Place `Camera Obscura - External Image Denoiser V2.1 Multiscale` last in the
   active technique order.
6. Reload ReShade and record the first relevant hard error or warning.

## Confirmed Technique Order

1. Twin Lantern and other image-forming effects.
2. Detail Reclamation.
3. External Image Denoiser V2.1 Multiscale last.

The user confirmed that this order works: Detail Reclamation restores the
desired fine structure first, then the final denoiser stabilizes the completed
image. Effects placed after the denoiser may reintroduce unstable detail and
are outside the confirmed order.

## First Live Gate

1. Confirm a clean ReShade compile.
2. Set `View` to `Source Only`, then disable the effect. The normal image must
   remain unchanged.
3. Use the default `Concurrent` mode in a static detailed scene.
4. Inspect the five noise-size views, then `Combined Scale Target`. Stable
   edges should remain mostly cold while the relevant noise sizes activate.
5. Inspect `Applied Difference (32x)`; it should be sparse and must not show the
   directional hatch pattern from the withdrawn GI-bearing denoisers.
6. Pan, stop, and expose disocclusions while watching `Temporal Trust` and
   `History Clamp Activity`.
7. Repeat on thin geometry, foliage, dark detail, bright contrast, and screen
   borders.
8. Enable `Show Applied Pixels Tint` and set opacity to one. Bright tinted
   pixels must correspond to `Applied Difference (32x)`.

`Applied Difference (32x)` and `Candidate Difference (32x)` use display-only
magnification so small source-domain corrections are visible. The magnification
does not alter the denoised image. `Final Authority` shows whether an admitted
candidate reaches the final blend.

## Starting Values

- Combination Mode: `Concurrent`
- Temporal Strength: `0.45`
- Spatial Strength: `0.55`
- Noise Threshold: `0.018`
- Tiny Noise Response: `1.00`
- Small Noise Response: `1.00`
- Medium Noise Response: `1.00`
- Large Noise Response: `0.75`
- Extra Large Noise Response: `0.50`
- Denoise Output Multiplier: `1.00`
- Show Applied Pixels Tint: disabled
- Applied Pixel Tint Color: bright magenta
- Applied Pixel Tint Opacity: `1.00`
- Applied Pixel Tint Threshold: `0.0010`
- Color Edge Tolerance: `0.080`
- Use Depth Rejection: enabled
- Depth Tolerance: `0.0100`
- Ghosting Protection: `0.005`
- Agreement Tolerance: `0.020`

## Performance Boundary

The main denoise pass evaluates four admitted taps at each of five radii. Its
worst-case path is approximately 20 current-color reads, 20 depth reads, five
previous-source reads, one previous-denoised read, and the center reads per
output pixel. Large and Extra Large responses may be set to zero for quality
isolation, but the current V2 shader still evaluates their evidence; a later
optimization pass may add exact workload bypass after live behavior is proven.

## Evidence Boundary

Local validation does not prove complete ReShade compilation, runtime cost,
noise reduction, edge retention, temporal stability, or absence of ghosting.

## Rollback

Disable or remove this effect. Twin Lantern TL09 remains independent and
unchanged.

## Integrity

The repository root `SOURCE_MANIFEST.sha256` records the active shader sources.
The accepted source package SHA-256 is:

`15C9F5A91B8143F6FB539153EF280DE133F0B8843DBBD231FDFB189C2EC1F786`

## License

Published under the MIT License. File-level SPDX metadata, the OpenSurface
authorship ledger, and the accepted package hash preserve the licensing and
source chain.
