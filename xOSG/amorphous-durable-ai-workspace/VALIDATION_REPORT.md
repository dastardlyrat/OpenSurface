# DWSK 0.1.1 source-validation basis — 2026-10-31

The runtime implementation is copied byte-for-byte from the validated mutex candidate. Version metadata changes to 0.1.1; packaging introduces no runtime behavior change.

The retained source campaign passed 32 hardening, 1,000 deterministic fuzzy and eight torture cases. Existing 17-unit, seven-self-validation and fifteen-CLI checks passed in both modes. Eight retry tests and twelve mutex tests passed in each mode. Twenty native four-process checkpoint trials (240 calls) completed without a surfaced worker failure. Native mutex tests exercised exclusion, timeout, real abandoned ownership and inconsistent-state refusal. Earlier failures remain retained historical evidence.

These are bounded Windows/Python 3.14 observations. They do not establish an OS root cause, exhaustive coverage, acceptance on every interpreter/OS, physical power-loss durability or application integration. The module boundary and durability contract remain applicable.

The rebuilt wheel must also pass outside-source installation checks. The accompanying BUILD_REPORT.md and artifact inventory record those results and artifact hashes. Source success alone does not prove the contents or imports of an installed wheel.

The original supplied report is preserved as docs/HISTORICAL_VALIDATION_0.1.0.md.
