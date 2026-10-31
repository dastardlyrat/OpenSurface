# Camera Obscura

This folder contains the Camera Obscura effects currently admitted to the
OpenSurface publication repository. Active source is MIT licensed with
component provenance retained.

## Current effects

| Unit | Role | Current evidence |
|---|---|---|
| Guided Detail | Same-surface detail reclamation and guided ink | Imported from accepted public staging source |
| Stabilized Detail Cache | Capture, hold, and later reapply bounded signed detail | Local 19/19; user-reported live compile and visual pass |
| Lazara Color Revival | Source-derived color recovery or intentional luma-preserving degradation | Refactored and renamed here; repository validation required |

These are independent effects, not a mandatory monolithic pipeline. The known
cache workflow is:

1. Guided Detail Reclamation.
2. External denoiser when used.
3. Stabilized Detail Capture.
4. Intervening effects.
5. Stabilized Detail Reapply.

Lazara Color Revival can be placed according to the intended grade and must be
tested against the complete preset rather than assigned a universal position.
