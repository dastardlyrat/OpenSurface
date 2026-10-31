# Camera Obscura Stabilized Detail Cache

**Version 1 | Carry chosen detail across the same ReShade frame**

Stabilized Detail Cache separates *where detail is chosen* from *where detail
is finally applied*. Capture extracts and stores a bounded signed RGB residual
from an already reclaimed and denoised image. Reapply restores that residual
after intervening color, tone, or image effects.

The cache is not temporal accumulation. It does not preserve detail across
frames, loading screens, or game sessions. Its freshness guard admits only a
Capture that ran earlier in the same frame.

**Current evidence:** 19/19 source-package checks passed, followed by a
user-reported clean compile and visual pass on 2026-10-31. Loading-transition,
high-memory-scene, and long-motion results remain separately unrecorded.

## When To Use It

Use the cache when:

- wanted detail is selected and stabilized early in the chain;
- later effects soften or obscure that chosen structure;
- you want final control over how much of the stored residual returns.

Do not use it as:

- an image-history buffer;
- a motion-compensated temporal store;
- a substitute for denoising or detail selection;
- a dynamic memory manager.

## Intended Order

```text
Guided Detail Reclamation
        |
External Image Denoiser
        |
Camera Obscura - 1 Stabilized Detail Capture V1
        |
Intervening color, tone, or image effects
        |
Camera Obscura - 2 Stabilized Detail Reapply V1
```

Both techniques live in one effect file and share one `RGBA16F` texture.
Capture writes only that texture and does not alter the displayed image.
Reapply rejects frame zero and any cache whose freshness stamp does not match
the current frame. Enable, disable, install, and remove the pair together.

## Install

Keep the component layout intact:

```text
Stabilized Detail Cache/
|-- api/
|   `-- CAMERA_OBSCURA_API_StabilizedDetailCache.fxh
`-- effects/
    `-- CAMERA_OBSCURA_StabilizedDetailCacheV1.fx
```

1. Copy the component into a stable location beneath ReShade's shader tree.
2. Add its `effects` directory to ReShade's effect search paths.
3. Keep the sibling `api` directory in place so the relative include resolves.
4. Keep the installation's existing `ReShade.fxh`; it is not bundled here.
5. Reload ReShade and enable both numbered techniques in the intended order.

## Quick Proof

1. Select `Cache Freshness` in Reapply. A valid same-frame Capture is green.
2. Select `Stored Signed Detail`. Neutral zero is middle gray; darker and
   lighter departures are signed residuals.
3. Select `Applied Difference (32x)` to prove that Reapply changes the image.
4. Set `Stored Detail Reapply Strength` to zero and confirm an exact source
   return.
5. Enable `Show Reapplied Detail Tint` and compare it with `Reapply Tint Mask`.
6. Return to `Reapplied Image` before judging final quality.

## Cache Format

The cache uses signed `RGBA16F`:

- RGB: 16-bit floating-point signed detail per channel;
- alpha: same-frame freshness stamp;
- physical storage: 64 bits per cached pixel.

The default cache is full resolution. With 12 GB of VRAM this is a reasonable
first quality test, but actual headroom remains dependent on the game, scene,
resolution, other effects, driver, and runtime allocation behavior.

| Resolution | Full resolution | Half resolution |
|---|---:|---:|
| 1920x1080 | 15.8 MiB | 4.0 MiB |
| 2560x1440 | 28.1 MiB | 7.0 MiB |
| 3840x2160 | 63.3 MiB | 15.8 MiB |

## Memory And Resolution

ReShade FX cannot query available VRAM and then dynamically allocate or release
this texture as game-world demand changes. The cache is allocated when the
effect compiles.

Use exactly one compile-time profile:

- full resolution: `CAMERA_OBSCURA_DETAIL_CACHE_DIVISOR=1`;
- half width and height: `CAMERA_OBSCURA_DETAIL_CACHE_DIVISOR=2`.

Change the global preprocessor definition and reload ReShade to change the
allocation. Do not install separate full- and half-resolution effect copies;
both would allocate. Half resolution reduces memory to one quarter but uses
linear sampling during Reapply and cannot preserve the same spatial precision.

## How It Works

Capture builds a depth- and color-admitted four-neighbor local base from the
already reclaimed and denoised image. The signed residual between source and
base is thresholded, gained, bounded, and stored.

Reapply reads the cache after intervening effects, verifies the modulo same-frame
stamp, bounds the signed contribution again, and adds it to the current image.
Missing, stale, disabled, zero-strength, and zero-detail paths return the
current source exactly.

The half-float alpha stamp is a lightweight ordering guard, not an unbounded
frame identity. It repeats every 1024 frames. The pair is designed to run every
frame, with Capture before Reapply. It is not evidence of long-duration frame
identity.

## Controls

| Control | What it changes | Conservative direction |
|---|---|---|
| `Captured Detail Radius` | Neighborhood width used to separate detail from its local base | Smaller isolates finer structure |
| `Captured Detail Threshold` | Minimum signed RGB residual admitted to storage | Higher stores only stronger detail |
| `Captured Detail Gain` | Residual scale before storage | Lower stores less |
| `Stored Detail Limit` | Per-channel bound applied before storage | Lower contains extreme edges |
| `Capture Color Tolerance` | Same-region color support | Lower rejects more cross-edge support |
| `Use Capture Depth Rejection` | Enables depth-aware neighbor rejection | Keep enabled with usable depth |
| `Capture Depth Tolerance` | Allowed linear-depth separation | Lower protects silhouettes more strongly |
| `Enable Stored Detail Reapply` | Master Reapply output switch | Off returns the current source |
| `Stored Detail Reapply Strength` | Scale applied to the cached residual | `1.0` restores the stored amount |
| `Reapplied Detail Limit` | Independent final per-channel bound | Lower contains aggressive strength |
| `Show Reapplied Detail Tint` | Display-only proof overlay | Off for production |

The capture and reapply limits are intentionally independent. A high capture
gain cannot bypass the storage limit, and a high reapply strength cannot bypass
the applied limit.

## Diagnostic Views

| View | What it proves |
|---|---|
| `Reapplied Image` | Final production result, optionally with proof tint |
| `Source Before Reapply` | Exact image entering the Reapply technique |
| `Stored Signed Detail` | Cached residual around middle-gray zero |
| `Cache Freshness` | Green means Capture and Reapply agree on this frame |
| `Applied Difference (32x)` | Magnified absolute visible change |
| `Applied Signed Detail` | Final bounded signed contribution around middle gray |
| `Reapply Tint Mask` | Pixels crossing the proof-tint threshold |

## Tuning Order

1. Establish a green freshness view.
2. Tune radius and threshold while watching `Stored Signed Detail`.
3. Protect silhouettes with color and depth tolerances.
4. Set storage gain and limit.
5. Tune Reapply strength while watching `Applied Signed Detail`.
6. Use the applied limit to contain bright or dark edge excursions.
7. Test at the final technique order, resolution, and game-world load.

## Failure Patterns

| Symptom | Likely cause | First response |
|---|---|---|
| Freshness is dark | Capture is disabled, below Reapply, or not running this frame | Enable both and restore numbered order |
| Stored detail is flat gray | Threshold is too high, gain is zero, or the source has little residual | Lower threshold, then inspect gain |
| Reapply appears inactive | Stale cache, zero strength, or tiny contribution | Check Freshness, then `Applied Difference (32x)` |
| Halos return after Reapply | Capture crossed a color/depth boundary or limits are high | Tighten tolerances and lower stored/applied limits |
| Memory pressure rises | Full-resolution `RGBA16F` allocation is too expensive for the scene | Test the half-resolution compile-time profile |
| Detail looks soft at half resolution | Downsampled storage lost spatial precision | Return to full resolution if memory permits |

## Removal And Recovery

Disable both techniques or remove this component's `effects` and `api` files.
No Guided Detail, External Denoiser, Lazara, or Twin Lantern source is modified.
If the pair is misordered, restore the last known-good technique order before
changing detail controls.

## Evidence Boundary

Static validation and memory arithmetic do not prove driver allocation success,
available VRAM, runtime stability, visual quality, ordering across every ReShade
configuration, or live performance. Test loading transitions and a high-memory
scene before accepting the full-resolution profile.

## Integrity

The repository root `SOURCE_MANIFEST.sha256` records the active shader sources.

## License

Published under the MIT License. Copyright and source provenance are retained
through file-level SPDX metadata, the repository authorship ledger, and the
original package hash recorded in the provenance ledger.
