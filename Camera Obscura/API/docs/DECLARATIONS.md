# Camera Obscura API Declaration Reference

Status: **generated declaration inventory; semantic documentation is incomplete**.

This reference is generated from the current development headers under
`reshade-shaders/Shaders/camera_obscura/api`. Exact declarations are `SOURCE`; hashes,
counts, and umbrella reachability are `DERIVED`. File-role summaries are bounded
`GENERATED_SYNTHESIS`. Hosting does not promote the scaffold to frozen runtime canon.

## Coverage

- Source files: **29**
- Core umbrella files: **7**
- Source-present headers outside the core umbrella: **22**
- Includes: **41** (0 unresolved)
- Macros: **170**
- Structs: **24**
- Struct fields: **611**
- Functions: **120**
- Resources: **0**

The tables below prove declaration coverage, not semantic correctness, stable
public-API status, compilation, runtime behavior, performance, or visual quality.

## `CAMERA_OBSCURA_API_All.fxh`

Classification: `CORE_UMBRELLA`  
Role: Core API umbrella include.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_All.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_All.fxh)  
SHA-256: `9AB3DEE8DE71384ED4505F2F871EDBD172EEDCF21846140A9E7EF519E199EC42`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |
| 8 | `CAMERA_OBSCURA_API_Services.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Services.fxh` | yes |
| 9 | `CAMERA_OBSCURA_API_Providers.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Providers.fxh` | yes |
| 10 | `CAMERA_OBSCURA_API_Cohesion.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Cohesion.fxh` | yes |
| 11 | `CAMERA_OBSCURA_API_Debug.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Debug.fxh` | yes |
| 12 | `CAMERA_OBSCURA_API_Transmigration.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Transmigration.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_ALL_FXH` | `—` | include guard |

## `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.fxh)  
SHA-256: `CE976DE1F41C15F8899A9E1710D1E95A7DB8F2DDF859260A4FCD3996FD8D345D`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 6 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_APPLICATION_BOUNDARY_EVIDENCE_FXH` | `—` | include guard |
| 7 | `CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_BYPASS` | `0.0` | constant |
| 8 | `CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_REJECTED` | `1.0` | constant |
| 9 | `CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_APPLIED` | `2.0` | constant |
| 10 | `CAMERA_OBSCURA_API_APPLICATION_EVIDENCE_CLASS_INVALID` | `3.0` | constant |

### Struct `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 18 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.valid` | `float` |
| 19 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.source_valid` | `float` |
| 20 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.donor_valid` | `float` |
| 21 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.donor_accepted` | `float` |
| 22 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.donor_flags_binary` | `float` |
| 23 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.application_ready` | `float` |
| 24 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.requested_strength` | `float` |
| 25 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.effective_strength` | `float` |
| 26 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.strength_values_valid` | `float` |
| 27 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.strength_consistent` | `float` |
| 28 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.confidence` | `float` |
| 29 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.requested_energy` | `float` |
| 30 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.effective_energy` | `float` |
| 31 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.energy_values_valid` | `float` |
| 32 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.energy_consistent` | `float` |
| 33 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_adjustment_flags` | `float` |
| 34 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_adjustment_flags` | `float` |
| 35 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.adjustment_values_valid` | `float` |
| 36 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.adjustment_consistent` | `float` |
| 37 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_contribution_r` | `float` |
| 38 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_contribution_g` | `float` |
| 39 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_contribution_b` | `float` |
| 40 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_contribution_r` | `float` |
| 41 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_contribution_g` | `float` |
| 42 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_contribution_b` | `float` |
| 43 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.contribution_values_valid` | `float` |
| 44 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.contribution_consistent` | `float` |
| 45 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_composite_r` | `float` |
| 46 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_composite_g` | `float` |
| 47 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_composite_b` | `float` |
| 48 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_composite_r` | `float` |
| 49 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_composite_g` | `float` |
| 50 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_composite_b` | `float` |
| 51 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.composite_values_valid` | `float` |
| 52 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.composite_consistent` | `float` |
| 53 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_applied` | `float` |
| 54 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_applied` | `float` |
| 55 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.applied_binary` | `float` |
| 56 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.applied_consistent` | `float` |
| 57 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.applied_readiness_consistent` | `float` |
| 58 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.expected_reason` | `float` |
| 59 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.observed_reason` | `float` |
| 60 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.reason_values_valid` | `float` |
| 61 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.reason_consistent` | `float` |
| 62 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.applied_reason_consistent` | `float` |
| 63 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.donor_stamp` | `float` |
| 64 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.policy_stamp` | `float` |
| 65 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.energy_stamp` | `float` |
| 66 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.application_stamp` | `float` |
| 67 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.generation_stamp` | `float` |
| 68 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 71 | `float CAMERA_OBSCURA_API_ApplicationEvidence_Near(float leftValue, float rightValue)` | not yet semantically documented |
| 76 | `float CAMERA_OBSCURA_API_ApplicationEvidence_LessEqual(float value, float upperBound)` | not yet semantically documented |
| 81 | `float CAMERA_OBSCURA_API_ApplicationEvidence_Binary(float value)` | not yet semantically documented |
| 86 | `float CAMERA_OBSCURA_API_ApplicationEvidence_Whole(float value)` | not yet semantically documented |
| 91 | `float CAMERA_OBSCURA_API_ApplicationEvidence_Range(float value, float minimumValue, float maximumValue)` | not yet semantically documented |
| 98 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence CAMERA_OBSCURA_API_DefaultApplicationBoundaryEvidence()` | not yet semantically documented |
| 155 | `CAMERA_OBSCURA_API_ApplicationBoundaryEvidence CAMERA_OBSCURA_API_BuildApplicationBoundaryEvidence(float donorValid,float donorAccepted,float requestedStrength,float effectiveStrength,float confidence, float requestedEnergy,float effectiveEnergy,float expectedAdjustmentFlags,float observedAdjustmentFlags, float3 expectedContribution,float3 observedContribution,float3 expectedComposite,float3 observedComposite, float expectedApplied,float observedApplied,float expectedReason,float observedReason,float evidenceValid, float donorStamp,float policyStamp,float energyStamp,float applicationStamp,float generationStamp,float sourceStageStamp)` | not yet semantically documented |
| 204 | `float CAMERA_OBSCURA_API_ApplicationBoundaryClass(CAMERA_OBSCURA_API_ApplicationBoundaryEvidence evidence)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_Cohesion.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Dual-hit, contribution, fallback, resolve, and composite wrappers.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Cohesion.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Cohesion.fxh)  
SHA-256: `716412FA81B0FDAF36B40FD6135BB02EA346059BF9E646430E0E9284A59577C0`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Providers.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Providers.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTransport.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTransport.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_COHESION_FXH` | `—` | include guard |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 10 | `CAMERA_OBSCURA_DualHit CAMERA_OBSCURA_API_EvaluateDualHit(CAMERA_OBSCURA_Hit dda, CAMERA_OBSCURA_Hit march)` | documented in `CORE_REFERENCE.md` |
| 17 | `CAMERA_OBSCURA_Contribution CAMERA_OBSCURA_API_BuildContribution(CAMERA_OBSCURA_API_Context context, CAMERA_OBSCURA_SurfaceGuide surface, CAMERA_OBSCURA_Hit hit)` | documented in `CORE_REFERENCE.md` |
| 28 | `CAMERA_OBSCURA_Fallback CAMERA_OBSCURA_API_DefaultFallback(CAMERA_OBSCURA_API_Context context, CAMERA_OBSCURA_SurfaceGuide surface)` | documented in `CORE_REFERENCE.md` |
| 35 | `float4 CAMERA_OBSCURA_API_Resolve(CAMERA_OBSCURA_DualHit dual, CAMERA_OBSCURA_Contribution ddaContribution, CAMERA_OBSCURA_Contribution marchContribution, CAMERA_OBSCURA_Fallback fallback)` | documented in `CORE_REFERENCE.md` |
| 48 | `float3 CAMERA_OBSCURA_API_Composite(CAMERA_OBSCURA_Fallback fallback, float4 resolved, float strength)` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_Common.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Scaffold version, stage identifiers, context record, and context construction.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh)  
SHA-256: `78AE3DBF06F2E735835414A07330E31AB384CB79367D3AEE6DD0657DB5FF9567`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_AtomicCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicCommon.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_COMMON_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MAJOR` | `1` | constant |
| 10 | `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MINOR` | `0` | constant |
| 11 | `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_PATCH` | `0` | constant |
| 13 | `CAMERA_OBSCURA_API_STAGE_TRUTH` | `1` | constant |
| 14 | `CAMERA_OBSCURA_API_STAGE_PROVIDERS` | `2` | constant |
| 15 | `CAMERA_OBSCURA_API_STAGE_COHESION` | `3` | constant |

### Struct `CAMERA_OBSCURA_API_Context`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 19 | `CAMERA_OBSCURA_API_Context.uv` | `float2` |
| 20 | `CAMERA_OBSCURA_API_Context.pixel` | `float2` |
| 21 | `CAMERA_OBSCURA_API_Context.spatial_phase` | `float` |
| 22 | `CAMERA_OBSCURA_API_Context.stage` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 25 | `CAMERA_OBSCURA_API_Context CAMERA_OBSCURA_API_MakeContext(float2 uv, float2 pixel, float spatialPhase, float stage)` | documented in `CORE_REFERENCE.md` |
| 39 | `float CAMERA_OBSCURA_API_VersionCode()` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_Debug.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Central debug-view wrapper.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Debug.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Debug.fxh)  
SHA-256: `E4607438EE47B51C5407CFD71D2746E6042106629BDACB097C123153F88BCF12`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Cohesion.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Cohesion.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_AtomicDebug.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicDebug.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_DEBUG_FXH` | `—` | include guard |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 10 | `float3 CAMERA_OBSCURA_API_DebugView(float view, float3 source, float3 composite, CAMERA_OBSCURA_Hit dda, CAMERA_OBSCURA_Hit march, CAMERA_OBSCURA_DualHit dual, CAMERA_OBSCURA_Contribution ddaContribution, CAMERA_OBSCURA_Contribution marchContribution)` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_DepthGateEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DepthGateEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DepthGateEvidence.fxh)  
SHA-256: `CD753D5D666F7A17FCD32934D4A71F01D241B304367E30D8A08A3461162B76B3`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_DEPTH_GATE_EVIDENCE_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_DEPTH_GATE_NONE` | `0.0` | constant |
| 10 | `CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_HARD` | `1.0` | constant |
| 11 | `CAMERA_OBSCURA_API_DEPTH_GATE_SAME_LAYER_SOFT` | `2.0` | constant |
| 12 | `CAMERA_OBSCURA_API_DEPTH_GATE_FAR_ONLY` | `3.0` | constant |
| 13 | `CAMERA_OBSCURA_API_DEPTH_GATE_NEAR_SUPPRESS` | `4.0` | constant |
| 15 | `CAMERA_OBSCURA_API_DEPTH_MISSING_REJECT` | `0.0` | constant |
| 16 | `CAMERA_OBSCURA_API_DEPTH_MISSING_PASS` | `1.0` | constant |
| 18 | `CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BYPASS` | `0.0` | constant |
| 19 | `CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_BINARY` | `1.0` | constant |
| 20 | `CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_WEIGHTED` | `2.0` | constant |
| 21 | `CAMERA_OBSCURA_API_DEPTH_GATE_CLASS_INVALID` | `3.0` | constant |

### Struct `CAMERA_OBSCURA_API_DepthGateEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 29 | `CAMERA_OBSCURA_API_DepthGateEvidence.valid` | `float` |
| 31 | `CAMERA_OBSCURA_API_DepthGateEvidence.gate_mode` | `float` |
| 32 | `CAMERA_OBSCURA_API_DepthGateEvidence.gate_mode_recognized` | `float` |
| 33 | `CAMERA_OBSCURA_API_DepthGateEvidence.depth_missing_mode` | `float` |
| 34 | `CAMERA_OBSCURA_API_DepthGateEvidence.depth_missing_mode_recognized` | `float` |
| 36 | `CAMERA_OBSCURA_API_DepthGateEvidence.center_depth` | `float` |
| 37 | `CAMERA_OBSCURA_API_DepthGateEvidence.sample_depth` | `float` |
| 38 | `CAMERA_OBSCURA_API_DepthGateEvidence.depth_available` | `float` |
| 39 | `CAMERA_OBSCURA_API_DepthGateEvidence.depth_missing` | `float` |
| 40 | `CAMERA_OBSCURA_API_DepthGateEvidence.depth_delta` | `float` |
| 42 | `CAMERA_OBSCURA_API_DepthGateEvidence.reject_threshold` | `float` |
| 43 | `CAMERA_OBSCURA_API_DepthGateEvidence.reject_softness` | `float` |
| 44 | `CAMERA_OBSCURA_API_DepthGateEvidence.far_start` | `float` |
| 45 | `CAMERA_OBSCURA_API_DepthGateEvidence.far_feather` | `float` |
| 46 | `CAMERA_OBSCURA_API_DepthGateEvidence.near_end` | `float` |
| 47 | `CAMERA_OBSCURA_API_DepthGateEvidence.near_feather` | `float` |
| 48 | `CAMERA_OBSCURA_API_DepthGateEvidence.parameters_adjusted` | `float` |
| 50 | `CAMERA_OBSCURA_API_DepthGateEvidence.missing_fallback_weight` | `float` |
| 51 | `CAMERA_OBSCURA_API_DepthGateEvidence.same_layer_hard_weight` | `float` |
| 52 | `CAMERA_OBSCURA_API_DepthGateEvidence.same_layer_soft_weight` | `float` |
| 53 | `CAMERA_OBSCURA_API_DepthGateEvidence.far_mask` | `float` |
| 54 | `CAMERA_OBSCURA_API_DepthGateEvidence.near_mask` | `float` |
| 56 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_none` | `float` |
| 57 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_hard` | `float` |
| 58 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_soft` | `float` |
| 59 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_far` | `float` |
| 60 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_near` | `float` |
| 61 | `CAMERA_OBSCURA_API_DepthGateEvidence.route_missing` | `float` |
| 63 | `CAMERA_OBSCURA_API_DepthGateEvidence.expected_gate_weight` | `float` |
| 64 | `CAMERA_OBSCURA_API_DepthGateEvidence.observed_gate_weight` | `float` |
| 65 | `CAMERA_OBSCURA_API_DepthGateEvidence.observed_consistent` | `float` |
| 66 | `CAMERA_OBSCURA_API_DepthGateEvidence.full_pass` | `float` |
| 67 | `CAMERA_OBSCURA_API_DepthGateEvidence.full_reject` | `float` |
| 68 | `CAMERA_OBSCURA_API_DepthGateEvidence.partial_weight` | `float` |
| 69 | `CAMERA_OBSCURA_API_DepthGateEvidence.gate_consistent` | `float` |
| 71 | `CAMERA_OBSCURA_API_DepthGateEvidence.request_stamp` | `float` |
| 72 | `CAMERA_OBSCURA_API_DepthGateEvidence.surface_stamp` | `float` |
| 73 | `CAMERA_OBSCURA_API_DepthGateEvidence.sample_stamp` | `float` |
| 74 | `CAMERA_OBSCURA_API_DepthGateEvidence.policy_stamp` | `float` |
| 75 | `CAMERA_OBSCURA_API_DepthGateEvidence.gate_stamp` | `float` |
| 76 | `CAMERA_OBSCURA_API_DepthGateEvidence.generation_stamp` | `float` |
| 77 | `CAMERA_OBSCURA_API_DepthGateEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 80 | `float CAMERA_OBSCURA_API_DepthGateValueNear(float leftValue, float rightValue)` | not yet semantically documented |
| 87 | `float CAMERA_OBSCURA_API_DepthGateSmoothRange(float rangeStart, float rangeWidth, float value)` | not yet semantically documented |
| 312 | `float CAMERA_OBSCURA_API_DepthGateClass(CAMERA_OBSCURA_API_DepthGateEvidence evidence)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_DepthTruth.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DepthTruth.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DepthTruth.fxh)  
SHA-256: `9C5D78C1B60CAA6A35482E90C7E51D2E1CC6B546C9009F85CD201635CFBFCC8F`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_AtomicCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicCommon.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_DEPTH_TRUTH_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_DEPTH_TRUTH_VERSION` | `1` | constant |
| 11 | `CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NONE` | `0` | constant |
| 12 | `CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NEAR` | `1` | constant |
| 13 | `CAMERA_OBSCURA_API_DEPTH_ENDPOINT_FAR_OR_SKY` | `2` | constant |
| 14 | `CAMERA_OBSCURA_API_DEPTH_ENDPOINT_NUMERIC_INVALID` | `3` | constant |
| 16 | `CAMERA_OBSCURA_API_DEPTH_REASON_UNINITIALIZED` | `0` | constant |
| 17 | `CAMERA_OBSCURA_API_DEPTH_REASON_VALID_FLAT` | `1` | constant |
| 18 | `CAMERA_OBSCURA_API_DEPTH_REASON_VALID_EDGE` | `2` | constant |
| 19 | `CAMERA_OBSCURA_API_DEPTH_REASON_UNAVAILABLE` | `3` | constant |
| 20 | `CAMERA_OBSCURA_API_DEPTH_REASON_INVALID_SAMPLE` | `4` | constant |
| 21 | `CAMERA_OBSCURA_API_DEPTH_REASON_NEAR_ENDPOINT` | `5` | constant |
| 22 | `CAMERA_OBSCURA_API_DEPTH_REASON_FAR_OR_SKY` | `6` | constant |
| 25 | `CAMERA_OBSCURA_API_DEPTH_TRUTH_ENDPOINT_EPSILON` | `0.000001` | constant |
| 29 | `CAMERA_OBSCURA_API_DEPTH_TRUTH_EDGE_SCALE` | `40.0` | constant |

### Struct `CAMERA_OBSCURA_API_DepthTruth`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 34 | `CAMERA_OBSCURA_API_DepthTruth.capability_available` | `float` |
| 35 | `CAMERA_OBSCURA_API_DepthTruth.acquisition_attempted` | `float` |
| 36 | `CAMERA_OBSCURA_API_DepthTruth.sample_valid` | `float` |
| 37 | `CAMERA_OBSCURA_API_DepthTruth.depth_value` | `float` |
| 38 | `CAMERA_OBSCURA_API_DepthTruth.depth_metric` | `float` |
| 39 | `CAMERA_OBSCURA_API_DepthTruth.endpoint_or_sky_state` | `float` |
| 40 | `CAMERA_OBSCURA_API_DepthTruth.local_activity` | `float` |
| 41 | `CAMERA_OBSCURA_API_DepthTruth.edge_risk` | `float` |
| 42 | `CAMERA_OBSCURA_API_DepthTruth.confidence` | `float` |
| 43 | `CAMERA_OBSCURA_API_DepthTruth.authority` | `float` |
| 44 | `CAMERA_OBSCURA_API_DepthTruth.reason` | `float` |
| 45 | `CAMERA_OBSCURA_API_DepthTruth.depth_reads` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 48 | `CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_MakeDepthTruth()` | not yet semantically documented |
| 66 | `float CAMERA_OBSCURA_API_DepthTruthFinite(float value)` | not yet semantically documented |
| 71 | `float CAMERA_OBSCURA_API_DepthTruthSampleValid(float depth)` | not yet semantically documented |
| 83 | `float CAMERA_OBSCURA_API_DepthTruthEndpointState(float depth)` | not yet semantically documented |
| 108 | `float CAMERA_OBSCURA_API_DepthTruthAuthority(float capabilityAvailable, float sampleValid, float confidence)` | not yet semantically documented |
| 119 | `float CAMERA_OBSCURA_API_DepthTruthReady(CAMERA_OBSCURA_API_DepthTruth truth, float confidenceMinimum)` | not yet semantically documented |
| 131 | `CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthFromSamples(float capabilityAvailable, float acquisitionAttempted, float depthMetric, float centerDepth, float leftDepth, float rightDepth, float downDepth, float upDepth, float depthReads)` | not yet semantically documented |
| 203 | `CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthUnavailable()` | not yet semantically documented |
| 210 | `CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthLiveAvailable(float2 uv, float depthMetric)` | not yet semantically documented |
| 238 | `CAMERA_OBSCURA_API_DepthTruth CAMERA_OBSCURA_API_BuildDepthTruthSynthetic(float syntheticMode)` | not yet semantically documented |
| 281 | `float3 CAMERA_OBSCURA_API_DepthTruthReasonColor(float reason)` | not yet semantically documented |
| 298 | `float3 CAMERA_OBSCURA_API_DepthTruthEndpointColor(float endpointState)` | not yet semantically documented |
| 309 | `float3 CAMERA_OBSCURA_API_DepthTruthDebugView(CAMERA_OBSCURA_API_DepthTruth truth, float view, float confidenceMinimum)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_DonorProvenanceEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DonorProvenanceEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_DonorProvenanceEvidence.fxh)  
SHA-256: `EFD1C75AA09512E236DB591FEDFEA50E820147FC45E1EF35594469E165F5550A`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_DONOR_PROVENANCE_EVIDENCE_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_NO_TRACE` | `0.0` | constant |
| 10 | `CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_REJECTED` | `1.0` | constant |
| 11 | `CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_ACCEPTED` | `2.0` | constant |
| 12 | `CAMERA_OBSCURA_API_DONOR_EVIDENCE_CLASS_INVALID` | `3.0` | constant |

### Struct `CAMERA_OBSCURA_API_DonorProvenanceEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 20 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.valid` | `float` |
| 21 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.source_valid` | `float` |
| 22 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.trace_ready` | `float` |
| 23 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.trace_ready_binary` | `float` |
| 24 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.candidate_count` | `float` |
| 25 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.candidate_count_valid` | `float` |
| 26 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_index` | `float` |
| 27 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_index_valid` | `float` |
| 28 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_in_range` | `float` |
| 29 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selection_state_consistent` | `float` |
| 30 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.receiver_u` | `float` |
| 31 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.receiver_v` | `float` |
| 32 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.receiver_uv_valid` | `float` |
| 33 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_u` | `float` |
| 34 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_v` | `float` |
| 35 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selected_uv_valid` | `float` |
| 36 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.edge_safety` | `float` |
| 37 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.donor_chroma` | `float` |
| 38 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.color_delta` | `float` |
| 39 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.donor_luma` | `float` |
| 40 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.normal_compatibility` | `float` |
| 41 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.score` | `float` |
| 42 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.metrics_valid` | `float` |
| 43 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.edge_gate` | `float` |
| 44 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.chroma_gate` | `float` |
| 45 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.delta_gate` | `float` |
| 46 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.luma_gate` | `float` |
| 47 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.normal_gate` | `float` |
| 48 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.score_gate` | `float` |
| 49 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.gates_binary` | `float` |
| 50 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.expected_accepted` | `float` |
| 51 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.observed_accepted` | `float` |
| 52 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.acceptance_binary` | `float` |
| 53 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.acceptance_consistent` | `float` |
| 54 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.accepted_gate_consistent` | `float` |
| 55 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.expected_reason` | `float` |
| 56 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.observed_reason` | `float` |
| 57 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.reason_values_valid` | `float` |
| 58 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.reason_consistent` | `float` |
| 59 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.accepted_reason_consistent` | `float` |
| 60 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.expected_reject_mask` | `float` |
| 61 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.observed_reject_mask` | `float` |
| 62 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.reject_mask_values_valid` | `float` |
| 63 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.reject_mask_consistent` | `float` |
| 64 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.accepted_mask_consistent` | `float` |
| 65 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.request_stamp` | `float` |
| 66 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.trace_stamp` | `float` |
| 67 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.selection_stamp` | `float` |
| 68 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.evaluation_stamp` | `float` |
| 69 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.generation_stamp` | `float` |
| 70 | `CAMERA_OBSCURA_API_DonorProvenanceEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 74 | `float CAMERA_OBSCURA_API_DonorEvidence_Near(float leftValue, float rightValue)` | not yet semantically documented |
| 79 | `float CAMERA_OBSCURA_API_DonorEvidence_LessEqual(float value, float upperBound)` | not yet semantically documented |
| 84 | `float CAMERA_OBSCURA_API_DonorEvidence_Binary(float value)` | not yet semantically documented |
| 89 | `float CAMERA_OBSCURA_API_DonorEvidence_Whole(float value)` | not yet semantically documented |
| 94 | `float CAMERA_OBSCURA_API_DonorEvidence_Range(float value, float minimumValue, float maximumValue)` | not yet semantically documented |
| 302 | `float CAMERA_OBSCURA_API_DonorProvenanceClass(CAMERA_OBSCURA_API_DonorProvenanceEvidence evidence)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_FacadeLifecycle.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_FacadeLifecycle.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_FacadeLifecycle.fxh)  
SHA-256: `42D7632FA626AB0A2002BDA04404E8B89E4DCC2FBB888B2BE03157E5EAF81FE5`

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_FACADE_LIFECYCLE_FXH` | `—` | include guard |
| 12 | `CAMERA_OBSCURA_API_FACADE_STATE_CURRENT_ACTIVE` | `0` | constant |
| 13 | `CAMERA_OBSCURA_API_FACADE_STATE_HOLD_REPLACEMENT` | `1` | constant |
| 14 | `CAMERA_OBSCURA_API_FACADE_STATE_REMOVAL_ALLOWED` | `2` | constant |
| 15 | `CAMERA_OBSCURA_API_FACADE_STATE_HOLD_ROLLBACK` | `3` | constant |
| 16 | `CAMERA_OBSCURA_API_FACADE_STATE_LEGACY_BLOCKED` | `4` | constant |

### Struct `CAMERA_OBSCURA_API_FacadeLifecycleDecision`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 20 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision.facade_active` | `float` |
| 21 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision.current_selected` | `float` |
| 22 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision.removal_allowed` | `float` |
| 23 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision.legacy_blocked` | `float` |
| 24 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision.state` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 27 | `float CAMERA_OBSCURA_API_FacadeFlag(float value)` | not yet semantically documented |
| 32 | `CAMERA_OBSCURA_API_FacadeLifecycleDecision CAMERA_OBSCURA_API_EvaluateFacadeLifecycle(float publicSurfacePresent, float currentReplacementReady, float replacementProven, float legacyDependencyPresent, float rollbackReady, float removalRequested)` | not yet semantically documented |
| 82 | `float CAMERA_OBSCURA_API_FacadeLifecycleColdReady(CAMERA_OBSCURA_API_FacadeLifecycleDecision decision)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_ProviderIdentity.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ProviderIdentity.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ProviderIdentity.fxh)  
SHA-256: `A796411677FE225B517140E7AA003A163FD8224C74CC8AD9E3B29D8E1AAC005B`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_AtomicCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicCommon.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_PROVIDER_IDENTITY_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_PROVIDER_IDENTITY_VERSION` | `1` | constant |
| 11 | `CAMERA_OBSCURA_API_PROVIDER_SOURCE_NONE` | `0` | constant |
| 12 | `CAMERA_OBSCURA_API_PROVIDER_SOURCE_LIVE` | `1` | constant |
| 13 | `CAMERA_OBSCURA_API_PROVIDER_SOURCE_CACHE` | `2` | constant |
| 15 | `CAMERA_OBSCURA_API_CACHE_MODE_LIVE_ONLY` | `0` | constant |
| 16 | `CAMERA_OBSCURA_API_CACHE_MODE_PREFER_CACHE` | `1` | constant |
| 17 | `CAMERA_OBSCURA_API_CACHE_MODE_CACHE_ONLY` | `2` | constant |
| 18 | `CAMERA_OBSCURA_API_CACHE_MODE_PREFER_LIVE` | `3` | constant |
| 20 | `CAMERA_OBSCURA_API_FALLBACK_NONE` | `0` | constant |
| 21 | `CAMERA_OBSCURA_API_FALLBACK_LIVE` | `1` | constant |
| 22 | `CAMERA_OBSCURA_API_FALLBACK_CACHE` | `2` | constant |
| 23 | `CAMERA_OBSCURA_API_FALLBACK_SOURCE_PASSTHROUGH` | `3` | constant |
| 25 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_UNINITIALIZED` | `0` | constant |
| 26 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY` | `1` | constant |
| 27 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_READY_ZERO_FILLED` | `2` | constant |
| 28 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_ABSENT` | `3` | constant |
| 29 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_CAPABILITY_UNAVAILABLE` | `4` | constant |
| 30 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_VALUE_INVALID` | `5` | constant |
| 31 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_PRODUCER_MISMATCH` | `6` | constant |
| 32 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_POLICY_MISMATCH` | `7` | constant |
| 33 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_GENERATION_STALE` | `8` | constant |
| 34 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_SOURCE_STAGE_MISMATCH` | `9` | constant |
| 35 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_RESOLUTION_MISMATCH` | `10` | constant |
| 36 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_METRIC_MISMATCH` | `11` | constant |
| 37 | `CAMERA_OBSCURA_API_PROVIDER_CANDIDATE_REASON_NUMERIC_INVALID` | `12` | constant |
| 39 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_UNINITIALIZED` | `20` | constant |
| 40 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_SELECTED` | `21` | constant |
| 41 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_SELECTED` | `22` | constant |
| 42 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_LIVE` | `23` | constant |
| 43 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_FALLBACK_TO_CACHE` | `24` | constant |
| 44 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_LIVE_ONLY_UNAVAILABLE` | `25` | constant |
| 45 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_ONLY_UNAVAILABLE` | `26` | constant |
| 46 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_NO_READY_SOURCE` | `27` | constant |
| 47 | `CAMERA_OBSCURA_API_PROVIDER_DECISION_REASON_CACHE_MODE_INVALID` | `28` | constant |
| 50 | `CAMERA_OBSCURA_API_PROVIDER_IDENTITY_EPSILON` | `0.000001` | constant |

### Struct `CAMERA_OBSCURA_API_ProviderDescriptor`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 55 | `CAMERA_OBSCURA_API_ProviderDescriptor.record_present` | `float` |
| 56 | `CAMERA_OBSCURA_API_ProviderDescriptor.capability_available` | `float` |
| 57 | `CAMERA_OBSCURA_API_ProviderDescriptor.producer_id` | `float` |
| 58 | `CAMERA_OBSCURA_API_ProviderDescriptor.policy_id` | `float` |
| 59 | `CAMERA_OBSCURA_API_ProviderDescriptor.generation` | `float` |
| 60 | `CAMERA_OBSCURA_API_ProviderDescriptor.source_stage_id` | `float` |
| 61 | `CAMERA_OBSCURA_API_ProviderDescriptor.resolution_id` | `float` |
| 62 | `CAMERA_OBSCURA_API_ProviderDescriptor.metric_id` | `float` |
| 63 | `CAMERA_OBSCURA_API_ProviderDescriptor.value_valid` | `float` |
| 64 | `CAMERA_OBSCURA_API_ProviderDescriptor.zero_filled` | `float` |

### Struct `CAMERA_OBSCURA_API_ProviderDecision`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 69 | `CAMERA_OBSCURA_API_ProviderDecision.cache_mode` | `float` |
| 70 | `CAMERA_OBSCURA_API_ProviderDecision.cache_mode_valid` | `float` |
| 72 | `CAMERA_OBSCURA_API_ProviderDecision.live_present` | `float` |
| 73 | `CAMERA_OBSCURA_API_ProviderDecision.live_capability` | `float` |
| 74 | `CAMERA_OBSCURA_API_ProviderDecision.live_value_valid` | `float` |
| 75 | `CAMERA_OBSCURA_API_ProviderDecision.live_zero_filled` | `float` |
| 76 | `CAMERA_OBSCURA_API_ProviderDecision.live_numeric_valid` | `float` |
| 77 | `CAMERA_OBSCURA_API_ProviderDecision.live_producer_match` | `float` |
| 78 | `CAMERA_OBSCURA_API_ProviderDecision.live_policy_match` | `float` |
| 79 | `CAMERA_OBSCURA_API_ProviderDecision.live_generation_match` | `float` |
| 80 | `CAMERA_OBSCURA_API_ProviderDecision.live_source_stage_match` | `float` |
| 81 | `CAMERA_OBSCURA_API_ProviderDecision.live_resolution_match` | `float` |
| 82 | `CAMERA_OBSCURA_API_ProviderDecision.live_metric_match` | `float` |
| 83 | `CAMERA_OBSCURA_API_ProviderDecision.live_identity_valid` | `float` |
| 84 | `CAMERA_OBSCURA_API_ProviderDecision.live_ready` | `float` |
| 85 | `CAMERA_OBSCURA_API_ProviderDecision.live_reason` | `float` |
| 87 | `CAMERA_OBSCURA_API_ProviderDecision.cache_present` | `float` |
| 88 | `CAMERA_OBSCURA_API_ProviderDecision.cache_capability` | `float` |
| 89 | `CAMERA_OBSCURA_API_ProviderDecision.cache_value_valid` | `float` |
| 90 | `CAMERA_OBSCURA_API_ProviderDecision.cache_zero_filled` | `float` |
| 91 | `CAMERA_OBSCURA_API_ProviderDecision.cache_numeric_valid` | `float` |
| 92 | `CAMERA_OBSCURA_API_ProviderDecision.cache_producer_match` | `float` |
| 93 | `CAMERA_OBSCURA_API_ProviderDecision.cache_policy_match` | `float` |
| 94 | `CAMERA_OBSCURA_API_ProviderDecision.cache_generation_match` | `float` |
| 95 | `CAMERA_OBSCURA_API_ProviderDecision.cache_source_stage_match` | `float` |
| 96 | `CAMERA_OBSCURA_API_ProviderDecision.cache_resolution_match` | `float` |
| 97 | `CAMERA_OBSCURA_API_ProviderDecision.cache_metric_match` | `float` |
| 98 | `CAMERA_OBSCURA_API_ProviderDecision.cache_identity_valid` | `float` |
| 99 | `CAMERA_OBSCURA_API_ProviderDecision.cache_ready` | `float` |
| 100 | `CAMERA_OBSCURA_API_ProviderDecision.cache_stale` | `float` |
| 101 | `CAMERA_OBSCURA_API_ProviderDecision.cache_reason` | `float` |
| 103 | `CAMERA_OBSCURA_API_ProviderDecision.selected_source` | `float` |
| 104 | `CAMERA_OBSCURA_API_ProviderDecision.selected_producer_id` | `float` |
| 105 | `CAMERA_OBSCURA_API_ProviderDecision.selected_policy_id` | `float` |
| 106 | `CAMERA_OBSCURA_API_ProviderDecision.selected_generation` | `float` |
| 107 | `CAMERA_OBSCURA_API_ProviderDecision.selected_source_stage_id` | `float` |
| 108 | `CAMERA_OBSCURA_API_ProviderDecision.selected_resolution_id` | `float` |
| 109 | `CAMERA_OBSCURA_API_ProviderDecision.selected_metric_id` | `float` |
| 110 | `CAMERA_OBSCURA_API_ProviderDecision.fallback_disposition` | `float` |
| 111 | `CAMERA_OBSCURA_API_ProviderDecision.fallback_used` | `float` |
| 112 | `CAMERA_OBSCURA_API_ProviderDecision.ready` | `float` |
| 113 | `CAMERA_OBSCURA_API_ProviderDecision.reason` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 116 | `CAMERA_OBSCURA_API_ProviderDescriptor CAMERA_OBSCURA_API_MakeProviderDescriptor()` | not yet semantically documented |
| 132 | `CAMERA_OBSCURA_API_ProviderDescriptor CAMERA_OBSCURA_API_BuildProviderDescriptor(float recordPresent, float capabilityAvailable, float producerId, float policyId, float generationId, float sourceStageId, float resolutionId, float metricId, float valueValid, float zeroFilled)` | not yet semantically documented |
| 158 | `CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_MakeProviderDecision()` | not yet semantically documented |
| 209 | `float CAMERA_OBSCURA_API_ProviderIdentityFinite(float value)` | not yet semantically documented |
| 214 | `float CAMERA_OBSCURA_API_ProviderIdentityApprox(float value, float expected)` | not yet semantically documented |
| 221 | `float CAMERA_OBSCURA_API_ProviderIdentityInteger(float value)` | not yet semantically documented |
| 230 | `float CAMERA_OBSCURA_API_ProviderDescriptorNumericValid(CAMERA_OBSCURA_API_ProviderDescriptor descriptor)` | not yet semantically documented |
| 246 | `float CAMERA_OBSCURA_API_ProviderCandidateReason(float numericValid, float present, float capability, float valueValid, float producerMatch, float policyMatch, float generationMatch, float sourceStageMatch, float resolutionMatch, float metricMatch, float zeroFilled)` | not yet semantically documented |
| 285 | `CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_BuildProviderDecision(float expectedProducerId, float expectedPolicyId, float expectedGeneration, float expectedSourceStageId, float expectedResolutionId, float expectedMetricId, float cacheMode, CAMERA_OBSCURA_API_ProviderDescriptor liveDescriptor, CAMERA_OBSCURA_API_ProviderDescriptor cacheDescriptor)` | not yet semantically documented |
| 504 | `CAMERA_OBSCURA_API_ProviderDecision CAMERA_OBSCURA_API_BuildProviderDecisionSynthetic(float syntheticMode)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ProviderLifecycleEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_ProviderLifecycleEvidence.fxh)  
SHA-256: `D371FE1D8D2AD20D84C8479288EA976F3B1CFD4B8AF7CD66485554F1C45CC733`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_EVIDENCE_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_MISS` | `0.0` | constant |
| 10 | `CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_CHANGED` | `1.0` | constant |
| 11 | `CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_REFINED_STABLE` | `2.0` | constant |
| 12 | `CAMERA_OBSCURA_API_PROVIDER_LIFECYCLE_INVALID` | `3.0` | constant |

### Struct `CAMERA_OBSCURA_API_ProviderLifecycleEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 19 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.valid` | `float` |
| 21 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.expected_backend` | `float` |
| 22 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.ray_valid` | `float` |
| 23 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.provider_attempted` | `float` |
| 24 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.step_budget` | `float` |
| 26 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_valid` | `float` |
| 27 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_hit` | `float` |
| 28 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_reason` | `float` |
| 29 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_backend` | `float` |
| 30 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_step_index` | `float` |
| 31 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_miss_consistent` | `float` |
| 33 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_valid` | `float` |
| 34 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_hit` | `float` |
| 35 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_reason` | `float` |
| 36 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_backend` | `float` |
| 37 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_step_index` | `float` |
| 38 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_confidence` | `float` |
| 39 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_bounded` | `float` |
| 40 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_terminal_consistent` | `float` |
| 41 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_backend_consistent` | `float` |
| 43 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_requested` | `float` |
| 44 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_eligible` | `float` |
| 45 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_applied` | `float` |
| 46 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_gate_consistent` | `float` |
| 47 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_changed_uv` | `float` |
| 48 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_changed_depth` | `float` |
| 49 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_changed_confidence` | `float` |
| 50 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.refinement_changed_any` | `float` |
| 52 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_valid` | `float` |
| 53 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_hit` | `float` |
| 54 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_reason` | `float` |
| 55 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_backend` | `float` |
| 56 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_step_index` | `float` |
| 57 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_confidence` | `float` |
| 58 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_bounded` | `float` |
| 59 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_terminal_consistent` | `float` |
| 60 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_backend_consistent` | `float` |
| 61 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.outcome_preserved` | `float` |
| 62 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.step_index_preserved` | `float` |
| 63 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_consistent` | `float` |
| 65 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.lifecycle_consistent` | `float` |
| 67 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.request_stamp` | `float` |
| 68 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.control_stamp` | `float` |
| 69 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.ray_stamp` | `float` |
| 70 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.initial_stamp` | `float` |
| 71 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.coarse_stamp` | `float` |
| 72 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.final_stamp` | `float` |
| 73 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.generation_stamp` | `float` |
| 74 | `CAMERA_OBSCURA_API_ProviderLifecycleEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 77 | `float CAMERA_OBSCURA_API_ProviderLifecycleValueNear(float leftValue, float rightValue)` | not yet semantically documented |
| 84 | `float CAMERA_OBSCURA_API_ProviderLifecycleVectorNear(float2 leftValue, float2 rightValue)` | not yet semantically documented |
| 92 | `float CAMERA_OBSCURA_API_ProviderLifecycleTerminalConsistent(CAMERA_OBSCURA_Hit hit)` | not yet semantically documented |
| 107 | `float CAMERA_OBSCURA_API_ProviderLifecycleBounded(float stepIndex, float stepBudget)` | not yet semantically documented |
| 342 | `float CAMERA_OBSCURA_API_ProviderLifecycleClass(CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence)` | not yet semantically documented |
| 369 | `float CAMERA_OBSCURA_API_ProviderLifecycleStampMatch(CAMERA_OBSCURA_API_ProviderLifecycleEvidence evidence, float requestStamp, float controlStamp, float rayStamp, float initialStamp, float coarseStamp, float finalStamp, float generationStamp, float sourceStageStamp)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_Providers.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Refined DDA and March traversal-provider wrappers.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Providers.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Providers.fxh)  
SHA-256: `BC8FEAC29E0EF121AFBEF2F1022B269A582AF387F3419129CAE894B340BDF07D`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Services.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Services.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTraversal.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversal.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_PROVIDERS_FXH` | `—` | include guard |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 10 | `CAMERA_OBSCURA_Hit CAMERA_OBSCURA_API_TraceDDA(CAMERA_OBSCURA_Ray ray, CAMERA_OBSCURA_TraceControls controls)` | documented in `CORE_REFERENCE.md` |
| 20 | `CAMERA_OBSCURA_Hit CAMERA_OBSCURA_API_TraceMarch(CAMERA_OBSCURA_Ray ray, CAMERA_OBSCURA_TraceControls controls)` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_SampleAddress.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SampleAddress.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SampleAddress.fxh)  
SHA-256: `4BD34A86CDB39B7CC16A9971A3ED0F39C3E6E5CF727537114D2A7E95081B47BE`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_AtomicCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicCommon.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_SAMPLE_ADDRESS_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_SAMPLE_ADDRESS_VERSION` | `1` | constant |
| 11 | `CAMERA_OBSCURA_API_ADDRESS_POLICY_REJECT` | `0` | constant |
| 12 | `CAMERA_OBSCURA_API_ADDRESS_POLICY_CLAMP` | `1` | constant |
| 13 | `CAMERA_OBSCURA_API_ADDRESS_POLICY_MIRROR` | `2` | constant |
| 14 | `CAMERA_OBSCURA_API_ADDRESS_POLICY_WRAP` | `3` | constant |
| 16 | `CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_NONE` | `0` | constant |
| 17 | `CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_X` | `1` | constant |
| 18 | `CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_Y` | `2` | constant |
| 19 | `CAMERA_OBSCURA_API_ADDRESS_DUPLICATION_CORNER` | `3` | constant |
| 21 | `CAMERA_OBSCURA_API_ADDRESS_REASON_UNINITIALIZED` | `0` | constant |
| 22 | `CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_FULL` | `1` | constant |
| 23 | `CAMERA_OBSCURA_API_ADDRESS_REASON_IN_BOUNDS_BORDER_FOOTPRINT` | `2` | constant |
| 24 | `CAMERA_OBSCURA_API_ADDRESS_REASON_REJECTED_OUTSIDE` | `3` | constant |
| 25 | `CAMERA_OBSCURA_API_ADDRESS_REASON_CLAMPED_OUTSIDE` | `4` | constant |
| 26 | `CAMERA_OBSCURA_API_ADDRESS_REASON_MIRRORED_OUTSIDE` | `5` | constant |
| 27 | `CAMERA_OBSCURA_API_ADDRESS_REASON_WRAPPED_OUTSIDE` | `6` | constant |
| 28 | `CAMERA_OBSCURA_API_ADDRESS_REASON_NUMERIC_INVALID` | `7` | constant |
| 29 | `CAMERA_OBSCURA_API_ADDRESS_REASON_UNKNOWN_POLICY` | `8` | constant |
| 32 | `CAMERA_OBSCURA_API_SAMPLE_ADDRESS_EPSILON` | `0.000001` | constant |

### Struct `CAMERA_OBSCURA_API_SampleAddress`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 37 | `CAMERA_OBSCURA_API_SampleAddress.requested_uv` | `float2` |
| 38 | `CAMERA_OBSCURA_API_SampleAddress.resolved_uv` | `float2` |
| 39 | `CAMERA_OBSCURA_API_SampleAddress.footprint_half_uv` | `float2` |
| 40 | `CAMERA_OBSCURA_API_SampleAddress.requested_in_bounds` | `float` |
| 41 | `CAMERA_OBSCURA_API_SampleAddress.resolved_in_bounds` | `float` |
| 42 | `CAMERA_OBSCURA_API_SampleAddress.address_policy` | `float` |
| 43 | `CAMERA_OBSCURA_API_SampleAddress.address_valid` | `float` |
| 44 | `CAMERA_OBSCURA_API_SampleAddress.independent_evidence` | `float` |
| 45 | `CAMERA_OBSCURA_API_SampleAddress.border_coverage` | `float` |
| 46 | `CAMERA_OBSCURA_API_SampleAddress.outside_distance` | `float` |
| 47 | `CAMERA_OBSCURA_API_SampleAddress.remapped` | `float` |
| 48 | `CAMERA_OBSCURA_API_SampleAddress.duplicate_axis_count` | `float` |
| 49 | `CAMERA_OBSCURA_API_SampleAddress.duplication_state` | `float` |
| 50 | `CAMERA_OBSCURA_API_SampleAddress.confidence` | `float` |
| 51 | `CAMERA_OBSCURA_API_SampleAddress.reason` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 54 | `CAMERA_OBSCURA_API_SampleAddress CAMERA_OBSCURA_API_MakeSampleAddress()` | not yet semantically documented |
| 75 | `float CAMERA_OBSCURA_API_SampleAddressFinite(float value)` | not yet semantically documented |
| 80 | `float CAMERA_OBSCURA_API_SampleAddressFinite2(float2 value)` | not yet semantically documented |
| 87 | `float CAMERA_OBSCURA_API_SampleAddressInBounds(float2 uv)` | not yet semantically documented |
| 94 | `float CAMERA_OBSCURA_API_SampleAddressPolicyKnown(float addressPolicy)` | not yet semantically documented |
| 103 | `float CAMERA_OBSCURA_API_SampleAddressAxisCoverage(float requested, float footprintHalf)` | not yet semantically documented |
| 125 | `float2 CAMERA_OBSCURA_API_SampleAddressMirror01(float2 uv)` | not yet semantically documented |
| 131 | `float2 CAMERA_OBSCURA_API_SampleAddressWrap01(float2 uv)` | not yet semantically documented |
| 136 | `float CAMERA_OBSCURA_API_SampleAddressOutsideDistance(float2 requestedUv)` | not yet semantically documented |
| 143 | `float CAMERA_OBSCURA_API_SampleAddressEvidenceReady(CAMERA_OBSCURA_API_SampleAddress address, float coverageMinimum)` | not yet semantically documented |
| 155 | `CAMERA_OBSCURA_API_SampleAddress CAMERA_OBSCURA_API_BuildSampleAddress(float2 requestedUv, float2 footprintHalfUv, float addressPolicy)` | not yet semantically documented |
| 269 | `float3 CAMERA_OBSCURA_API_SampleAddressReasonColor(float reason)` | not yet semantically documented |
| 290 | `float3 CAMERA_OBSCURA_API_SampleAddressPolicyColor(float policy)` | not yet semantically documented |
| 303 | `float3 CAMERA_OBSCURA_API_SampleAddressDuplicationColor(float state)` | not yet semantically documented |
| 314 | `float3 CAMERA_OBSCURA_API_SampleAddressDebugView(CAMERA_OBSCURA_API_SampleAddress address, float view, float coverageMinimum)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_SampleSchedule.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SampleSchedule.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SampleSchedule.fxh)  
SHA-256: `47DB5D8312FC3B1FE3890F47791327CB33838F53FA992DDC29D2DCCE88DA3129`

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_FXH` | `—` | include guard |
| 7 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_SEQUENTIAL` | `0.0` | constant |
| 8 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_POLICY_DISTRIBUTED` | `1.0` | constant |
| 10 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_NONE` | `0.0` | constant |
| 11 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_COUNT` | `1.0` | constant |
| 12 | `CAMERA_OBSCURA_API_SAMPLE_SCHEDULE_REASON_INVALID_INDEX` | `2.0` | constant |

### Struct `CAMERA_OBSCURA_API_SampleScheduleEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 16 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.requested_logical_index` | `float` |
| 17 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_logical_index` | `float` |
| 18 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.requested_active_count` | `float` |
| 19 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_active_count` | `float` |
| 20 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.requested_canonical_count` | `float` |
| 21 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_canonical_count` | `float` |
| 22 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.requested_policy` | `float` |
| 23 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_policy` | `float` |
| 24 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.reduction_active` | `float` |
| 25 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_stride` | `float` |
| 26 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.resolved_canonical_index` | `float` |
| 27 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.center_identity` | `float` |
| 28 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.count_clamped` | `float` |
| 29 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.index_clamped` | `float` |
| 30 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.mapping_valid` | `float` |
| 31 | `CAMERA_OBSCURA_API_SampleScheduleEvidence.rejection_reason` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 34 | `CAMERA_OBSCURA_API_SampleScheduleEvidence CAMERA_OBSCURA_API_DefaultSampleScheduleEvidence()` | not yet semantically documented |
| 56 | `CAMERA_OBSCURA_API_SampleScheduleEvidence CAMERA_OBSCURA_API_EvaluateSampleSchedule(float requestedLogicalIndex, float requestedActiveCount, float requestedCanonicalCount, float requestedPolicy)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SamplingAggregateEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SamplingAggregateEvidence.fxh)  
SHA-256: `51C42943E939B64617384D2205A9F747491D95E6AF80ED79C3D74162A88D949C`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_SAMPLING_AGGREGATE_EVIDENCE_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_CENTER_FALLBACK` | `0.0` | constant |
| 10 | `CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_FULL_SUPPORT` | `1.0` | constant |
| 11 | `CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_PARTIAL_SUPPORT` | `2.0` | constant |
| 12 | `CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_EMPTY_FALLBACK` | `3.0` | constant |
| 13 | `CAMERA_OBSCURA_API_SAMPLE_AGGREGATE_CLASS_INVALID` | `4.0` | constant |

### Struct `CAMERA_OBSCURA_API_SamplingAggregateEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 21 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.valid` | `float` |
| 23 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.requested_taps` | `float` |
| 24 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.active_taps` | `float` |
| 25 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.attempted_taps` | `float` |
| 26 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.accepted_taps` | `float` |
| 27 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.rejected_taps` | `float` |
| 28 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.counts_nonnegative` | `float` |
| 29 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.counts_integral` | `float` |
| 30 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.active_within_request` | `float` |
| 31 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.attempts_within_active` | `float` |
| 32 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.partition_consistent` | `float` |
| 33 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.count_accounting_consistent` | `float` |
| 35 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.zero_attempt` | `float` |
| 36 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.full_support` | `float` |
| 37 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.partial_support` | `float` |
| 38 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.empty_support` | `float` |
| 39 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.support_ratio` | `float` |
| 40 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.rejection_ratio` | `float` |
| 42 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.weight_sum` | `float` |
| 43 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.gate_sum` | `float` |
| 44 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.weight_available` | `float` |
| 45 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.gate_available` | `float` |
| 46 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.weight_support_consistent` | `float` |
| 47 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.gate_support_consistent` | `float` |
| 49 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.center_luma` | `float` |
| 50 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.weighted_luma_mean` | `float` |
| 51 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.luma_min` | `float` |
| 52 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.luma_max` | `float` |
| 53 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.luma_range` | `float` |
| 54 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.luma_variance` | `float` |
| 55 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.variance_upper_bound` | `float` |
| 56 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.max_center_delta` | `float` |
| 57 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.luma_bounds_consistent` | `float` |
| 58 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.mean_in_range` | `float` |
| 59 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.variance_consistent` | `float` |
| 60 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.delta_consistent` | `float` |
| 61 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.statistics_consistent` | `float` |
| 63 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fallback_expected` | `float` |
| 64 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fallback_used` | `float` |
| 65 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fallback_binary` | `float` |
| 66 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fallback_statistics_consistent` | `float` |
| 67 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.fallback_consistent` | `float` |
| 69 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.aggregate_consistent` | `float` |
| 71 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.request_stamp` | `float` |
| 72 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.neighborhood_stamp` | `float` |
| 73 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.sampling_stamp` | `float` |
| 74 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.statistics_stamp` | `float` |
| 75 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.decision_stamp` | `float` |
| 76 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.generation_stamp` | `float` |
| 77 | `CAMERA_OBSCURA_API_SamplingAggregateEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 80 | `float CAMERA_OBSCURA_API_SamplingAggregateNear(float leftValue, float rightValue)` | not yet semantically documented |
| 87 | `float CAMERA_OBSCURA_API_SamplingAggregateLessEqual(float value, float upperBound)` | not yet semantically documented |
| 94 | `float CAMERA_OBSCURA_API_SamplingAggregateUnitRange(float value)` | not yet semantically documented |
| 101 | `float CAMERA_OBSCURA_API_SamplingAggregateWholeCount(float value)` | not yet semantically documented |
| 358 | `float CAMERA_OBSCURA_API_SamplingAggregateClass(CAMERA_OBSCURA_API_SamplingAggregateEvidence evidence)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_Services.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Capability, surface, direction, request, control, and ray-construction wrappers.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Services.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Services.fxh)  
SHA-256: `119BCDE00A5B674D5E08CE31D29034829F09B206BCFF249968A824A2618E42F4`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryCapability.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryCapability.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_SERVICES_FXH` | `—` | include guard |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 10 | `CAMERA_OBSCURA_Capabilities CAMERA_OBSCURA_API_QueryCapabilities()` | documented in `CORE_REFERENCE.md` |
| 15 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildSurface(CAMERA_OBSCURA_API_Context context)` | documented in `CORE_REFERENCE.md` |
| 21 | `float2 CAMERA_OBSCURA_API_SelectDirection(CAMERA_OBSCURA_API_Context context)` | documented in `CORE_REFERENCE.md` |
| 28 | `CAMERA_OBSCURA_RayRequest CAMERA_OBSCURA_API_DefaultRequest(float2 directionUv)` | documented in `CORE_REFERENCE.md` |
| 33 | `CAMERA_OBSCURA_TraceControls CAMERA_OBSCURA_API_BuildControls(CAMERA_OBSCURA_RayRequest request)` | documented in `CORE_REFERENCE.md` |
| 39 | `CAMERA_OBSCURA_Ray CAMERA_OBSCURA_API_BuildRay(CAMERA_OBSCURA_API_Context context, CAMERA_OBSCURA_SurfaceGuide surface, CAMERA_OBSCURA_RayRequest request, CAMERA_OBSCURA_TraceControls controls)` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_SpatialSupportEvidence.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SpatialSupportEvidence.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_SpatialSupportEvidence.fxh)  
SHA-256: `16AAF7E2A2C7C0BCA56C46D0D1F8CEEE4292BECA2E572F278E65E22F13A97800`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 6 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_SPATIAL_SUPPORT_EVIDENCE_FXH` | `—` | include guard |
| 7 | `CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_EMPTY` | `0.0` | constant |
| 8 | `CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_CENTER` | `1.0` | constant |
| 9 | `CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_SUPPORTED` | `2.0` | constant |
| 10 | `CAMERA_OBSCURA_API_SPATIAL_EVIDENCE_CLASS_INVALID` | `3.0` | constant |

### Struct `CAMERA_OBSCURA_API_SpatialSupportEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 18 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.valid` | `float` |
| 19 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.source_valid` | `float` |
| 20 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.center_valid` | `float` |
| 21 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.center_applied` | `float` |
| 22 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.center_flags_binary` | `float` |
| 23 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.requested_neighbor_count` | `float` |
| 24 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.available_neighbor_count` | `float` |
| 25 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.accepted_neighbor_count` | `float` |
| 26 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.count_values_valid` | `float` |
| 27 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.count_partition_consistent` | `float` |
| 28 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.weight_support_count` | `float` |
| 29 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.support_count_consistent` | `float` |
| 30 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.center_weight` | `float` |
| 31 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.left_weight` | `float` |
| 32 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.right_weight` | `float` |
| 33 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.up_weight` | `float` |
| 34 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.down_weight` | `float` |
| 35 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.weights_valid` | `float` |
| 36 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_neighbor_weight_sum` | `float` |
| 37 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_neighbor_weight_sum` | `float` |
| 38 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.neighbor_sum_consistent` | `float` |
| 39 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_total_weight` | `float` |
| 40 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_total_weight` | `float` |
| 41 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.total_weight_consistent` | `float` |
| 42 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.depth_support` | `float` |
| 43 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.normal_support` | `float` |
| 44 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.edge_support` | `float` |
| 45 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.support_values_valid` | `float` |
| 46 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_resolved_r` | `float` |
| 47 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_resolved_g` | `float` |
| 48 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_resolved_b` | `float` |
| 49 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_resolved_r` | `float` |
| 50 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_resolved_g` | `float` |
| 51 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_resolved_b` | `float` |
| 52 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.resolved_values_valid` | `float` |
| 53 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.resolved_consistent` | `float` |
| 54 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_composite_r` | `float` |
| 55 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_composite_g` | `float` |
| 56 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_composite_b` | `float` |
| 57 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_composite_r` | `float` |
| 58 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_composite_g` | `float` |
| 59 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_composite_b` | `float` |
| 60 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.composite_values_valid` | `float` |
| 61 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.composite_consistent` | `float` |
| 62 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.expected_state` | `float` |
| 63 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.observed_state` | `float` |
| 64 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.state_values_valid` | `float` |
| 65 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.state_consistent` | `float` |
| 66 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.center_stamp` | `float` |
| 67 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.support_stamp` | `float` |
| 68 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.resolve_stamp` | `float` |
| 69 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.output_stamp` | `float` |
| 70 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.generation_stamp` | `float` |
| 71 | `CAMERA_OBSCURA_API_SpatialSupportEvidence.source_stage_stamp` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 74 | `float CAMERA_OBSCURA_API_SpatialEvidence_Near(float leftValue, float rightValue)` | not yet semantically documented |
| 79 | `float CAMERA_OBSCURA_API_SpatialEvidence_LessEqual(float value, float upperBound)` | not yet semantically documented |
| 84 | `float CAMERA_OBSCURA_API_SpatialEvidence_Binary(float value)` | not yet semantically documented |
| 89 | `float CAMERA_OBSCURA_API_SpatialEvidence_Whole(float value)` | not yet semantically documented |
| 94 | `float CAMERA_OBSCURA_API_SpatialEvidence_Range(float value, float minimumValue, float maximumValue)` | not yet semantically documented |
| 100 | `CAMERA_OBSCURA_API_SpatialSupportEvidence CAMERA_OBSCURA_API_DefaultSpatialSupportEvidence()` | not yet semantically documented |
| 158 | `CAMERA_OBSCURA_API_SpatialSupportEvidence CAMERA_OBSCURA_API_BuildSpatialSupportEvidence(float centerValid,float centerApplied,float requestedNeighborCount,float availableNeighborCount,float acceptedNeighborCount, float centerWeight,float leftWeight,float rightWeight,float upWeight,float downWeight, float expectedNeighborWeightSum,float observedNeighborWeightSum,float expectedTotalWeight,float observedTotalWeight, float depthSupport,float normalSupport,float edgeSupport,float3 expectedResolved,float3 observedResolved,float3 expectedComposite,float3 observedComposite, float expectedState,float observedState,float evidenceValid,float centerStamp,float supportStamp,float resolveStamp,float outputStamp,float generationStamp,float sourceStageStamp)` | not yet semantically documented |
| 200 | `float CAMERA_OBSCURA_API_SpatialSupportClass(CAMERA_OBSCURA_API_SpatialSupportEvidence evidence)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_Transmigration.fxh`

Classification: `CORE_UMBRELLA_MEMBER`  
Role: Mined-shape state and admission-gate record.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Transmigration.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Transmigration.fxh)  
SHA-256: `97CF7A37D4CCA18D29522BB1FA7CE38161ABFE3F4526CAE77E2002F11E8E5475`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_Common.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Common.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TRANSMIGRATION_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_MINE_STATE_RAW` | `0` | constant |
| 10 | `CAMERA_OBSCURA_API_MINE_STATE_MAPPED` | `1` | constant |
| 11 | `CAMERA_OBSCURA_API_MINE_STATE_PROVEN` | `2` | constant |
| 12 | `CAMERA_OBSCURA_API_MINE_STATE_ADMITTED` | `3` | constant |

### Struct `CAMERA_OBSCURA_API_MinedShape`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 16 | `CAMERA_OBSCURA_API_MinedShape.state` | `float` |
| 17 | `CAMERA_OBSCURA_API_MinedShape.shape_gate` | `float` |
| 18 | `CAMERA_OBSCURA_API_MinedShape.proof_gate` | `float` |
| 19 | `CAMERA_OBSCURA_API_MinedShape.admission_gate` | `float` |
| 20 | `CAMERA_OBSCURA_API_MinedShape.rollback_gate` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 23 | `CAMERA_OBSCURA_API_MinedShape CAMERA_OBSCURA_API_DefaultMinedShape()` | documented in `CORE_REFERENCE.md` |
| 34 | `float CAMERA_OBSCURA_API_MinedShapeReady(CAMERA_OBSCURA_API_MinedShape shape)` | documented in `CORE_REFERENCE.md` |

## `CAMERA_OBSCURA_API_TwinLanternComposite.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternComposite.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternComposite.fxh)  
SHA-256: `F1B47B8CEBD8A364E752EED51E621A82D97595F082728E5EDAFC7E045FEA89D4`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_COMPOSITE_FXH` | `—` | include guard |

### Struct `CAMERA_OBSCURA_API_TL09CompositeEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 11 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.source_rgb` | `float3` |
| 12 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.indirect_rgb` | `float3` |
| 13 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.weighted_indirect_rgb` | `float3` |
| 14 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.bounded_indirect_rgb` | `float3` |
| 15 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.remaining_room_rgb` | `float3` |
| 16 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.bounded_contribution_rgb` | `float3` |
| 17 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.final_rgb` | `float3` |
| 18 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.evidence` | `float` |
| 19 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.receiver_valid` | `float` |
| 20 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.enabled` | `float` |
| 21 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.strength` | `float` |
| 22 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.maximum_contribution` | `float` |
| 23 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.admission` | `float` |
| 24 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.application` | `float` |
| 25 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.rejection` | `float` |
| 26 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.rejection_code` | `float` |
| 27 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.containment_activity` | `float` |
| 28 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.source_preserve_delta` | `float` |
| 29 | `CAMERA_OBSCURA_API_TL09CompositeEvidence.bounds_valid` | `float` |

## `CAMERA_OBSCURA_API_TwinLanternDDAProof.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternDDAProof.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternDDAProof.fxh)  
SHA-256: `FF8E1D9EC0C144A7D4FE110D3D5C5A3D425B95B187FB86F2B61EE702479389BD`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTraversalDDA.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversalDDA.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_DDA_PROOF_FXH` | `—` | include guard |

## `CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh)  
SHA-256: `6C01D28214518098FB2F782F609009772C09111EC2DABF62A790A73CC8980DCB`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_DETAIL_TARGET_FXH` | `—` | include guard |

### Struct `CAMERA_OBSCURA_API_TL08DetailTargetEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 11 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.detail_energy` | `float` |
| 12 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.detail_gate` | `float` |
| 13 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.surface_support` | `float` |
| 14 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.weakest_surface_support` | `float` |
| 15 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.boundary_safety` | `float` |
| 16 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.transport_change` | `float` |
| 17 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.transport_gate` | `float` |
| 18 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.target_score` | `float` |
| 19 | `CAMERA_OBSCURA_API_TL08DetailTargetEvidence.rejected_score` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 38 | `float CAMERA_OBSCURA_API_TL08SmoothGate(float value, float startValue, float fullValue)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_TwinLanternMarchProof.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternMarchProof.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternMarchProof.fxh)  
SHA-256: `4778DCF401CA476C32FABF845D5314E0756F588B5265286C45B42DD1F4461AC1`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTraversalMarch.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversalMarch.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_MARCH_PROOF_FXH` | `—` | include guard |

## `CAMERA_OBSCURA_API_TwinLanternParity.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternParity.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternParity.fxh)  
SHA-256: `7D7F702430FC885A9647F9A94D2D6F4DDCBA29219F4EB598587F2D61CCCD7C0B`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTraversal.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversal.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_PARITY_FXH` | `—` | include guard |

### Struct `CAMERA_OBSCURA_API_TwinLanternParityEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 12 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.direction_index` | `float` |
| 13 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.ray_valid` | `float` |
| 14 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.direction_uv` | `float2` |
| 15 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.endpoint_uv_requested` | `float2` |
| 16 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.endpoint_uv_resolved` | `float2` |
| 17 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.endpoint_depth` | `float` |
| 18 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_hit` | `float` |
| 19 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_reason` | `float` |
| 20 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_confidence` | `float` |
| 21 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_uv` | `float2` |
| 22 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_depth` | `float` |
| 23 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_distance_pixels` | `float` |
| 24 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_step_index` | `float` |
| 25 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_hit` | `float` |
| 26 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_reason` | `float` |
| 27 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_confidence` | `float` |
| 28 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_uv` | `float2` |
| 29 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_depth` | `float` |
| 30 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_distance_pixels` | `float` |
| 31 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_step_index` | `float` |
| 32 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.both_hit` | `float` |
| 33 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.dda_only` | `float` |
| 34 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.march_only` | `float` |
| 35 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.neither_hit` | `float` |
| 36 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.uv_delta_pixels` | `float` |
| 37 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.depth_delta` | `float` |
| 38 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.distance_delta_pixels` | `float` |
| 39 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.uv_agreement` | `float` |
| 40 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.depth_agreement` | `float` |
| 41 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.distance_agreement` | `float` |
| 42 | `CAMERA_OBSCURA_API_TwinLanternParityEvidence.conflict` | `float` |

## `CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh)  
SHA-256: `54BECD0A73D7E763FE3C8B5A1BD92EDE59827566595A82D0A72BA0D03F29BDC6`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_EntryCapability.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryCapability.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_AtomicDebug.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicDebug.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_PROVIDER_PROOF_COMMON_FXH` | `—` | include guard |
| 10 | `CAMERA_OBSCURA_API_TL45_INPUT_LIVE` | `0.0` | constant |
| 11 | `CAMERA_OBSCURA_API_TL45_INPUT_INVALID_RECEIVER` | `1.0` | constant |
| 12 | `CAMERA_OBSCURA_API_TL45_INPUT_ZERO_DIRECTION` | `2.0` | constant |

### Struct `CAMERA_OBSCURA_API_TwinLanternProviderEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 16 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.provider_backend` | `float` |
| 17 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.requested_steps` | `float` |
| 18 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.receiver_valid` | `float` |
| 19 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.receiver_edge_risk` | `float` |
| 20 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.ray_valid` | `float` |
| 21 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.direction_uv` | `float2` |
| 22 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.hit` | `float` |
| 23 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.reason` | `float` |
| 24 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.hit_uv` | `float2` |
| 25 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.step_index` | `float` |
| 26 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.terminal_depth` | `float` |
| 27 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.interval_min` | `float` |
| 28 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.interval_max` | `float` |
| 29 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.interval_support` | `float` |
| 30 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.thickness_used` | `float` |
| 31 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.coarse_residual` | `float` |
| 32 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.refined_residual` | `float` |
| 33 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.refinement_not_worse` | `float` |
| 34 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.refinement_steps` | `float` |
| 35 | `CAMERA_OBSCURA_API_TwinLanternProviderEvidence.confidence` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 65 | `float2 CAMERA_OBSCURA_API_TL45Direction(float requestedIndex)` | not yet semantically documented |
| 78 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildTL45Receiver(float2 uv, float inputMode)` | not yet semantically documented |
| 125 | `CAMERA_OBSCURA_Ray CAMERA_OBSCURA_API_BuildTL45Ray(float2 uv, float directionIndex, float inputMode, float requestedSteps, float rayLengthPixels, float depthSlope, float frontBias, float backThickness, out CAMERA_OBSCURA_TraceControls controls, out CAMERA_OBSCURA_SurfaceGuide receiver)` | not yet semantically documented |
| 208 | `float3 CAMERA_OBSCURA_API_TL45Status(float value)` | not yet semantically documented |
| 216 | `float3 CAMERA_OBSCURA_API_TL45Signal(CAMERA_OBSCURA_API_TwinLanternProviderEvidence evidence, float view)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_TwinLanternRay.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternRay.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternRay.fxh)  
SHA-256: `1690DBFE836BC0DA1D6DD5286C101BA83FC4BBC8A5E2B66423331A9F876CBF67`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_EntryTraversal.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversal.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_RAY_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_TWIN_LANTERN_DIRECTION_COUNT` | `8.0` | constant |
| 11 | `CAMERA_OBSCURA_API_TL03_INPUT_LIVE` | `0.0` | constant |
| 12 | `CAMERA_OBSCURA_API_TL03_INPUT_INVALID_RECEIVER` | `1.0` | constant |
| 13 | `CAMERA_OBSCURA_API_TL03_INPUT_ZERO_DIRECTION` | `2.0` | constant |

### Struct `CAMERA_OBSCURA_API_TwinLanternRayEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 17 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.requested_direction_index` | `float` |
| 18 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.resolved_direction_index` | `float` |
| 19 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.direction_index_valid` | `float` |
| 20 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.direction_uv` | `float2` |
| 21 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.receiver_valid` | `float` |
| 22 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.ray_valid` | `float` |
| 23 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.origin_uv` | `float2` |
| 24 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.origin_depth` | `float` |
| 25 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.endpoint_uv_requested` | `float2` |
| 26 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.endpoint_uv_resolved` | `float2` |
| 27 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.endpoint_screen_exit` | `float` |
| 28 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.endpoint_depth` | `float` |
| 29 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.depth_travel` | `float` |
| 30 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.dda_hit` | `float` |
| 31 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.dda_reason` | `float` |
| 32 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.dda_step_index` | `float` |
| 33 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.dda_terminal_depth` | `float` |
| 34 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.march_hit` | `float` |
| 35 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.march_reason` | `float` |
| 36 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.march_step_index` | `float` |
| 37 | `CAMERA_OBSCURA_API_TwinLanternRayEvidence.march_terminal_depth` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 68 | `float CAMERA_OBSCURA_API_TwinLanternDirectionIndexValid(float index)` | not yet semantically documented |
| 77 | `float CAMERA_OBSCURA_API_TwinLanternResolveDirectionIndex(float index)` | not yet semantically documented |
| 84 | `float2 CAMERA_OBSCURA_API_TwinLanternDirection(float resolvedIndex)` | not yet semantically documented |
| 99 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildTL03Receiver(float2 uv, float inputMode)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternReconstruction.fxh)  
SHA-256: `46B2DCF14B433B2C798DFA36047D85A41BC70D734B7B2653C87543BB1CC6B998`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternTransport.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternTransport.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_RECONSTRUCTION_FXH` | `—` | include guard |

### Struct `CAMERA_OBSCURA_API_TL08ResolveEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 11 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.resolved_rgb` | `float3` |
| 12 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.trusted_weight` | `float` |
| 13 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.weight_sum` | `float` |
| 14 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.kernel_capacity` | `float` |
| 15 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.center_valid` | `float` |
| 16 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.center_evidence` | `float` |
| 17 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.negative_available` | `float` |
| 18 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.positive_available` | `float` |
| 19 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.negative_depth_support` | `float` |
| 20 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.positive_depth_support` | `float` |
| 21 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.negative_normal_support` | `float` |
| 22 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.positive_normal_support` | `float` |
| 23 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.negative_edge_support` | `float` |
| 24 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.positive_edge_support` | `float` |
| 25 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.negative_admitted_weight` | `float` |
| 26 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.center_admitted_weight` | `float` |
| 27 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.positive_admitted_weight` | `float` |
| 28 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.minimum_depth_support` | `float` |
| 29 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.minimum_normal_support` | `float` |
| 30 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.minimum_edge_support` | `float` |
| 31 | `CAMERA_OBSCURA_API_TL08ResolveEvidence.zero_weight` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 62 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_DefaultTL08Guide()` | not yet semantically documented |
| 74 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildTL08Guide(float2 uv)` | not yet semantically documented |
| 100 | `float CAMERA_OBSCURA_API_TL08DepthSupport(CAMERA_OBSCURA_SurfaceGuide center, CAMERA_OBSCURA_SurfaceGuide tapGuide, float depthTolerance)` | not yet semantically documented |
| 110 | `float CAMERA_OBSCURA_API_TL08NormalSupport(CAMERA_OBSCURA_SurfaceGuide center, CAMERA_OBSCURA_SurfaceGuide tapGuide, float normalMinimum)` | not yet semantically documented |
| 121 | `float CAMERA_OBSCURA_API_TL08EdgeSupport(CAMERA_OBSCURA_SurfaceGuide center, CAMERA_OBSCURA_SurfaceGuide tapGuide, float edgeProtection)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_TwinLanternTemporalMotion.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternTemporalMotion.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternTemporalMotion.fxh)  
SHA-256: `0E688D122E977046A4E43B2DABF7841077ED5657C4A3FC337B0AADBB61048D1E`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternDetailTarget.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_TEMPORAL_MOTION_FXH` | `—` | include guard |

### Struct `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 11 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.history_valid` | `float` |
| 12 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.same_uv_valid` | `float` |
| 13 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.inferred_vector_valid` | `float` |
| 14 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.inferred_vector_uv` | `float2` |
| 15 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.inferred_vector_pixels` | `float` |
| 16 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.vector_match_error` | `float` |
| 17 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.vector_confidence` | `float` |
| 18 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.nonvector_source_change` | `float` |
| 19 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.nonvector_transport_change` | `float` |
| 20 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.vector_transport_change` | `float` |
| 21 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.explained_motion` | `float` |
| 22 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.residual_noise` | `float` |
| 23 | `CAMERA_OBSCURA_API_TL08TemporalMotionEvidence.target_score` | `float` |

## `CAMERA_OBSCURA_API_TwinLanternTransport.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternTransport.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternTransport.fxh)  
SHA-256: `D5F3D7E80A9E15777754403EB820B0CD28FD8B6E2BC92D3663D4450174DF25B5`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_TwinLanternProviderProofCommon.fxh` | yes |
| 8 | `../header/CAMERA_OBSCURA_EntryTraversal.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_EntryTraversal.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_TWIN_LANTERN_TRANSPORT_FXH` | `—` | include guard |
| 10 | `CAMERA_OBSCURA_API_TL07_MODE_PARITY` | `0.0` | constant |
| 11 | `CAMERA_OBSCURA_API_TL07_MODE_COMPLEMENTARY` | `1.0` | constant |

### Struct `CAMERA_OBSCURA_API_TwinLanternTransportEvidence`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 15 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.transport_mode` | `float` |
| 16 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.transport_enabled` | `float` |
| 17 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.ray_valid` | `float` |
| 18 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.receiver_valid` | `float` |
| 19 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_hit` | `float` |
| 20 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_reason` | `float` |
| 21 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_donor_valid` | `float` |
| 22 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_donor_rgb` | `float3` |
| 23 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_distance_pixels` | `float` |
| 24 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_distance_weight` | `float` |
| 25 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_receiver_facing` | `float` |
| 26 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_donor_facing` | `float` |
| 27 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_normal_compatibility` | `float` |
| 28 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_hit_confidence` | `float` |
| 29 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_raw_weight` | `float` |
| 30 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_normalized_weight` | `float` |
| 31 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_hit` | `float` |
| 32 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_reason` | `float` |
| 33 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_donor_valid` | `float` |
| 34 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_donor_rgb` | `float3` |
| 35 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_distance_pixels` | `float` |
| 36 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_distance_weight` | `float` |
| 37 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_receiver_facing` | `float` |
| 38 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_donor_facing` | `float` |
| 39 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_normal_compatibility` | `float` |
| 40 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_hit_confidence` | `float` |
| 41 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_raw_weight` | `float` |
| 42 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_normalized_weight` | `float` |
| 43 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_weight_active` | `float` |
| 44 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_weight_active` | `float` |
| 45 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.both_weight_active` | `float` |
| 46 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.dda_only_weight_active` | `float` |
| 47 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.march_only_weight_active` | `float` |
| 48 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.neither_weight_active` | `float` |
| 49 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.one_provider_bound_ok` | `float` |
| 50 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.provider_count` | `float` |
| 51 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.total_raw_weight` | `float` |
| 52 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.normalized_weight_sum` | `float` |
| 53 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.evidence_strength` | `float` |
| 54 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.combined_donor_rgb` | `float3` |
| 55 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.raw_radiance_rgb` | `float3` |
| 56 | `CAMERA_OBSCURA_API_TwinLanternTransportEvidence.zero_contribution` | `float` |

### Struct `CAMERA_OBSCURA_API_TL07ProviderSample`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 61 | `CAMERA_OBSCURA_API_TL07ProviderSample.valid` | `float` |
| 62 | `CAMERA_OBSCURA_API_TL07ProviderSample.donor_rgb` | `float3` |
| 63 | `CAMERA_OBSCURA_API_TL07ProviderSample.distance_pixels` | `float` |
| 64 | `CAMERA_OBSCURA_API_TL07ProviderSample.distance_weight` | `float` |
| 65 | `CAMERA_OBSCURA_API_TL07ProviderSample.receiver_facing` | `float` |
| 66 | `CAMERA_OBSCURA_API_TL07ProviderSample.donor_facing` | `float` |
| 67 | `CAMERA_OBSCURA_API_TL07ProviderSample.normal_compatibility` | `float` |
| 68 | `CAMERA_OBSCURA_API_TL07ProviderSample.hit_confidence` | `float` |
| 69 | `CAMERA_OBSCURA_API_TL07ProviderSample.raw_weight` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 137 | `CAMERA_OBSCURA_SurfaceGuide CAMERA_OBSCURA_API_BuildTL07DonorGuide(float2 uv)` | not yet semantically documented |

## `CAMERA_OBSCURA_API_Workload.fxh`

Classification: `SOURCE_PRESENT_NOT_IN_CORE_UMBRELLA`  
Role: Additional API/evidence/proof source; lifecycle must be resolved from system records.  
Source: [`reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Workload.fxh`](../reshade-shaders/Shaders/camera_obscura/api/CAMERA_OBSCURA_API_Workload.fxh)  
SHA-256: `8447205419D526351947C981B63D0D127FEB8A94A63CD19ACE63BB9650CD7028`

### Includes

| Line | Target | Resolved | Exists |
|---:|---|---|---:|
| 7 | `../header/CAMERA_OBSCURA_AtomicCommon.fxh` | `reshade-shaders/Shaders/camera_obscura/header/CAMERA_OBSCURA_AtomicCommon.fxh` | yes |

### Macros

| Line | Name | Value | Kind |
|---:|---|---|---|
| 5 | `CAMERA_OBSCURA_API_WORKLOAD_FXH` | `—` | include guard |
| 9 | `CAMERA_OBSCURA_API_WORKLOAD_VERSION` | `1` | constant |
| 11 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_UNINITIALIZED` | `0` | constant |
| 12 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_ACTIVE` | `1` | constant |
| 13 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_OUTPUT_ONLY_BYPASS` | `2` | constant |
| 14 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_WORKLOAD_BYPASS` | `3` | constant |
| 15 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_CAPABILITY_UNAVAILABLE` | `4` | constant |
| 16 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_AUTHORITY` | `5` | constant |
| 17 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_REQUEST` | `6` | constant |
| 18 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_ZERO_ACTIVE` | `7` | constant |
| 19 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_COUNTER_INVALID` | `8` | constant |
| 20 | `CAMERA_OBSCURA_API_WORKLOAD_REASON_NUMERIC_INVALID` | `9` | constant |
| 23 | `CAMERA_OBSCURA_API_WORKLOAD_EPSILON` | `0.000001` | constant |

### Struct `CAMERA_OBSCURA_API_Workload`

Field meanings are not yet asserted here unless covered by the hand-written core reference.

| Line | Scoped field | Type |
|---:|---|---|
| 28 | `CAMERA_OBSCURA_API_Workload.requested_units` | `float` |
| 29 | `CAMERA_OBSCURA_API_Workload.policy_capped_units` | `float` |
| 30 | `CAMERA_OBSCURA_API_Workload.hard_capped_units` | `float` |
| 31 | `CAMERA_OBSCURA_API_Workload.capped_units` | `float` |
| 32 | `CAMERA_OBSCURA_API_Workload.active_units` | `float` |
| 33 | `CAMERA_OBSCURA_API_Workload.unique_units` | `float` |
| 34 | `CAMERA_OBSCURA_API_Workload.executed_units` | `float` |
| 35 | `CAMERA_OBSCURA_API_Workload.rejected_units` | `float` |
| 36 | `CAMERA_OBSCURA_API_Workload.refined_units` | `float` |
| 37 | `CAMERA_OBSCURA_API_Workload.reused_units` | `float` |
| 38 | `CAMERA_OBSCURA_API_Workload.duplicate_units` | `float` |
| 39 | `CAMERA_OBSCURA_API_Workload.physical_units` | `float` |
| 40 | `CAMERA_OBSCURA_API_Workload.capability_available` | `float` |
| 41 | `CAMERA_OBSCURA_API_Workload.authority` | `float` |
| 42 | `CAMERA_OBSCURA_API_Workload.output_bypass` | `float` |
| 43 | `CAMERA_OBSCURA_API_Workload.workload_bypass_requested` | `float` |
| 44 | `CAMERA_OBSCURA_API_Workload.workload_bypass_effective` | `float` |
| 45 | `CAMERA_OBSCURA_API_Workload.work_allowed` | `float` |
| 46 | `CAMERA_OBSCURA_API_Workload.counters_valid` | `float` |
| 47 | `CAMERA_OBSCURA_API_Workload.reason` | `float` |

### Functions

| Line | Exact signature | Semantic status |
|---:|---|---|
| 50 | `CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_MakeWorkload()` | not yet semantically documented |
| 76 | `float CAMERA_OBSCURA_API_WorkloadFinite(float value)` | not yet semantically documented |
| 81 | `float CAMERA_OBSCURA_API_WorkloadCount(float value)` | not yet semantically documented |
| 86 | `float CAMERA_OBSCURA_API_WorkloadApprox(float value, float expected, float epsilon)` | not yet semantically documented |
| 91 | `CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_BuildWorkload(float requestedUnits, float policyCapUnits, float hardCapUnits, float activeUnits, float uniqueUnits, float executedUnits, float rejectedUnits, float refinedUnits, float reusedUnits, float capabilityAvailable, float authority, float outputBypass, float workloadBypassRequested)` | not yet semantically documented |
| 253 | `CAMERA_OBSCURA_API_Workload CAMERA_OBSCURA_API_BuildWorkloadSynthetic(float syntheticMode)` | not yet semantically documented |
| 333 | `float3 CAMERA_OBSCURA_API_WorkloadReasonColor(float reason)` | not yet semantically documented |
