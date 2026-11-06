# Provenance

## xOSG relocation — 2026-11-05

The reviewed `xOSG/` working tree from revision `276957db0f374edf6fc02b6919e2ec42c8960290` moved to [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg). Its migration manifest records all 100 files and relocation edits. The original MIT notice continues. Earlier xOSG entries below are retained as historical records, including superseded publication states. The source history and private workshop evidence remain preserved.

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

## Camera Obscura API

- Publication authorization: user direction to host the API in OpenSurface
  under `Camera Obscura` on 2026-11-06
- Source basis: reviewed current Camera Obscura development tree; the source
  workspace is not itself a Git checkout, so a source commit identity is
  unavailable rather than inferred
- Hosted surface: 29 API headers and nine adjacent support headers in an
  install-ready `reshade-shaders` layout
- Source identities: 38 pre-publication SHA-256 values retained in
  `Camera Obscura/API/docs/SOURCE_ORIGIN.sha256`
- Publication transform: the repository MIT copyright/SPDX prefix is prepended
  to each hosted header; `tools/validate_package.py` strips that exact prefix
  and confirms all remaining implementation bytes against the origin manifest
- Documentation surface: core semantic reference, complete declaration index,
  machine-readable symbol index, source inventory, validation record, and
  reproducible documentation generator
- Core boundary: seven files are reachable from
  `CAMERA_OBSCURA_API_All.fxh`; 22 API headers are source-present outside that
  umbrella and are not silently presented as wired or stable
- License: hosted public copies follow the repository's MIT publication policy
  and carry inline SPDX metadata
- Generated example consumers: core wrapper walkthrough, Twin Lantern provider
  parity inspection, and complementary transport through the TL09 bounded
  composite contract; stored as dormant `.fx.example` files outside the
  install tree
- Twin Lantern API comparison: the live public 0.1.0 contract registry at
  `alia-june/Lunar-Flower` was inspected at commit
  `864377b03af50779415b59aa4857305831603f70`; all eight registered shared
  implementation files match the hosted OpenSurface copies after removal of
  publication SPDX prefixes
- Example contract boundary: the transport/composite example uses registered
  Twin Lanterns 0.1.0 entrypoints; the parity inspector uses a source-present
  OpenSurface extension outside that versioned twelve-symbol contract
- Fresh public-package evidence: 10/10 bounded package checks pass, including
  38/38 origin implementation parity and 53/53 local include resolution
- Unresolved evidence: no consuming-effect compile, ReShade runtime, target-game
  depth, performance, visual acceptance, or stable-symbol compatibility claim
- Canon boundary: hosting does not replace the accepted frozen runtime rail or
  promote cold receptors

## Package-only Stabilized Color And Luma Caches

- Distribution source:
  `https://github.com/dastardlyrat/Lazara-Reshade-Revival-Package`
- Introduction revision:
  `364ef53991081cec444e2dc0d6aa595fa5d733a0`
- Stabilized Color Cache SHA-256:
  `DCF7389E3BA83E8F73EB9880433F14ABF800CBB2FA9F0D7705779AE5CD655D56`
- Stabilized Luma Cache SHA-256:
  `29FBCDE85ECFADA365A8F7BF484FA99CCE5CC5E955D0DAB95C5648169EB3F952`
- Source state: project-owned direct sources in the Revival package; each
  effect contains a Capture and Reapply technique and depends only on the
  installation-provided `ReShade.fxh`
- License: inline MIT SPDX metadata
- Package evidence: the Revival package validator passes 5/5 for 18 techniques,
  15 effect files, its 110-file shader closure, vendored manifest, and no
  submodules
- OpenSurface state: recorded external package surface; neither effect is
  present in this repository's current tree or source manifest
- Unresolved evidence: no standalone README, focused validator, or recorded
  live compile and visual-acceptance result for either cache pair

## xOSG | expert Overlay System Gestalt

- Source: none
- State: accepted project identity as an AI instrumentation toolset
- Accepted members:
  - Naked Shell
  - Amorphous Durable AI Workspace
  - Synthetic Simulations
- Implementation state: DWSK 0.1.1 is staged under Amorphous Durable AI
  Workspace; Naked Shell remains identity-only; Synthetic Simulations is a
  documentation-only publication of an exercised private prototype
- Authority: user decision for identity and publication family only
- License continuation: future original source defaults to MIT unless a file
  states another SPDX license expression

### Amorphous Durable AI Workspace

#### R4 source-adoption review — 2026-11-04

- Source basis: the qualified R4 repair candidate, preserving R1–R3 behavior and its original source identities.
- Adopted surface: workspace value/recovery implementation, formats, CLI, validation checker, durability contract and recovery playbook.
- Development surface: the two repaired owned-execution helpers under component tools/validation, with a fixed unit/self-check entrypoint and source-only documentation.
- Review base: current private OpenSurface main; all unrelated source and publication records retained.
- Fresh source evidence: 244 R4 checks plus 48 overlapping fixed-entrypoint checks across ordinary and optimized Python; see the component validation report and repository validation ledger.
- Binary evidence boundary: old wheel/sdist identities remain historical; no new package release or installed-wheel result is claimed.
- License continuation: the existing repository MIT annotation covers xOSG source and development tooling; existing notices remain intact.
- Authority boundary: reviewed source adoption only; no logger integration, automatic conversation service, semantic/governance authority or default-branch merge is implied.

#### Earlier source-import record

- Published component: Durable Workspace Development Kit (DWSK) 0.1.1
- Source import: repository commit
  `4c3d8e71d4dc61c2a5d86d5eeeecebb8ea4dd02a` populated the bounded xOSG
  member from its validated source build
- Runtime source: five Python package files under `src/durable_workspace`
- Declared runtime requirement: Python 3.11 or later; standard library only
- Recorded source evidence: 32 hardening, 1,000 deterministic fuzzy, eight
  torture, 17 unit, seven self-validation, 15 CLI, eight retry, and 12 native
  mutex checks; the retained reports distinguish source and installed-artifact
  campaigns
- Fresh OpenSurface evidence: component unit tests, self-validation, and source
  digest checks are recorded in `docs/VALIDATION.md`
- Boundary: durable storage and recovery mechanics only; no automatic
  conversation capture, agent service, semantic authority, or governance
  authority
- Platform ceiling: recorded validation is Windows/Python 3.14 evidence, not
  proof for every interpreter, OS, physical power-loss case, or application
  integration
- Design lineage: `MINING_PROVENANCE.md` records the two informing artifacts
  and expressly does not adopt or claim authority over the Knowledge Core
  design

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
- Defunct experiment: `llm_prompt_hardening_modular_kit_v1_5_candidate.zip`
- Defunct archive SHA-256:
  `D88D0740CD50011F3EC05C6645329D3C6A766755B0AA7A6B005335CEDE13FFE6`
- Disposition authority and date: user-designated failure on 2026-11-01
- Defunct intake result: ZIP CRC and archive paths passed; all 78 manifest
  entries matched; a fresh Windows/Python 3.14.4 run passed 42 of 43 tests
- Reproduced failure: atomic replacement mode test required POSIX `0644` and
  observed `0666` on Windows
- Publication intent: user directed publication as a failed, defunct
  experiment on 2026-11-01
- Current publication state: generated summary and machine-readable receipt
  only; cleaned source import remains pending package-level license confirmation
  and sanitation of the recursive evidence bundle
