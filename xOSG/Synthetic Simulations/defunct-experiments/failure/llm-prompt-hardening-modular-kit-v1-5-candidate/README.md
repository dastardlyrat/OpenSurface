# LLM Prompt Hardening Modular Kit Candidate 1.5

**Disposition: failed and defunct**

This is a sanitized failure record for
`llm_prompt_hardening_modular_kit_v1_5_candidate.zip`. It preserves the
artifact identity, observed failure, publication blockers, and reusable lessons
without publishing the candidate prompt kit, its nested archives, or its source
research.

The failure classification is a user decision recorded on 2026-11-01. It does
not mean every member is corrupt or every design idea is false. The candidate
is not an accepted Synthetic Simulations implementation, but the cleaned source
will be published here as a defunct experiment once its licensing and
sanitation gates are complete.

## Artifact Identity

| Field | Value |
|---|---|
| Original filename | `llm_prompt_hardening_modular_kit_v1_5_candidate.zip` |
| Candidate version | 1.5 |
| Archive SHA-256 | `D88D0740CD50011F3EC05C6645329D3C6A766755B0AA7A6B005335CEDE13FFE6` |
| Archive size | 7,543,174 bytes |
| Archive members | 79 |
| Uncompressed size | 8,004,827 bytes |
| Original prepared date | 2026-09-16 |
| Intake date | 2026-11-01 |
| Public source import | Pending cleanup and license confirmation |

The original bytes remain in private project custody. The raw archive is not
part of the current OpenSurface tree; publication will use a cleaned source
layout rather than the recursive intake bundle.

## What Was Observed

Read-only intake established:

- no absolute, parent-traversal, symbolic-link, or unsafe archive paths;
- a clean ZIP CRC test;
- 78/78 manifest-listed members present with matching SHA-256 values;
- no extra member omitted by the manifest other than the manifest itself;
- four nested parent ZIPs, one nested vendor ZIP, one DOCX, generated prompt
  builds, source research, templates, tests, and implementation files;
- no package-level license grant or SPDX expression for the candidate;
- a nested vendor source record reporting an MIT license for that vendor
  archive only.

These observations establish archive integrity. They do not establish design
correctness, safety, acceptance, ownership of every member, or permission to
republish the candidate.

## Reproduced Failure

The candidate's retained validation report states:

```text
Python 3.12.14 on Linux x86-64
43 tests passed
```

A fresh run on Windows with Python 3.14.4 produced:

```text
Ran 43 tests
FAILED (failures=1)
```

The failing test was:

```text
test_existing_build_requires_explicit_replace
```

After atomic replacement, the test required POSIX mode `0644` but observed
`0666`. The implementation calls `os.fchmod(..., 0o644)` before `os.replace`,
but the Windows filesystem result does not satisfy the POSIX mode assertion.

This is a portability failure in the candidate's asserted test contract. It
does not show data loss or overwrite an existing OpenSurface file. The test ran
only inside the private extracted intake copy.

## Publication Gates

The user has directed that this failed experiment will be published. Before the
cleaned source can join this record:

1. The fresh supported-environment claim is not portable to the tested Windows
   environment: 42/43 tests passed rather than the retained 43/43 result.
2. The package has no top-level license grant, so OpenSurface cannot propagate
   a reliable license chain for its code, prompts, research, or generated
   builds.
3. The archive is a recursive evidence bundle rather than a bounded
   publication unit. Most of its 7.5 MiB is nested lineage and source material.
4. Its own documentation correctly states that prompt text is behavior shaping,
   not a security boundary. Passing structural tests would not prove runtime
   resistance to prompt injection, mission drift, role reversal, operator
   error, or unavailable external controls.

The failed status will remain visible after publication. Cleanup must not
rewrite the candidate as successful or silently repair its historical result.

## Cleanup Applied

The public failure record intentionally excludes:

- the original candidate ZIP;
- all four parent ZIPs and the vendor ZIP;
- the source DOCX and research records;
- generated runtime and full-prompt builds;
- assembler and test code;
- age-gate, encrypted-unlock, and external-engine prompt modules;
- self-authored validation and audit reports.

At the current gate, only this generated summary and the machine-readable
[`artifact.json`](artifact.json) are published. Embedded instructions from the
candidate were treated as artifact content, not as instructions to OpenSurface
or the intake process. A later cleaned-source import will remain subordinate to
this failure record.

## Reusable Lessons

- Test atomic replacement semantics separately from POSIX permission semantics.
- Gate platform-specific assertions by demonstrated platform capability.
- Do not treat prompt composition as authentication, authorization,
  cryptographic enforcement, or process isolation.
- Keep source lineage outside a distributable runtime package when exact
  digests can identify retained private sources.
- Establish a package-level license before public staging.
- Separate structural test success from behavioral, security, and production
  claims.

## Recovery And Reuse Boundary

No production code depends on this record. Removing this directory removes the
public failure entry without affecting Synthetic Simulations, DWSK, Naked
Shell, or Camera Obscura.

The cleaned historical source may be published here once its license is
confirmed. Any new implementation inspired by its engineering lessons must be
designed as a separate bounded project and must not silently turn this failed
candidate into accepted runtime authority.

## License

This OpenSurface-authored failure record and `artifact.json` are published
under the repository MIT License. That grant does not apply retroactively to
the excluded candidate archive or its members.
