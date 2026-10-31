# Changelog

## Unreleased â€” 2026-10-31
- Coordinate Windows pointer promotion with a workspace/user/session named
  mutex, five-second acquisition timeout and abandoned-owner state validation.
- Retry atomic LATEST pointer replacement for Windows errors 5/32/33 within a
  two-second retry deadline, retaining the old pointer and complete generations
  on persistent failure. No record, journal or snapshot format change.

## 0.1.0 â€” 2026-09-28
- Initial standalone durable-workspace package.
- Defined DWSK-CJ-1 canonicalization profile.
- Added transactional state + chained journal.
- Added SQLite/JSONL/XML snapshots.
- Added manifest-last atomic publication and 2-of-3 recovery quorum.
- Added verification, recovery, CLI, tests, and module-boundary documentation.
