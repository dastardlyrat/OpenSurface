# Camera Obscura External Image Denoiser

**Version 2.1 Multiscale**

A standalone ReShade denoiser for the completed image. It combines temporal
history with a five-band spatial discriminator so that tiny, small, medium,
large, and extra-large instability can be targeted independently.

The effect is designed to be used late in the technique chain. It filters the
image it receives; it does not generate lighting, trace rays, transport donor
color, reconstruct GI, or add an illumination composite.

## Highlights

- Five independently weighted noise-size bands.
- Temporal and stability-driven spatial discrimination.
- Concurrent, agreement-only, temporal-only, and spatial-only modes.
- Depth-aware history and neighborhood rejection.
- Bounded history matching and current-frame color clamping.
- Exact source return when the effect or output multiplier is disabled.
- Diagnostic views for targets, trust, authority, motion, clamp activity, and
  applied difference.
- Bright display-only tint for proving exactly which pixels changed.

## Install

1. Open this project's `reshade-shaders` folder.
2. Merge it into the game's existing `reshade-shaders` folder.
3. Keep the installation's known-good `ReShade.fxh`; it is an external
   dependency and is not included here.
4. Reload ReShade.
5. Enable `Camera Obscura - External Image Denoiser V2.1 Multiscale`.

The installed files are:

```text
reshade-shaders/
`-- Shaders/
    `-- camera_obscura_external/
        |-- api/
        |   `-- CAMERA_OBSCURA_API_ExternalImageDenoise.fxh
        `-- effects/
            `-- CAMERA_OBSCURA_ExternalImageDenoiseV1.fx
```

## Recommended Order

For the Camera Obscura detail workflow:

1. Run Guided Detail Reclamation first to choose and restore wanted structure.
2. Run the External Image Denoiser after image-forming effects.
3. Keep the denoiser last unless Stabilized Detail Cache is being used.
4. With the cache, capture immediately after denoising and reapply the stored
   detail at the final intended point.

Effects placed after the denoiser can introduce new instability that this pass
never sees.

## How It Works

### Spatial path

The spatial path evaluates admitted neighborhoods at one, two, four, eight,
and sixteen pixels. Differences between successive levels form five frequency
bands. Each band has an independent response control, allowing any of the 32
possible enabled-band combinations.

Border coverage, luma separation, optional depth separation, opposite-tap
coherence, and support determine whether each radius contributes. The selected
bands are removed through one telescoping reconstruction. Zero selected bands
return the source candidate; all admitted bands reach the broadest accepted
level.

### Temporal path

The temporal path searches five nearby positions in the previous source frame,
selects the strongest bounded match, and samples the corresponding previous
denoised result. Match confidence, residual disagreement, current-frame color
limits, motion evidence, and optional depth rejection constrain history use.

### Combination modes

- **Concurrent:** either temporal or spatial evidence may contribute.
- **Agreement Only:** both paths must be active and their candidates must agree.
- **Temporal Only:** isolates history-based denoising.
- **Spatial Only:** isolates the current-frame multiscale path.

Concurrent is the practical starting mode. The isolation modes are useful when
tracking a scene-specific artifact.

## Starting Settings

| Control | Starting value |
|---|---:|
| Combination Mode | Concurrent |
| Temporal Strength | 0.45 |
| Spatial Strength | 0.55 |
| Noise Threshold | 0.018 |
| Tiny Noise Response | 1.00 |
| Small Noise Response | 1.00 |
| Medium Noise Response | 1.00 |
| Large Noise Response | 0.75 |
| Extra Large Noise Response | 0.50 |
| Denoise Output Multiplier | 1.00 |
| Color Edge Tolerance | 0.080 |
| Use Depth Rejection | Enabled |
| Depth Tolerance | 0.0100 |
| Ghosting Protection | 0.005 |
| Agreement Tolerance | 0.020 |

Use the scale views before increasing strength. If instability lives around
fine detail, begin with Tiny and Small. Broader flicker or unstable gradients
may require Medium, Large, or Extra Large. The output multiplier supplies up to
4x correction headroom after the bounded candidate has been selected; it does
not improve discrimination by itself.

## Diagnostics

The `View` control exposes the denoiser without feeding diagnostic colors back
into history. Useful views include:

- individual Tiny through Extra Large targets;
- Combined Scale Target;
- Temporal Trust and spatial authority;
- Final Authority;
- Candidate Difference and Applied Difference at display-only 32x gain;
- History Clamp Activity;
- motion evidence.

`Show Applied Pixels Tint` overlays a bright configurable color wherever the
final correction exceeds the selected threshold. The tint belongs only to the
display pass: it is not captured in denoised history and cannot affect target
detection or authority.

## Performance

The worst-case main pass evaluates four current-frame taps at each of five
radii, plus temporal match and history reads. Approximate maximum work per
output pixel is 20 neighborhood color reads, 20 depth reads when depth
rejection is active, five previous-source reads, one previous-denoised read,
and center samples.

Setting a scale response to zero removes its reconstruction contribution, but
V2.1 still evaluates that scale's evidence. Exact per-scale workload bypass is
reserved for a later optimization pass so it cannot silently alter the proven
discriminator.

## Validation State

The accepted V2.1 package passed 30 focused structural, numerical, package, and
compatibility-compiler checks. Live application, output multiplier behavior,
the applied-pixel tint, and the recommended detail-then-denoise order were
confirmed during development.

Those results do not establish universal performance, motion stability, edge
retention, or ghosting behavior across every game and scene. Treat those as
content-dependent checks, especially around thin geometry, foliage,
disocclusions, bright contrast, and screen borders.

## Removal

Disable the technique or remove the `camera_obscura_external` folder. The
effect owns no external lighting or reconstruction state.

## Integrity And License

The repository root `SOURCE_MANIFEST.sha256` records the exact published shader
sources. The accepted pre-publication package SHA-256 is:

`15C9F5A91B8143F6FB539153EF280DE133F0B8843DBBD231FDFB189C2EC1F786`

Camera Obscura External Image Denoiser is published under the MIT License. See
[LICENSE](LICENSE) and the repository provenance ledger for the complete
authorship and continuation record.
