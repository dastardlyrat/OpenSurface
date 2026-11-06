# Camera Obscura API Examples

These are deliberately dormant ReShade FX examples. Their `.fx.example`
suffix prevents ReShade from loading techniques merely because the API package
was installed.

## Use an example

1. Install the API package's `reshade-shaders` tree.
2. Copy one example into the installed `reshade-shaders/Shaders` directory.
3. Remove only the final `.example` suffix so the file ends in `.fx`.
4. Reload ReShade and select the example technique.
5. Confirm the game's depth buffer before interpreting any provider result.

The examples expect this installed include path:

```text
reshade-shaders/Shaders/camera_obscura/
├── api/
└── header/
```

## Examples

| File | Technique | Purpose | Output behavior |
|---|---|---|---|
| `CAMERA_OBSCURA_API_CoreWalkthrough.fx.example` | `CAMERA_OBSCURA_API_CoreWalkthrough` | Shows the seven-file core path from context and surface evidence through both providers, cohesion, composite, and debug dispatch | Composite or selected diagnostic view |
| `CAMERA_OBSCURA_API_TwinLanternParity.fx.example` | `CAMERA_OBSCURA_API_TwinLanternParityExample` | Compares DDA and March over the same Twin Lantern ray and controls using an OpenSurface development extension | Diagnostic only; never composites transport into the source |
| `CAMERA_OBSCURA_API_TwinLanternComposite.fx.example` | `CAMERA_OBSCURA_API_TwinLanternCompositeExample` | Connects the transport and bounded-composite entrypoints registered by [Twin Lanterns API 0.1.0](https://github.com/alia-june/Lunar-Flower/tree/main/Twin-Lanterns/API/0.1.0) | Disabled by default; final output is source-exact until enabled |

## Which contract is being demonstrated?

- **Camera Obscura core walkthrough:** consumes the broader OpenSurface
  development API through `CAMERA_OBSCURA_API_All.fxh`.
- **Twin Lantern bounded composite:** consumes the public pre-1.0 transport and
  TL09 composite contracts. The eight relevant hosted implementation files
  match the live Twin Lanterns 0.1.0 package after removing only their SPDX
  publication prefixes.
- **Twin Lantern parity inspector:** consumes
  `CAMERA_OBSCURA_API_TwinLanternParity.fxh`, which is present in OpenSurface
  but is not one of the twelve stable Twin Lanterns 0.1.0 contract symbols.

## Evidence boundary

The examples are generated consumers of source-present declarations. Static
package validation checks their expected files, include targets, technique
names, and license metadata. That does not prove ReShade compilation, runtime
correctness, target-game depth behavior, performance, or visual acceptance.

The core example uses the documented seven-file umbrella. The Twin Lantern
examples adopt specialized headers outside that umbrella explicitly; their
presence here does not promote those headers into the Camera Obscura core or
expand the versioned Twin Lanterns contract.
