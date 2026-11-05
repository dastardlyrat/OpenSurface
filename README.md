# OpenSurface

OpenSurface hosts the Camera Obscura publication tree. The xOSG AI instrumentation
family has moved to [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg).

This repository is a storefront, not a development dump. Each published unit
must be independently understandable, installable, removable, licensed, and
traceable to its source. Experimental branches, machine logs, raw validation
forms, private workspace paths, and unaccepted artifacts stay in the private
workshop.

Original OpenSurface software is released under the MIT License unless an
individual file states otherwise. Existing license and authorship obligations
continue forward; publication never silently replaces them.

## Projects

| Project | What it does | Publication state |
|---|---|---|
| [External Image Denoiser](Camera%20Obscura/External%20Image%20Denoiser/) | Multiscale spatial and temporal denoising for the completed image | Install-ready V2.1; live application confirmed |
| [Guided Detail](Camera%20Obscura/Guided%20Detail/) | Same-surface detail reclamation and guided line emphasis | Published source with diagnostic workflow |
| [Stabilized Detail Cache](Camera%20Obscura/Stabilized%20Detail%20Cache/) | Captures bounded signed detail and restores it later in the chain | Live compile and visual pass recorded |
| [Lazara Color Revival](Camera%20Obscura/Lazara%20Color%20Revival/) | Recovers muted source color or deliberately removes it | Refactored candidate; live regression still required |
| [xOSG — relocated](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg) | AI instrumentation: Naked Shell, Amorphous Durable AI Workspace / DWSK, and Synthetic Simulations | Maintained in alia-june/xOSG-prototype; no current xOSG working tree here |

## Camera Obscura

Camera Obscura is a collection of ReShade effects built around explicit
sampling, bounded evidence, inspectable decisions, and reversible output.
Effects remain independent: users may install one without adopting the entire
collection.

### Related Publication: Twin Lanterns

[Twin Lanterns](https://github.com/alia-june/Lunar-Flower/tree/main/Twin-Lanterns)
is published separately through Lunar Flower. Its page contains the Stable 1.4,
Fidelity Overdrive, and Full Resolution Dual Ray Alpha builds together with the
versioned, fully documented ReShade FX include API.

### External Image Denoiser

The External Image Denoiser targets visible instability after the image has
already been formed. Five independently controlled size bands cover tiny
through extra-large noise. Spatial evidence and temporal history may operate
together, by agreement, or in isolation.

It is deliberately not a lighting system. It does not trace rays, transport
donor light, reconstruct GI, or add illumination. Its diagnostic views expose
what it detected, trusted, admitted, and changed.

[Read the denoiser guide](Camera%20Obscura/External%20Image%20Denoiser/README.md)

### Guided Detail

Guided Detail Reclamation restores bounded signed tonal structure. Guided Ink
Lines adds optional line and contour emphasis from admitted same-surface
evidence. The pair is useful before the denoiser when fine structure should be
chosen deliberately rather than recovered from an already softened image.

![Guided Detail diagnostic](Camera%20Obscura/Guided%20Detail/docs/images/guided-detail-diagnostic.png)

### Stabilized Detail Cache

The cache separates detail selection from final application. Capture stores a
bounded signed-detail field after reclamation and denoising; Reapply can restore
that field after intervening color or image effects. The full-resolution
`RGBA16F` store uses 64 bits per pixel, approximately 63.3 MiB at 3840x2160.

### Lazara Color Revival

Lazara Color Revival strengthens observed source and local color relationships
without assigning a fixed hue family. Its inverted mode intentionally removes
admitted chroma while preserving source luma.

![Lazara Color Revival comparison](Camera%20Obscura/Lazara%20Color%20Revival/docs/images/lazara-color-revival-comparison.png)

## xOSG — relocated

The reviewed current xOSG family moved to [alia-june/xOSG-prototype](https://github.com/alia-june/xOSG-prototype/tree/main/docs/xosg) on 2026-11-05, including the merged DWSK R4 source, Naked Shell identity, and Synthetic Simulations documentation and sanitized failed experiment.

The public destination records source lineage, license continuation, imported-file identities, privacy-review limits, and fresh fixed DWSK source checks. This repository's earlier commits remain historical evidence. Camera Obscura source and its validation requirements are unchanged.

## Installation

Open the README inside the effect you want to install. Components with a
`reshade-shaders` folder are packaged so that folder can be merged directly
into the game's ReShade installation.

OpenSurface does not bundle ReShade itself or replace the installation's
`ReShade.fxh`. Reload ReShade after copying an effect and review its compiler
messages before enabling it in a preset.

## Suggested Detail Workflow

When all three detail tools are used together, the confirmed working order is:

1. Guided Detail Reclamation.
2. External Image Denoiser.
3. Stabilized Detail Capture.
4. Other image and color effects.
5. Stabilized Detail Reapply.

This is a workflow, not a hidden dependency. Every effect has an independent
disable or removal path.

## Publication Standard

OpenSurface publication requires:

- an explicit public file boundary;
- preserved authorship and license continuation;
- machine-readable SPDX metadata;
- complete local include closure except named external dependencies;
- source and package integrity records;
- stated validation scope and unresolved runtime limits;
- no credentials, private machine paths, raw workshop records, or unaccepted
  implementation artifacts.

See [PUBLISHING.md](PUBLISHING.md) for the public/private boundary,
[docs/PROVENANCE.md](docs/PROVENANCE.md) for source lineage, and
[docs/VALIDATION.md](docs/VALIDATION.md) for the current evidence ledger.

## Validation

From the repository root:

```powershell
python -B tools/validate_repository.py
```

The validator checks the publication inventory, local shader includes,
expected techniques, file-level licensing, private-path exclusions, source
integrity, and documentation links. These checks do not replace a live ReShade
compile, motion test, performance measurement, or visual acceptance pass.

## License

Original software is available under the [MIT License](LICENSE). See
[AUTHORS.md](AUTHORS.md), [LICENSING.md](LICENSING.md), and
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for authorship, continuation,
external dependencies, and screenshot boundaries. The repository follows the
[REUSE specification](https://reuse.software/spec/) for machine-readable
copyright and licensing metadata.
