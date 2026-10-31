# Provenance

Date: 2026-10-31

## Guided Detail

- Source: `https://github.com/dastardlyrat/OpenSurface-CameraObscura-GuidedDetail`
- Revision: `68850554650abe22cca029a65f7a807b6b3b3047`
- Import state: byte-preserved source and component documentation
- Authority: accepted public staging source

## Stabilized Detail Cache

- Source artifact: `CAMERA_OBSCURA_STABILIZED_DETAIL_CACHE_V1_2026-10-30.zip`
- SHA-256: `5B10BF3A81BD1A00AFCC379D6DCC00D18748FFCEAEC16093578A59EE197C3B4D`
- Import state: effect and API are byte-preserved from the validated package
- Local evidence: 19/19 package validator pass
- Live evidence: user-reported compile and visual pass on 2026-10-31
- Unresolved evidence: loading-transition, high-memory-scene, and long-motion
  checks were not separately asserted in that report

## Lazara Color Revival

- Source: `https://github.com/dastardlyrat/lazara`
- Revision: `d6f80edec87178a9522fb6682765bf2a854f998f`
- Source effect: `reshade-shaders/Shaders/rm/effects/OCCULT_lazara.fx`
- New effect: `Camera Obscura/Lazara Color Revival/effects/OSCO_LazaraColorRevival.fx`
- Import state: generated Camera Obscura refactor

The Lazara algorithm and control defaults are retained. Ownership was reduced
to a dedicated color-input header and diagnostic header. Legacy `OCCULT_RM_67`,
`OCCULT_RM`, and `MIXSR` identifiers are not retained in the active refactored
source. This is a new implementation state and requires its own live compile
and visual regression proof before it supersedes the public Lazara build.

## Naked Shell

- Source: none
- State: reserved empty family
- Authority: folder placement only; no generated architecture is accepted
