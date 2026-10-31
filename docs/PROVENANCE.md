# Provenance

Date: 2026-10-31

## Guided Detail

- Source: `https://github.com/dastardlyrat/OpenSurface-CameraObscura-GuidedDetail`
- Revision: `68850554650abe22cca029a65f7a807b6b3b3047`
- Import state: source imported from the exact revision; SPDX copyright
  metadata was added for publication without changing shader behavior
- Authority: accepted public staging source
- License continuation: existing MIT grant retained
- Original README image: external GitHub attachment returned 404 on 2026-10-31
- Replacement image: locally preserved Guided Detail diagnostic screenshot,
  `Camera Obscura/Guided Detail/docs/images/guided-detail-diagnostic.png`
- Replacement image SHA-256:
  `C60ABB434D48FA2925DC1EB617D8335493FF6B49B0391F19F58E873999678AF3`

## Stabilized Detail Cache

- Source artifact: `CAMERA_OBSCURA_STABILIZED_DETAIL_CACHE_V1_2026-10-30.zip`
- SHA-256: `5B10BF3A81BD1A00AFCC379D6DCC00D18748FFCEAEC16093578A59EE197C3B4D`
- Import state: effect and API are byte-preserved from the validated package
- Local evidence: 19/19 package validator pass
- Live evidence: user-reported compile and visual pass on 2026-10-31
- Unresolved evidence: loading-transition, high-memory-scene, and long-motion
  checks were not separately asserted in that report
- License continuation: project-owned source expressly published under MIT on
  2026-10-31 by owner direction

## External Image Denoiser

- Source artifact:
  `CAMERA_OBSCURA_EXTERNAL_IMAGE_DENOISER_V2_1_MULTISCALE_ORDERED_2026-10-30.zip`
- SHA-256: `15C9F5A91B8143F6FB539153EF280DE133F0B8843DBBD231FDFB189C2EC1F786`
- Import state: effect and API imported from the validated package; SPDX
  publication metadata added without changing shader behavior
- Published layout:
  `Camera Obscura/External Image Denoiser/reshade-shaders/Shaders/camera_obscura_external`
- Local evidence: 30/30 focused validator pass
- Live evidence: user-confirmed application, output multiplier, applied-pixel
  tint, and Detail Reclamation then final-denoiser order
- Unresolved evidence: broader quality, motion, performance, scale, ghosting,
  and artifact acceptance remain open
- Boundary: standalone source-domain denoiser; no Twin Lantern GI generation,
  transport, reconstruction, indirect-light authority, or additive composite
- License continuation: project-owned source expressly published under MIT on
  2026-10-31 by owner direction

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

License continuation: the previously unlicensed project-owned Lazara source is
expressly published under MIT on 2026-10-31 by owner direction. The source
repository, commit, and original authorship remain recorded above.

## xOSG | expert Overlay System Gestalt

- Source: none
- State: accepted project identity as an AI instrumentation toolset
- Accepted members:
  - Naked Shell
  - DWSK | durable workspace
  - Synthetic Simulations
- Implementation state: unstaged for each member
- Authority: user decision for identity and publication family only
- License continuation: future original source defaults to MIT unless a file
  states another SPDX license expression

### Synthetic Simulations

- Private source project: `deterministic_ai_control_plane_v0_4`
- Project version: `0.4.0`
- Source package SHA-256:
  `7BC0651F4432F55DE1A9877DCB800723D032DC5F865A616EA9EC51A7822B6DA0`
- Public import state: documentation only; prototype source is not staged in
  OpenSurface
- Fresh local evidence on 2026-10-31: 31/31 Python unit tests passed
- Verified scope: deterministic contract, evidence, setup, planning, terminal
  reporting, and synthetic-turn behavior exercised by the source test suite
- Boundary: no real model inference, hypervisor isolation, workload execution,
  authorization, semantic task success, or release authority is claimed
- Candidate memory-instrumentation archives:
  - `anonymized_llm_memory_instrumentation_package.zip`, SHA-256
    `3CC411DB83C68E33FC0C8201769EA217B99C45FC508A36A56D2E478DA7BDC15B`
  - `llm_memory_atomized_true_anonymized_package.zip`, SHA-256
    `BC1087C3332E32EE7699AB2FB79BF99134260E32A56D0198ED2CFF612436D61C`
- Candidate state: retained in private intake, not imported into the public
  tree; neither archive contains a license grant
- Intake result: both archives passed bounded path, type, collision, and CRC
  checks; the atomized v2 manifest matched 14 of 15 listed file hashes
- Blocking integrity defect: `12_validation_report.json` hashes to
  `3795c4ace9df9b07a61eab310d1c217f7f83571eba77f5cb51a353b562a3f900`,
  not the manifest's
  `1e5540eeea3f52d3148ef4cb2a2d6b9db62b6915080ba8193690a7d364a939df`
