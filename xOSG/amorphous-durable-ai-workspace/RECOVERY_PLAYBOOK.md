# Recovery Playbook

1. Preserve the damaged workspace before attempting repair.
2. Run `dwsk verify <workspace>`.
3. Inspect published snapshot generations; ignore `.staging-*` as incomplete.
4. Run `dwsk verify-snapshot <generation>`.
5. If two or three representations agree and match the manifest, recover into a **new empty directory**.
6. Run `dwsk verify <recovered>`.
7. Compare higher-level application invariants before replacing any operational workspace.
8. If no quorum exists, stop. Do not select the newest, largest, or SQLite representation merely by convention.
