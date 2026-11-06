# Camera Obscura Core API Reference

Status: **first semantic pass over the core umbrella**.

This reference covers the seven files reachable from
`CAMERA_OBSCURA_API_All.fxh`. Claims below are limited to behavior visible in
the current source. The API calls itself a scaffold; this document does not
upgrade that scaffold to a stable public contract.

## Global conventions

- `uv` values are normalized screen coordinates.
- Boolean-like shader values are carried as floats in several records.
- Camera Obscura atomic records and operations come from the adjacent `header`
  support surface.
- The core umbrella does not include the additional evidence or Twin Lantern
  headers present in the API directory.

## `CAMERA_OBSCURA_API_All.fxh`

The umbrella contains no functions or records of its own. It includes, in
order, Common, Services, Providers, Cohesion, Debug, and Transmigration.

Including this file therefore exposes the core API scaffold and its atomic
header dependencies. It does not expose every `.fxh` file in the API directory.

## `CAMERA_OBSCURA_API_Common.fxh`

### Version and stage constants

| Symbol | Current value | Source-supported meaning |
|---|---:|---|
| `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MAJOR` | `1` | scaffold major version |
| `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_MINOR` | `0` | scaffold minor version |
| `CAMERA_OBSCURA_API_SCAFFOLD_VERSION_PATCH` | `0` | scaffold patch version |
| `CAMERA_OBSCURA_API_STAGE_TRUTH` | `1` | truth-stage identifier |
| `CAMERA_OBSCURA_API_STAGE_PROVIDERS` | `2` | provider-stage identifier |
| `CAMERA_OBSCURA_API_STAGE_COHESION` | `3` | cohesion-stage identifier |

These are compile-time constants. The source does not define a compatibility
policy for future version changes.

### `CAMERA_OBSCURA_API_Context`

| Field | Type | Construction behavior |
|---|---|---|
| `uv` | `float2` | clamped through `CAMERA_OBSCURA_SaturateUV` |
| `pixel` | `float2` | copied from the caller |
| `spatial_phase` | `float` | copied from the caller |
| `stage` | `float` | copied from the caller |

### Functions

`CAMERA_OBSCURA_API_MakeContext(float2 uv, float2 pixel, float spatialPhase, float stage)`

: Returns a context with saturated UV coordinates. It does not validate or
  clamp `pixel`, `spatialPhase`, or `stage`.

`CAMERA_OBSCURA_API_VersionCode()`

: Returns `major * 10000 + minor * 100 + patch`. With the current constants,
  the result is `10000.0`.

## `CAMERA_OBSCURA_API_Services.fxh`

This file is a thin facade over atomic capability services.

| Function | Source-visible behavior |
|---|---|
| `CAMERA_OBSCURA_API_QueryCapabilities()` | returns `CAMERA_OBSCURA_QueryCapabilities()` unchanged |
| `CAMERA_OBSCURA_API_BuildSurface(context)` | builds a surface guide at `context.uv` |
| `CAMERA_OBSCURA_API_SelectDirection(context)` | floors `context.pixel`, then selects a C0 direction using `context.spatial_phase` |
| `CAMERA_OBSCURA_API_DefaultRequest(directionUv)` | returns the atomic default ray request for the supplied direction |
| `CAMERA_OBSCURA_API_BuildControls(request)` | converts the request through the atomic trace-control builder |
| `CAMERA_OBSCURA_API_BuildRay(context, surface, request, controls)` | builds a C0 ray at `context.uv` from the supplied records |

Input validation and failure-state semantics belong to the called atomic
functions and records; they are not redefined by these wrappers.

## `CAMERA_OBSCURA_API_Providers.fxh`

### `CAMERA_OBSCURA_API_TraceDDA(ray, controls)`

Runs the atomic DDA traversal and immediately passes its result, the original
ray, and the same controls to `CAMERA_OBSCURA_RefineHit`. The returned value is
the refinement result, not the unrefined DDA result.

### `CAMERA_OBSCURA_API_TraceMarch(ray, controls)`

Runs the atomic March traversal and immediately passes its result, the original
ray, and the same controls to `CAMERA_OBSCURA_RefineHit`. The returned value is
the refinement result, not the unrefined March result.

The facade does not merge provider results or choose between them.

## `CAMERA_OBSCURA_API_Cohesion.fxh`

| Function | Source-visible behavior |
|---|---|
| `CAMERA_OBSCURA_API_EvaluateDualHit(dda, march)` | delegates to atomic dual-hit evaluation |
| `CAMERA_OBSCURA_API_BuildContribution(context, surface, hit)` | builds one contribution using `context.uv`, the supplied surface, and one hit |
| `CAMERA_OBSCURA_API_DefaultFallback(context, surface)` | constructs fallback data using `context.uv` and the supplied surface |
| `CAMERA_OBSCURA_API_Resolve(dual, ddaContribution, marchContribution, fallback)` | delegates to the three-input atomic resolver and returns its `float4` result |
| `CAMERA_OBSCURA_API_Composite(fallback, resolved, strength)` | composites `fallback.rgb`, `resolved.rgb`, `resolved.a`, and the supplied strength |

The facade keeps dual-hit evaluation, per-provider contribution construction,
resolution, and final composite as separate calls.

## `CAMERA_OBSCURA_API_Debug.fxh`

`CAMERA_OBSCURA_API_DebugView` forwards its view selector, source, composite,
both hits, dual-hit record, and both contribution records to the atomic debug
dispatcher. It adds no extra view selection or fallback behavior.

## `CAMERA_OBSCURA_API_Transmigration.fxh`

### Mine-state constants

| Symbol | Value |
|---|---:|
| `CAMERA_OBSCURA_API_MINE_STATE_RAW` | `0` |
| `CAMERA_OBSCURA_API_MINE_STATE_MAPPED` | `1` |
| `CAMERA_OBSCURA_API_MINE_STATE_PROVEN` | `2` |
| `CAMERA_OBSCURA_API_MINE_STATE_ADMITTED` | `3` |

### `CAMERA_OBSCURA_API_MinedShape`

The record stores `state`, `shape_gate`, `proof_gate`, `admission_gate`, and
`rollback_gate` as floats.

`CAMERA_OBSCURA_API_DefaultMinedShape()` initializes the state to `RAW` and all
four gates to `0.0`.

`CAMERA_OBSCURA_API_MinedShapeReady(shape)` returns the `step(0.5, ...)` result
of the minimum of the four gates. Consequently, the current implementation
reports ready only when every gate is at least `0.5`.

Important boundary: `MinedShapeReady` does not inspect `shape.state`. The state
field and the four-gate readiness calculation are independent in this source.

## Dependencies deferred from this pass

The core facade relies on atomic types and behavior declared under
`../reshade-shaders/Shaders/camera_obscura/header`. Those macros, records, fields, and
functions are dependencies of this API, but their own exhaustive semantic
reference is not part of this first pass.

Likewise, the evidence, workload, sample, provider-identity, and Twin Lantern
headers are declaration-indexed in `DECLARATIONS.md` but await separate
semantic passes and lifecycle reconciliation.
