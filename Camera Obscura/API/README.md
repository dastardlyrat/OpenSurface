<div align="center">

# Camera Obscura API

### An inspectable ReShade FX scaffold for evidence, providers, cohesion, and bounded output

**Make the decision path visible—from surface evidence to the final composite.**

![Status](https://img.shields.io/badge/status-documentation%20in%20progress-f0ad4e?style=for-the-badge)
![Headers](https://img.shields.io/badge/headers-29-4b6b88?style=for-the-badge)
![Core](https://img.shields.io/badge/core%20umbrella-7%20files-6f42c1?style=for-the-badge)
![Functions](https://img.shields.io/badge/functions-120-2da44e?style=for-the-badge)

[Core reference](docs/CORE_REFERENCE.md) · [All declarations](docs/DECLARATIONS.md) · [Symbol index](docs/SYMBOLS.json) · [Validation](docs/VALIDATION.md)

</div>

---

The Camera Obscura API is the current OpenSurface development scaffold for
building image operations from explicit surface evidence, separate traversal
providers, inspectable cohesion, bounded composite behavior, and visible debug
state.

It is designed to keep the important boundaries legible:

- evidence is not authority;
- a provider result is not automatically an accepted contribution;
- resolution is not the same operation as application;
- a diagnostic signal is not the production image;
- source presence is not proof of umbrella wiring or stable public status.

> **Status boundary:** this package hosts a reviewed snapshot of the current
> development API. The accepted frozen runtime rail remains a separate source
> authority and is not replaced by this publication. Hosting does not promote
> the scaffold into stable runtime canon.

## Start Here

| If you want to… | Read… |
|---|---|
| Understand the seven-file core and its source-visible behavior | **[Core API reference](docs/CORE_REFERENCE.md)** |
| Find every macro, struct, scoped field, function, include, and source line | **[Declaration reference](docs/DECLARATIONS.md)** |
| Consume the declaration set programmatically | **[Machine-readable symbol index](docs/SYMBOLS.json)** |
| Verify source authority, hashes, and umbrella classification | **[Source inventory](docs/SOURCE_INVENTORY.csv)** |
| Audit the source-to-publication transformation | **[Publication transform](docs/PUBLICATION_TRANSFORM.md)** |
| See exactly what was tested—and what was not | **[Validation record](docs/VALIDATION.md)** |

## Install The Include Library

This project ships an install-ready `reshade-shaders` tree but no standalone
effect or ReShade technique.

1. Merge this project's `reshade-shaders` directory into the game's existing
   `reshade-shaders` directory.
2. Keep the installation's known-good `ReShade.fxh`; it remains an external
   host dependency and is not bundled here.
3. Include the core front door from a consuming effect:

   ```hlsl
   #include "camera_obscura/api/CAMERA_OBSCURA_API_All.fxh"
   ```

4. Include additional evidence or Twin Lantern headers directly only when the
   consuming project has explicitly adopted their lifecycle and contracts.

The package contains 29 API headers and nine adjacent support headers. Their
relative layout must be preserved.

## Core Architecture

`CAMERA_OBSCURA_API_All.fxh` is the core front door. Its include graph resolves
to seven API files:

```text
CAMERA_OBSCURA_API_All.fxh
│
├── Common ─────── version · stages · context
├── Services ───── capabilities · surface · direction · ray construction
├── Providers ──── refined DDA · refined March
├── Cohesion ───── dual-hit · contribution · fallback · resolve · composite
├── Debug ──────── centralized diagnostic dispatch
└── Transmigration
       └────────── mined-shape state · proof/admission/rollback gates
```

The conceptual image path is deliberately more specific than a single opaque
“run effect” call:

```text
Context
   │
   ▼
Surface evidence ──► request ──► bounded controls ──► ray
                                                    │
                              ┌─────────────────────┴─────────────────────┐
                              ▼                                           ▼
                         refined DDA                                refined March
                              │                                           │
                              └─────────────────────┬─────────────────────┘
                                                    ▼
                                     agreement + contributions
                                                    │
                                                    ▼
                                       resolve ──► bounded composite
                                                    │
                                                    └──► debug evidence
```

This is a documentation model of the current wrapper flow, not a claim that
every source-present header is part of the core umbrella.

## Core Surface At A Glance

### Context and version

`CAMERA_OBSCURA_API_Common.fxh` declares scaffold version `1.0.0`, three stage
identifiers, and `CAMERA_OBSCURA_API_Context`. Context construction saturates
the supplied UV while carrying pixel position, spatial phase, and stage.

### Services

`CAMERA_OBSCURA_API_Services.fxh` exposes thin wrappers for capability query,
surface-guide construction, direction selection, default request construction,
trace-control construction, and ray construction.

### Providers

`CAMERA_OBSCURA_API_Providers.fxh` keeps DDA and March separate. Each wrapper
runs its atomic traversal and returns the result of explicit hit refinement. It
does not silently merge or select providers.

### Cohesion

`CAMERA_OBSCURA_API_Cohesion.fxh` exposes dual-hit evaluation, one-provider
contribution construction, fallback construction, three-input resolution, and
final composite as distinct operations.

### Debug

`CAMERA_OBSCURA_API_Debug.fxh` is the centralized diagnostic front door. It
forwards source, composite, provider hits, agreement, and contributions to the
atomic debug dispatcher without inventing a second debug language.

### Transmigration

`CAMERA_OBSCURA_API_Transmigration.fxh` models mined material as an explicit
state plus shape, proof, admission, and rollback gates. Its current readiness
function requires all four gates to reach at least `0.5`; it does not inspect
the separate state field.

## Development And Runtime Boundaries

| Surface | Evidence state | Treatment here |
|---|---|---|
| accepted frozen runtime rail | separate source authority | protected reference; not modified or superseded |
| Seven files reachable from `CAMERA_OBSCURA_API_All.fxh` | derived core umbrella | first semantic documentation pass complete at wrapper level |
| 22 additional current API headers | source-present, outside the core umbrella | declaration-indexed; lifecycle resolved separately |
| CO-MIG receptors named in the authoritative-state registry | `PROVEN_COLD / NOT_WIRED` | not silently promoted |
| Historical, mill, inbox, and outbox copies | evidence or work products | not treated as current source |

Later source-present material is not assigned a lifecycle merely from its
filename, directory, or apparent completeness.

## Documentation Coverage

The generated documentation currently covers:

| Item | Count |
|---|---:|
| Source headers | 29 |
| Core umbrella files | 7 |
| Headers outside the core umbrella | 22 |
| Local include declarations | 41 |
| Macros | 170 |
| Structs | 24 |
| Scoped struct fields | 611 |
| Function definitions | 120 |
| Shader resources declared in the scoped API directory | 0 |

Every indexed macro, struct, scoped field, and function signature appears in
`docs/DECLARATIONS.md`. Full field-by-field and function-by-function semantics are
not yet complete for the 22 headers outside the core umbrella.

## Documentation Method

The documentation pipeline follows an evidence-first order:

1. Inventory and hash the current source files.
2. Resolve every quoted include locally.
3. Derive core membership from reachability through
   `CAMERA_OBSCURA_API_All.fxh`.
4. Extract exact declarations without filling semantic gaps by guesswork.
5. Add hand-written semantics only where the implementation supports the whole
   claim.
6. Regenerate and compare the machine index, inventory, and declaration
   reference byte for byte.
7. Keep compiler, runtime, performance, and visual claims outside static
   documentation checks.

Truth states are explicit:

- exact declarations are **SOURCE**;
- hashes, counts, and include reachability are **DERIVED**;
- file-role summaries are bounded **GENERATED SYNTHESIS**;
- missing lifecycle or behavior evidence remains **UNKNOWN**, not completed by
  prose.

## Regenerate And Check

From the OpenSurface repository root:

```powershell
python -B "Camera Obscura/API/tools/build_docs.py"
python -B "Camera Obscura/API/tools/build_docs.py" --check
python -B "Camera Obscura/API/tools/validate_package.py"
```

The generator writes:

- `SOURCE_INVENTORY.csv`
- `SYMBOLS.json`
- `DECLARATIONS.md`

The hand-written landing page and core reference are not overwritten.

## Current Validation

The bounded documentation checks pass for the current source snapshot:

- 29/29 API headers readable;
- 41/41 quoted includes resolve locally;
- independent and indexed counts agree for 170 macros, 24 structs, and 120
  functions;
- 611 scoped fields are indexed and rendered;
- zero indexed declaration tokens are absent from the generated reference;
- all local documentation links resolve;
- no private machine path appears in the documentation artifacts.

See [docs/VALIDATION.md](docs/VALIDATION.md) for the diagnostic redux that corrected the
initial extractor and for the exact proof boundary.

These checks do **not** prove shader compilation, ReShade host compatibility,
game-specific depth behavior, runtime correctness, performance, visual quality,
stable public-API status, or canon acceptance.

## Next Documentation Passes

The safest expansion order is:

1. Atomic support types and functions under
   `reshade-shaders/Shaders/camera_obscura/header`.
2. Depth, sample-address, workload, provider-identity, and evidence receptors.
3. Twin Lantern ray, provider proof, parity, transport, reconstruction,
   temporal-motion, detail-target, and composite surfaces.
4. Public/stable symbol registry only after explicit acceptance and versioning
   decisions.
5. Compile and runtime examples only when their execution evidence is retained.

## License

The hosted API and support headers are published under the [MIT License](LICENSE)
with inline SPDX metadata. ReShade remains an external dependency governed by
its own project and license.

---

<div align="center">

**Camera Obscura API**<br>
*Evidence first. Providers separate. Cohesion inspectable. Output bounded.*

</div>
