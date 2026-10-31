# Amorphous Durable AI Workspace

**A durable working record for AI projects that need to survive the conversation.**

Ongoing AI work accumulates state: what has been observed, what was decided, what changed, what remains unfinished, and where the supporting material lives. Amorphous Durable AI Workspace provides storage and recovery mechanics for that record, so applications can return to an inspectable state instead of reconstructing a project from recollection.

The aim is practical continuity. A person and an agent should have something they can return to, examine, and pick up: the current work, its recorded changes, and a recoverable checkpoint. Within **xOSG — expert Overlay System Gestalt**, this is the persistence layer for that kind of AI instrumentation.

The current implementation is **Durable Workspace Development Kit (DWSK) 0.1.1**: a Python library and CLI with transactional records, a hash-chained journal, three snapshot representations, and quorum recovery.

## What you can build with it

Use one workspace per project to retain records such as:

| Application record | What it can carry |
| --- | --- |
| Working state | Current phase, goals, open questions, unfinished commitments, next actions |
| Conversation index | Captured message records or references to original conversation material |
| Evidence ledger | Source locations, artifact hashes, observations, and uncertainty |
| Decision and action ledger | Proposals, authorization records, attempts, outcomes, and verification results |
| Agent definition or atomic catalog | Profile elements, affect/agency definitions, constraints, and source references |
| Handoff record | The state and evidence another session needs to resume the work |

These are application-level uses, not built-in schemas. The integrating application supplies conversation capture, record structure, retrieval, permissions, and interpretation. Agent-layer software owns the semantics, composition, and enforcement of agent definitions. DWSK preserves the supplied canonical records and checks their consistency.

That distinction matters for agency. A stored permission record needs an application that interprets and enforces it. An action marked complete needs supporting execution evidence. Persistence gives those records a durable place; authorization and truth remain decisions above the storage layer. See the [module boundary](MODULE_BOUNDARY.md).

## The working cycle

1. **Initialize** a project workspace.
2. **Record** changes through the API or CLI. Each accepted mutation and its journal event commit together.
3. **Verify** the runtime database, journal chain, and agreement between current values and replayed events.
4. **Checkpoint** one consistent logical state into SQLite, JSONL, and typed XML.
5. **Inspect** a published generation and its manifest before choosing it for recovery.
6. **Recover** into a new or empty directory when at least two eligible representations agree with the published manifest digest.

For example, a document-review agent can retain its current phase, source references, decisions, and outstanding questions. Before a handoff, its application creates and verifies a checkpoint. A later session retrieves that application state and decides how to resume. DWSK supplies the durable state operations; connecting ChatGPT or another agent to them requires an adapter. Automatic conversation logging and agent orchestration are outside this release.

## Start from this repository

**Requires Python 3.11 or later.** The tested platform is Windows with Python 3.14. The runtime uses only Python's standard library; source installation uses setuptools as its build backend.

From the OpenSurface repository root, in PowerShell:

```powershell
cd xOSG/amorphous-durable-ai-workspace
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install .
```

The Python distribution is named `durable-workspace-development-kit`, its import is `durable_workspace`, and its command is `dwsk`. The project name is Amorphous Durable AI Workspace. Built wheels are not committed to this source folder; the build inventory records the original distribution hashes.

Save this as `workspace_example.py` and run it with the environment's Python. Use fresh paths for the first run: initialization refuses to replace an existing workspace.

```python
from durable_workspace import DurableWorkspace

workspace = DurableWorkspace.init("./demo-workspace")
workspace.set("work/state", {
    "goal": "Review the supplied documents",
    "phase": "review",
    "open_questions": ["Which source supports the current conclusion?"],
    "next_action": "Inspect the cited source",
    "authority": "review-only",
})
workspace.set("decisions/0001", {
    "decision": "Retain original documents separately",
    "status": "recorded",
    "basis": "Preserve exact source bytes and link their hashes",
})

before = workspace.verify()
snapshot = workspace.checkpoint()
restored = DurableWorkspace.recover(snapshot, "./demo-recovered")

if restored.get("work/state") != workspace.get("work/state"):
    raise RuntimeError("Recovered working state differs")
if restored.verify()["logical_digest"] != before["logical_digest"]:
    raise RuntimeError("Recovered logical digest differs")

print(restored.get("work/state"))
print(snapshot)
```

The `authority` and `status` fields above are illustrative application data. They do not configure an authorization engine.

```powershell
.\.venv\Scripts\python.exe workspace_example.py
.\.venv\Scripts\dwsk.exe get ./demo-workspace work/state
.\.venv\Scripts\dwsk.exe verify ./demo-workspace
.\.venv\Scripts\dwsk.exe checkpoint ./demo-workspace
```

The CLI also exposes `init`, `set`, `delete`, `verify-snapshot`, and `recover`. The Python API avoids shell-quoting problems for structured values.

## How the state is protected

**Transactional runtime.** SQLite uses WAL and `synchronous=FULL`. A record mutation and its corresponding journal event commit in the same transaction. The journal links each event to the previous event's hash.

**Replay consistency.** Verification checks the chain and replays its events. Declared record values must agree with that replay. The same consistency check applies to checkpoint eligibility, snapshot inspection, and recovery.

**Three representations.** A checkpoint writes SQLite, JSONL, and typed XML, then a manifest with file hashes and a shared logical digest. A staging directory is never a published snapshot. Recovery requires two valid agreeing representations and agreement with the manifest; no format gets automatic precedence. All three copies share the workspace's storage location, so they are not independent off-device backups.

**Canonical data.** DWSK-CJ-1 accepts null, Booleans, strings, arrays, string-keyed objects, and signed 64-bit integers. Text is NFC-normalized; Booleans and integers retain distinct canonical representations. Floats are rejected. Keep original document bytes outside normalization and retain their locations and hashes when byte identity matters.

**Windows publication.** Generation construction stays parallel. Pointer promotion is protected by a named mutex for the current user, Windows session, and normalized workspace path. Acquisition waits up to five seconds; eligible pointer-replacement failures receive a bounded two-second retry. When Windows reports an abandoned owner, DWSK inspects an existing pointer and its complete generation before proceeding. Inconsistent state is refused. The prior pointer is never pre-deleted.

`LATEST` identifies the last completed pointer promotion. Applications decide freshness, acceptance, and semantic authority. Different path aliases, sessions/users, external programs, and higher-level conflicting decisions are outside the mutex's coordination guarantee.

## Recover deliberately

Preserve the damaged workspace first. Inspect a published generation with `dwsk verify-snapshot`, review its quorum and manifest fields, and recover into a separate new or empty target. A successful inspection command alone is not acceptance of an invalid snapshot. If no eligible quorum exists, recovery refuses rather than choosing a preferred format.

A checkpoint failure can leave a complete unreferenced generation after publication but before pointer promotion. Keep it for inspection. Read the [durability contract](DURABILITY_CONTRACT.md) and [recovery playbook](RECOVERY_PLAYBOOK.md) before operational use.

Windows directory-handle synchronization is not implemented. The evidence covers ordinary execution, injected faults, concurrency, and controlled process interruption; physical power loss, hardware/storage loss, and independent backup recovery are outside the demonstrated guarantees.

## What has been validated

Source validation and installed-wheel validation are separate records:

| Scope | Recorded result |
| --- | --- |
| Source hardening / deterministic fuzzy / torture | 32 / 1,000 / 8 passed |
| Source native checkpoint trials | 20 passed, covering 240 calls |
| Installed unit / self-validation | 17 / 7 passed in each mode |
| Installed retry / native mutex checks | 8 / 12 passed in each mode |
| Installed CLI checks | 15 passed in each mode |
| Installed single-format recovery variants | 3 passed in each mode |
| Installed four-process checkpoint calls | 12 passed in each mode |

Both normal and optimized Python were exercised. Installed tests ran outside the source tree, with installed imports verified. Native mutex tests covered exclusion, timeout, actual owner termination, abandoned-state inspection/refusal, and handle cleanup. The broader source matrix was distributed across modes; it was not run twice in full.

These are bounded Windows/Python 3.14 results, not exhaustive coverage or acceptance on every declared interpreter/OS. The underlying Windows cause remains unresolved. Earlier failed campaigns were retained in private evidence. See the [source-validation basis](VALIDATION_REPORT.md) and [installed build report](BUILD_REPORT.md).

## Project map and contribution entry points

| Location | Purpose |
| --- | --- |
| [src/durable_workspace/](src/durable_workspace/) | Runtime store, canonical profile, formats, recovery, publication guard, and CLI |
| [tests/](tests/) and [validate.py](validate.py) | Included unit checks and self-validation program |
| [examples/](examples/) | Small API example |
| [schemas/](schemas/) | Snapshot manifest schema |
| [templates/workspace-control/](templates/workspace-control/) | Human-readable STATE, TODO, LOG, ERROR_LOG, and DECISIONS starting points |
| [DEVELOPMENT_GUIDANCE.md](DEVELOPMENT_GUIDANCE.md) | Per-project integration and source-preservation guidance |
| [docs/build/ARTIFACTS.json](docs/build/ARTIFACTS.json) | Identity and hashes of the rebuilt distributions, held outside this repository |
| [SOURCE_SHA256SUMS](SOURCE_SHA256SUMS) | Integrity inventory for this repository export |

Begin a change by reading the contract and module boundary. Use disposable fixtures, specify expected rejection behavior, and check state preservation as well as return values. Included tests can be run from this project directory with the environment's Python:

```powershell
.\.venv\Scripts\python.exe -m unittest discover -s tests -p "test_*.py" -v
.\.venv\Scripts\python.exe validate.py
```

Agent adapters, conversation capture, ledger schemas, retrieval policy, and semantic reconciliation are useful integration directions. Define their authority and source boundaries explicitly; storing a record does not establish its approval or meaning.

Licensing and attribution follow the parent OpenSurface [license](../../LICENSE), [license continuation](../../LICENSING.md), and [authorship record](../../AUTHORS.md). Preserve applicable notices when redistributing source.
