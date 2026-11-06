# Camera Obscura

**Inspectable image tools for ReShade**

Camera Obscura is the OpenSurface family for image reconstruction, detail
control, denoising, bounded detail transport, and source-derived color work.
Each effect is independently installable and removable. The family is designed
around visible evidence: masks, support, authority, applied difference, and
exact bypass behavior are exposed wherever the implementation can expose them.

The effects can form a workflow, but they are not a mandatory monolithic
pipeline. Start with the one that solves the problem you can actually see.

## Choose A Project

| Project | Use it when | Avoid treating it as | Publication evidence |
|---|---|---|---|
| [Camera Obscura API](API/) | A consuming effect needs explicit surface, provider, cohesion, debug, or evidence contracts | A standalone effect or a promise that every source-present symbol is stable | 29 API and nine support headers; 9/9 package checks; seven-file core umbrella documented |
| [Guided Detail](Guided%20Detail/) | Stable texture or contours need deliberate recovery or line emphasis | A universal sharpener or automatic art-style filter | Accepted staging source with compile and visual test procedure |
| [External Image Denoiser](External%20Image%20Denoiser/) | Fine-detail shimmer, temporal instability, or spatial noise remains in the completed image | GI, ray tracing, donor transport, or lighting reconstruction | 30/30 package checks; live application and order confirmed |
| [Stabilized Detail Cache](Stabilized%20Detail%20Cache/) | Chosen detail should survive later color or image effects and return at the end | Long-term temporal storage or dynamic VRAM management | 19/19 package checks; live compile and visual pass reported |
| [Lazara Color Revival](Lazara%20Color%20Revival/) | Existing scene color is present but muted, muddy, or poorly separated | A LUT, fixed palette, or license to invent absent color | Refactored candidate; local compiler checks pass; live regression remains open |

## A Practical Pipeline

The most developed Camera Obscura workflow is:

```text
Guided Detail Reclamation
        |
        v
External Image Denoiser
        |
        v
Stabilized Detail Capture
        |
        v
Color, tone, and other intervening effects
        |
        v
Stabilized Detail Reapply
```

This order lets the user choose detail first, stabilize the resulting image,
store a bounded same-frame residual, allow other effects to run, and then
restore only the stored residual.

Lazara Color Revival has no universal chain position. Put it before the cache
when its color result should influence captured detail, or between Capture and
Reapply when stored structure should be restored after color work. Test both
positions against the complete preset.

Guided Ink Lines is optional. It may follow detail reclamation when the lines
should also be denoised and cached, or run later when its graphic character
should remain untouched.

## Shared Method

Camera Obscura effects generally follow this sequence:

1. **Sample** an explicit current, neighboring, depth, or history signal.
2. **Measure** support, difference, scale, stability, or color evidence.
3. **Decide** whether the evidence has enough authority to act.
4. **Reconstruct** a bounded correction rather than replacing the source
   without limits.
5. **Expose** the decision and applied result through diagnostic views.
6. **Return the source** when the effect, authority, or contribution is zero.

This method makes a failed or overly conservative effect diagnosable. A visible
mask does not prove that the final image changed; inspect the applied
contribution as well.

## Installation Models

The projects currently use three cases.

**Install-ready tree:** External Image Denoiser contains a
`reshade-shaders` folder. Merge that folder into the game's existing
`reshade-shaders` folder.

**Source unit:** Guided Detail, Stabilized Detail Cache, and Lazara Color
Revival retain project-local `effects`, `header`, or `api` folders. Copy each
unit without flattening its sibling directories, then add the effect directory
to ReShade's effect search paths and the supporting directory to its shader
search paths as described by that project's README.

**Include-only library:** Camera Obscura API contains an install-ready
`reshade-shaders` tree but no effect or technique. Merge the tree into the
game's existing `reshade-shaders` directory, then include its core or adopted
specialized headers from a consuming effect. Preserve the adjacent
`camera_obscura/api` and `camera_obscura/header` directories.

All effects depend on the installation's `ReShade.fxh`. OpenSurface does not
bundle or replace that framework header.

## Reading Diagnostics

Diagnostic colors are evidence displays, not alternate production output.
Common conventions include:

- dark or black: little or no admitted evidence;
- brighter masks: stronger admission or contribution;
- middle gray: zero in a signed-detail display;
- green freshness: the cache was written earlier in the same frame;
- heat maps: cold through hot for low through high scalar evidence;
- proof tint: the exact pixels receiving a visible correction.

Some projects provide exposure, bias, contrast, gamma, floor, threshold, and
invert controls for diagnostic readability. Those controls do not change the
production result.

## Test Discipline

For a new game or preset:

1. Confirm a clean ReShade compile before judging the image.
2. Begin from the documented defaults or a named tuning target.
3. Verify depth-dependent views when the effect uses depth.
4. Inspect detection or support before increasing strength.
5. Inspect the applied contribution before deciding an effect does nothing.
6. Test motion, disocclusion, thin geometry, foliage, screen borders, loading
   transitions, and bright contrast where relevant.
7. Return every view to the final composite before evaluating the preset.
8. Record the game, resolution, technique order, settings, and observed result.

## Evidence Boundary

Repository validation proves bounded properties such as local include closure,
source integrity, licensing metadata, expected techniques, and publication
sanitation. Package validators and compatibility compilers add further local
evidence. They do not prove universal ReShade compatibility, visual quality,
performance, depth availability, memory headroom, or stability in every title.

Current evidence and unresolved gates are recorded in
[the validation ledger](../docs/VALIDATION.md). Source lineage is recorded in
[the provenance ledger](../docs/PROVENANCE.md).

## Removal

Disable the technique or remove only that project's installed files. The
projects do not require a shared Camera Obscura runtime. For Stabilized Detail
Cache, disable or remove Capture and Reapply together.

The API has no technique to disable. Remove only its hosted `camera_obscura/api`
and `camera_obscura/header` files after confirming that no installed effect
still includes them.

## License

Original Camera Obscura software in this repository is published under the MIT
License unless an individual file states otherwise. Existing authorship,
third-party notices, and screenshot boundaries continue forward through the
repository [licensing record](../LICENSING.md).
