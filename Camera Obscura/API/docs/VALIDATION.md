# Camera Obscura API Publication Validation

Date: 2026-11-06

Status: **PASS for the bounded source, package, and documentation checks below**.

## Hosted scope

- 29 API headers under
  `reshade-shaders/Shaders/camera_obscura/api`
- nine support headers under
  `reshade-shaders/Shaders/camera_obscura/header`
- 38 hosted ReShade FX headers total
- implementation copied from the reviewed current Camera Obscura development
  tree
- publication copies add only the repository's MIT copyright and SPDX license
  header before their prior implementation bytes
- three generated consumers are stored outside the install tree with dormant
  `.fx.example` suffixes
- accepted frozen runtime source was not modified or silently relabeled

## Executed checks

| Check | Result | Evidence |
|---|---:|---|
| Deterministic regeneration | PASS | `SOURCE_INVENTORY.csv`, `SYMBOLS.json`, and `DECLARATIONS.md` match a fresh generator run |
| Package include closure | PASS | 53/53 quoted includes across all 38 hosted headers resolve locally |
| API include inventory | PASS | 41 API-directory include declarations indexed; zero unresolved |
| Macro inventory | PASS | independent scan and index both report 170 macros |
| Struct inventory | PASS | independent scan and index both report 24 structs |
| Struct-field inventory | PASS | index and generated reference contain 611 scoped fields |
| Function inventory | PASS | independent scan and index both report 120 function definitions |
| Declaration rendering | PASS | zero indexed macro, struct, scoped-field, or function signatures missing from `DECLARATIONS.md` |
| Core umbrella derivation | PASS | seven files reachable from `CAMERA_OBSCURA_API_All.fxh`; 22 API headers remain outside that umbrella |
| Dormant examples | PASS | three expected consumers, three expected techniques, required contract-call tokens present, balanced braces, 221 explanatory comment lines with every file above the minimum, six required integration-guide sections, 6/6 includes classified, and 3/3 local API include targets resolve in the simulated installed layout |
| Publication metadata | PASS | 38/38 hosted shader headers carry MIT SPDX metadata |
| Documentation links | PASS | all local API-package documentation links resolve |
| Private-path scan | PASS | no private machine path is present in the hosted API package |

## Diagnostic redux recorded

The first documentation extractor used vertical-whitespace-capable patterns at
line boundaries. That caused include-guard values to consume later directives
and caused return/control-flow expressions to be misidentified as functions.
Those generated artifacts were rejected. Declaration starts now require
explicit horizontal whitespace and control keywords are excluded; the complete
inventory was regenerated and independently recounted.

An initial publication-copy command also used literal-path wildcard syntax and
stopped before copying any source files. The rerun enumerated every source file
explicitly and confirmed the resulting 29 API plus nine support headers.

## Proof boundary

These checks establish that the hosted declaration documentation is
byte-current with the published API headers, all package-local includes resolve,
the expected declarations are covered, the public copies carry the stated
license metadata, and the dormant examples name source-present techniques and
installed include targets consistently.

They do not establish:

- complete semantic documentation of all 29 API headers;
- stable public-API status for source-present declarations;
- shader or consuming-effect compilation;
- example compilation or execution;
- ReShade host or game compatibility;
- runtime behavior, target-game depth correctness, performance, or visual
  acceptance;
- promotion of cold receptors or wiring through the core umbrella;
- replacement of the accepted frozen runtime rail.

The semantic documentation is complete only for the seven-file core umbrella
at the source-visible wrapper level. All other declarations remain indexed for
future field-by-field and function-by-function documentation.
