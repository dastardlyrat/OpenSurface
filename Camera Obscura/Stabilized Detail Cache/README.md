# Camera Obscura Stabilized Detail Cache V1

Date: 2026-10-30
Imported into OpenSurface: 2026-10-31

Status: local validation 19/19; user-reported live compile and visual pass on
2026-10-31; loading-transition, high-memory-scene, and long-motion evidence
remain separately unrecorded

## Purpose

This package captures stabilized signed detail, permits unrelated effects to
run, then reapplies that same-frame detail afterward.

Confirmed intended order:

1. Detail Reclamation.
2. External Image Denoiser.
3. `Camera Obscura - 1 Stabilized Detail Capture V1`.
4. Other effects.
5. `Camera Obscura - 2 Stabilized Detail Reapply V1`.

Both techniques live in one effect file and share one cache texture. Capture
writes only the cache and does not alter the displayed image. Reapply rejects a
cache whose frame stamp does not match the current frame and rejects frame zero.
Enable or disable both techniques together.

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

## Memory Profile

ReShade FX cannot query available VRAM and then dynamically allocate or release
this texture as game-world demand changes. The cache is allocated when the
effect compiles.

Use exactly one compile-time profile:

- full resolution: `CAMERA_OBSCURA_DETAIL_CACHE_DIVISOR=1`;
- half width and height: `CAMERA_OBSCURA_DETAIL_CACHE_DIVISOR=2`.

Change the global preprocessor definition and reload ReShade to change the
allocation. Do not install separate full- and half-resolution effect copies;
both would allocate.

## Algorithm

Capture builds a depth- and color-admitted four-neighbor local base from the
already reclaimed and denoised image. The signed residual between source and
base is thresholded, gained, bounded, and stored.

Reapply reads the cache after intervening effects, verifies the modulo same-frame
stamp, bounds the signed contribution again, and adds it to the current image.
Missing, stale, disabled, zero-strength, and zero-detail paths return the
current source exactly.

The half-float alpha stamp is a lightweight ordering guard, not an unbounded
frame identity. It repeats every 1024 frames. It is designed for an enabled
Capture/Reapply pair running every frame; disable both techniques together.

## First Live Gate

1. Confirm both techniques compile.
2. Put Capture immediately after the external denoiser.
3. Put Reapply after the intervening effects.
4. Select `Cache Freshness`; it must be green.
5. Inspect `Stored Signed Detail`, then `Applied Difference (32x)`.
6. Set Reapply Strength to zero and confirm exact source behavior.
7. Enable the proof tint and confirm it agrees with `Reapply Tint Mask`.
8. Test loading transitions and a high-memory game-world scene before accepting
   the full-resolution profile.

## Rollback

Disable both techniques or remove the effect. No Twin Lantern, Detail
Reclamation, or External Denoiser source is modified.

## Evidence Boundary

Static validation and memory arithmetic do not prove driver allocation success,
available VRAM, runtime stability, visual quality, or live performance.

## Integrity

The repository root `SOURCE_MANIFEST.sha256` records the active shader sources.

## License

Published under the MIT License. Copyright and source provenance are retained
through file-level SPDX metadata, the repository authorship ledger, and the
original package hash.
