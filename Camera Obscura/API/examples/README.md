# Camera Obscura API Examples

**Three deliberately dormant ReShade FX consumers for learning the contracts,
inspecting their evidence, and testing integration without silently installing
another effect.**

[API landing page](../README.md) ·
[Core reference](../docs/CORE_REFERENCE.md) ·
[Complete declarations](../docs/DECLARATIONS.md) ·
[Package validation](../docs/VALIDATION.md) ·
[Twin Lanterns API 0.1.0](https://github.com/alia-june/Lunar-Flower/tree/main/Twin-Lanterns/API/0.1.0)

> **Status:** generated teaching consumers, structurally validated, not yet
> attested by a live ReShade compile or visual acceptance pass. Their
> `.fx.example` suffix is a safety boundary, not decoration.

## Why These Examples Exist

The API exposes records and boundaries rather than one opaque “make the image
better” function. A useful example therefore needs to show more than the final
pixel. It should reveal:

- which host inputs were required;
- which evidence was observed;
- which provider produced it;
- where two providers agreed or conflicted;
- what was admitted, weighted, rejected, or contained;
- where application finally became authorized;
- how to return to the untouched source when the evidence is inadequate.

These examples are intentionally verbose. The comments are part of the
interface: they explain ownership, dataflow, negative controls, diagnostic
channels, and recovery behavior next to the code that exercises them.

## Choose An Example

| Example | Contract surface | Best first question | Visible behavior |
|---|---|---|---|
| [Core walkthrough](CAMERA_OBSCURA_API_CoreWalkthrough.fx.example) | OpenSurface Camera Obscura seven-file core umbrella | “How does one pixel travel through the complete wrapper flow?” | Optional low-strength composite plus nine evidence/source views |
| [Twin Lantern parity inspector](CAMERA_OBSCURA_API_TwinLanternParity.fx.example) | OpenSurface development extension outside Twin Lanterns 0.1.0 stable symbols | “Did DDA and March receive the same problem, and where do they diverge?” | Diagnostic only; never transports light into the source |
| [Twin Lantern bounded composite](CAMERA_OBSCURA_API_TwinLanternComposite.fx.example) | Registered Twin Lanterns API 0.1.0 transport and TL09 composite entrypoints | “How does supported donor evidence become a contained addition?” | Disabled and source-exact by default; diagnostics remain available |

## Contract And Authority Map

The examples cross two related but distinct publication surfaces.

| Surface | Authority in these examples | What that means |
|---|---|---|
| `CAMERA_OBSCURA_API_All.fxh` | OpenSurface development core | The core walkthrough may use its documented seven-file wrapper graph. Hosting does not make every other OpenSurface header stable. |
| Twin Lanterns API `0.1.0` | Public, versioned, pre-1.0 contract | The bounded-composite example uses the registered transport and TL09 composite entrypoints. The eight shared implementations match the hosted OpenSurface copies after removing only publication SPDX prefixes. |
| `CAMERA_OBSCURA_API_TwinLanternParity.fxh` | Source-present OpenSurface development extension | The parity inspector adopts it explicitly. It is not one of the twelve stable Twin Lanterns 0.1.0 contract symbols. |
| `ReShade.fxh` | External host dependency | The target ReShade installation supplies back-buffer access, depth access, and `PostProcessVS`. OpenSurface does not vendor it. |

No example changes the accepted frozen runtime rail, promotes a cold receptor,
or upgrades structural checks into runtime acceptance.

## Architecture At A Glance

### Camera Obscura core wrapper flow

```text
ReShade back buffer + linearized depth
                  │
                  ▼
       capability declaration
                  │ fail closed
                  ▼
       context + surface guide
                  │
                  ▼
    direction → request → controls → ray
                  │
          ┌───────┴────────┐
          ▼                ▼
     DDA provider     March provider
          │                │
          └───────┬────────┘
                  ▼
       dual-hit agreement/conflict
          │                │
          ▼                ▼
   DDA contribution   March contribution
          └───────┬────────┘
                  ▼
          evidence-weighted resolve
                  │
                  ▼
        bounded composite or debug view
```

### Twin Lantern parity flow

```text
one receiver + one direction + one tolerance set
                         │
                         ▼
                 one shared ray/control set
                         │
                 ┌───────┴────────┐
                 ▼                ▼
            DDA + refine     March + refine
                 │                │
                 └───────┬────────┘
                         ▼
          hit presence + UV/depth/distance deltas
                         │
                         ▼
        categorical, agreement, conflict, confidence,
                  endpoint, or source view
```

Agreement is not scene truth. It only says the two providers produced similar
evidence under the configured tolerances.

### Twin Lantern transport and TL09 authority flow

```text
receiver ray
    │
    ├── DDA hit → donor compatibility → raw weight ──┐
    │                                                │
    └── March hit → donor compatibility → raw weight ├─► normalized weights
                                                     │
                                                     ▼
                                           combined donor RGB
                                                     │
                                           transport evidence
                                                     │
                                                     ▼
source RGB + receiver valid + enabled + strength + maximum contribution
                                                     │
                                                     ▼
                                      TL09 admission and containment
                                                     │
                         ┌───────────────────────────┴────────────────────┐
                         ▼                                                ▼
                    final RGB                                  diagnostic evidence
```

The example passes `combined_donor_rgb` and `evidence_strength` separately to
TL09. It does **not** pass `raw_radiance_rgb` with the same evidence because raw
radiance is already evidence-weighted; doing both would weight the transport
evidence twice.

## Deliberate Installation

The API package remains include-only. None of these files is placed inside its
installable `reshade-shaders` tree.

1. Install the API package's `reshade-shaders` directory into the target
   ReShade installation.
2. Confirm that the installation already supplies a known-good `ReShade.fxh`.
3. Choose **one** example first.
4. Copy its `.fx.example` file into the installation's
   `reshade-shaders/Shaders` directory.
5. Remove only the final `.example` suffix so the copied file ends in `.fx`.
6. Reload ReShade and inspect the compile log before enabling the technique.
7. Confirm the correct depth buffer before interpreting surface or provider
   evidence.

Expected installed shape:

```text
reshade-shaders/
└── Shaders/
    ├── ReShade.fxh                         supplied by ReShade
    ├── CAMERA_OBSCURA_API_...Example.fx   copied and renamed by the tester
    └── camera_obscura/
        ├── api/
        └── header/
```

To roll back, disable the example technique and delete only the copied `.fx`
file. The include package contains no temporal state that needs clearing.

## Example 1: Core Walkthrough

File: [`CAMERA_OBSCURA_API_CoreWalkthrough.fx.example`](CAMERA_OBSCURA_API_CoreWalkthrough.fx.example)

This is the broadest example. It follows one pixel from host input through the
documented core wrappers and keeps each intermediate record visible.

### Stage-by-stage map

| Stage | Call | Produces | Why it remains separate |
|---|---|---|---|
| Capability | `CAMERA_OBSCURA_API_QueryCapabilities` | Declared color/depth facilities | Missing inputs can fail closed before traversal. |
| Context | `CAMERA_OBSCURA_API_MakeContext` | UV, pixel, phase, semantic stage | Context locates work; it is not evidence authority. |
| Surface | `CAMERA_OBSCURA_API_BuildSurface` | Validity, depth, proxy normal, confidence, edge risk, luma | Invalid depth remains invalid instead of becoming guessed geometry. |
| Direction | `CAMERA_OBSCURA_API_SelectDirection` | One deterministic screen-space direction | Direction selection is visible and reproducible. |
| Request | `CAMERA_OBSCURA_API_DefaultRequest` | Caller-facing ray policy | Intent is distinct from normalized execution controls. |
| Controls | `CAMERA_OBSCURA_API_BuildControls` | Clamped traversal controls | Bounded work is explicit before either provider runs. |
| Ray | `CAMERA_OBSCURA_API_BuildRay` | Receiver-bound ray record | One ray is shared, making provider comparison meaningful. |
| Providers | `TraceDDA`, `TraceMarch` | Independent refined hit records | Neither provider silently owns final authority. |
| Cohesion | `EvaluateDualHit` | Agreement, conflict, combined confidence | Comparison is recorded before donor application. |
| Contribution | `BuildContribution` twice | Donor RGB, indirect RGB, weight, compatibility evidence | A hit is not automatically an admissible contribution. |
| Fallback | `DefaultFallback` | Source-bearing recovery record | The source remains available when evidence fails. |
| Resolve | `Resolve` | Indirect RGB plus confidence | Combination does not invent missing evidence. |
| Composite | `Composite` | Bounded normalized RGB | Application occurs only after resolve. |
| Debug | `DebugView` | Composite, source, or evidence projection | Inspection does not change provider or composite authority. |

### Core views

| View | Read it as |
|---|---|
| Composite | The example's low-strength final result. |
| DDA Hit | DDA hit, reason, step, confidence, and residual presentation. |
| March Hit | March hit, reason, step, confidence, and residual presentation. |
| Agreement | Shared hit agreement, confidence split, or conflict. |
| DDA Contribution | DDA donor energy and admitted weight. |
| March Contribution | March donor energy and admitted weight. |
| Reasons | Blended provider terminal-reason colors. |
| Composite Delta | Display-amplified positive change from source to composite. |
| Provider Balance | DDA/March weight dominance or balance. |
| Source | Unmodified back-buffer control view. |

`Enable Core Composite` sets application strength to zero when disabled, but it
does not suppress evidence construction. That allows diagnostics to remain
available while visible application is off.

## Example 2: Twin Lantern Parity Inspector

File: [`CAMERA_OBSCURA_API_TwinLanternParity.fx.example`](CAMERA_OBSCURA_API_TwinLanternParity.fx.example)

This is a provider comparison harness, not a lighting effect. DDA and March
receive the same receiver, direction, ray budget, slope, bias, thickness, and
comparison tolerances.

### Input cases

| Input case | Purpose | Expected interpretation |
|---|---|---|
| Live Depth | Exercise the target game's configured receiver depth | Results are meaningful only after depth is confirmed. |
| Forced Invalid Receiver | Negative control for missing receiver authority | Ray/provider evidence should reject rather than invent a hit. |
| Forced Zero Direction | Negative control for invalid ray construction | Ray validity should expose the bad request. |

### Parity views

| View | Channel or color meaning |
|---|---|
| Provider Outcome | Green: both hit. Blue: DDA only. Orange: March only. Charcoal: neither. |
| Agreement Channels | Red: UV agreement. Green: depth agreement. Blue: distance agreement. |
| Conflict | Red overlay strength records tolerance conflict or provider split. |
| Confidence | Red: DDA. Green: March. Blue: weaker confidence. |
| Endpoint | Red/green: resolved endpoint UV. Blue: ray valid. |
| Source | Unmodified back-buffer control view. |

The inspector does not declare a winner. A disagreement is a discriminator for
further testing; an agreement is not proof that both providers found correct
scene geometry.

## Example 3: Twin Lantern Bounded Composite

File: [`CAMERA_OBSCURA_API_TwinLanternComposite.fx.example`](CAMERA_OBSCURA_API_TwinLanternComposite.fx.example)

This is the narrowest useful path from versioned Twin Lantern transport to the
TL09 authority boundary. It intentionally omits reconstruction textures,
temporal history, and a production tuning rail.

### Transport record

`CAMERA_OBSCURA_API_BuildTwinLanternTransportEvidence` retains:

- receiver and ray validity;
- each provider's hit and terminal reason;
- donor validity and donor RGB;
- distance, facing, normal compatibility, and hit confidence;
- raw and normalized provider weights;
- one-provider and two-provider activity states;
- combined donor RGB, evidence strength, and zero-contribution state.

Complementary mode admits independently supported provider samples. Missing
weight remains `zero_contribution`; it is not treated as supported black light.

### TL09 composite contract

For normalized SDR input, the demonstrated authority boundary is:

```text
admission = enabled × receiver valid × usable evidence × nonzero strength
requested = indirect RGB × evidence × strength × admission
channel ceiling = min(maximum contribution, 1 - source RGB)
bounded contribution = clamp(requested, 0, channel ceiling)
final RGB = source RGB + bounded contribution
```

The contract cannot subtract from source RGB. It cannot add more than the
configured per-channel maximum or the remaining normalized channel room.

### Composite views

| View | Read it as |
|---|---|
| Final Composite | Source plus TL09-bounded contribution. Returns the exact source sample while disabled. |
| Combined Donor | Provider-normalized donor color before evidence, strength, and containment. |
| Bounded Contribution | Actual admitted addition, amplified 8× for display only. |
| Transport Evidence | Heat map of transport evidence before TL09 application gates. |
| Admission And Application | Red: admitted. Green: applied. Blue: rejected. |
| Provider Weights | Red: normalized DDA. Green: normalized March. Blue: one-provider bound valid. |
| Source | Unmodified back-buffer control view. |

### Exact disabled recovery

The shader still builds transport evidence while disabled so diagnostic views
work. When both conditions below are true, it returns the original source
sample directly:

```text
Enable Bounded Composite = off
View = Final Composite
```

That return occurs before normalized presentation clamping. It is therefore a
real source-preserving recovery path, not merely a zero-strength approximation.

## Recommended Inspection Order

### Core walkthrough

1. Source
2. DDA Hit
3. March Hit
4. Reasons
5. Agreement
6. DDA Contribution
7. March Contribution
8. Provider Balance
9. Composite Delta
10. Composite

### Twin Lantern bounded composite

1. Keep `Enable Bounded Composite` off.
2. Confirm Source.
3. Inspect Provider Weights.
4. Inspect Transport Evidence.
5. Inspect Admission And Application.
6. Inspect the display-amplified Bounded Contribution.
7. Enable the composite only after the evidence behaves coherently.
8. Return to Final Composite and compare against the disabled source-exact
   control.

### Parity discrimination

1. Confirm Source and live depth.
2. Observe Provider Outcome across several direction indices.
3. Inspect Agreement Channels where both providers hit.
4. Inspect Conflict and Confidence.
5. Run Forced Invalid Receiver and Forced Zero Direction as negative controls.
6. Treat unexpected negative-control success as a failure requiring diagnosis.

## Failure And Recovery

| Observation | Likely boundary | Recovery action |
|---|---|---|
| ReShade compile error | Include layout, host header, language/backend incompatibility, or example defect | Disable/remove the copied `.fx`, preserve the complete log, and verify the installed tree before editing shader logic. |
| Source view is wrong | Host/back-buffer configuration | Stop provider interpretation; repair the host setup first. |
| Everything reports invalid depth | ReShade depth selection or reversed/logarithmic depth configuration | Correct ReShade depth settings; do not loosen provider tolerances to hide missing depth. |
| Both providers always miss | Invalid receiver, ray direction, travel/slope mismatch, or no screen-space intersection | Inspect ray validity, endpoint, and reasons before changing contribution controls. |
| Providers disagree heavily | Different traversal responses or tolerance failure | Use Agreement, Conflict, Confidence, and negative controls to isolate the cause. Do not simply select the brighter provider. |
| Donor color exists but nothing applies | Receiver/evidence/application gate, zero strength, or no remaining channel room | Inspect Transport Evidence and Admission And Application; then check enable, strength, and source saturation. |
| Bright edges or implausible light | Bad depth, screen-space leak, excessive strength, or excessive maximum contribution | Disable application, preserve diagnostics, confirm depth, then reduce bounds only after the evidence path is understood. |
| Disabled final differs from source in the bounded-composite example | Recovery-path regression | Stop testing, preserve the capture and shader log, and report it as a defect. |

## What Static Validation Covers

`python -B "Camera Obscura/API/tools/validate_package.py"` checks that:

- all three dormant example files are present;
- each file declares exactly its expected technique;
- each example contains its required contract-call tokens;
- braces are balanced;
- all six includes are classified;
- the three API include targets resolve in the simulated installed layout;
- the three `ReShade.fxh` includes remain external host dependencies;
- every example carries MIT SPDX metadata;
- the examples README retains its required architecture and boundary sections;
- local documentation links resolve.

These checks establish package structure and internal reference consistency.
They do **not** establish:

- a clean ReShade compile;
- backend compatibility;
- target-game depth correctness;
- runtime behavior or frame time;
- visual quality or artistic acceptance;
- semantic correctness of a provider hit;
- stable status for the parity extension;
- canon acceptance of generated example design.

## Extending An Example Without Losing The Boundaries

When turning an example into a real effect:

1. Pin the API surface you intend to consume.
2. Keep source, evidence, admission, application, and diagnostics as separate
   values.
3. Preserve an exact, testable bypass.
4. Keep both provider records until the selection or combination policy is
   explicit.
5. Treat zero evidence as unsupported, not as valid darkness.
6. Bound workload, strength, and contribution before adding presentation
   controls.
7. Keep diagnostic gain out of production math.
8. Add a compile log, target backend, depth configuration, captures, and frame
   timing to the acceptance record.
9. Do not add a header to the core or stable registry merely because the
   example can call it.

## Source And Evidence Notes

- The core walkthrough is generated against the current hosted OpenSurface
  development API.
- The Twin Lantern transport and composite entrypoints are registered by the
  public Twin Lanterns API 0.1.0 package.
- The eight shared Twin Lantern implementations hosted here were compared with
  the live 0.1.0 package at public commit
  `864377b03af50779415b59aa4857305831603f70`; implementation text matched after
  removing only publication SPDX prefixes.
- The parity inspector is an OpenSurface development example outside the
  versioned twelve-symbol Twin Lanterns 0.1.0 stability contract.
- The examples are generated synthesis. They remain outside accepted runtime
  canon until separately compiled, exercised, reviewed, and accepted.

---

**Read the evidence first. Enable application last. Keep the source recoverable.**
