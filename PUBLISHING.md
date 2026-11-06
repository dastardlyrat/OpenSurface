# OpenSurface Publishing Boundary

OpenSurface is the public distribution surface for accepted work. Private
development remains in private workspaces and is promoted through a clean,
reviewed export. The storefront is not a mirror of the workshop.

## Visibility Rule

Repository visibility applies to the entire Git repository. A public GitHub
repository exposes every tracked file and every reachable historical revision;
folders cannot be selectively private.

For that reason, OpenSurface public releases are created from a clean
publication tree. A workspace repository containing private or superseded
history must not be made public merely by changing its visibility setting.

## Public Material

The storefront may contain:

- accepted shader and application source;
- install-ready package layouts;
- user-facing README files and screenshots cleared for publication;
- required license texts, SPDX metadata, authorship, and third-party notices;
- bounded provenance and validation summaries;
- reproducible public validators;
- source and release integrity manifests.
- explicitly labeled development API snapshots whose source, licensing,
  include closure, lifecycle limits, and publication transformation are
  reproducibly recorded.

## Private Workshop Material

The publication export excludes:

- inbox, outbox, staging, mill, backup, and recovery folders;
- raw compiler and runtime logs;
- machine-specific paths, usernames, presets, and installation state;
- credentials, tokens, keys, and private service configuration;
- blank or partially completed acceptance forms;
- raw validation JSON and exploratory worksheets;
- rejected, withdrawn, superseded, or unaccepted implementations;
- internal handoff messages and research notes;
- package archives that have not passed the publication gate;
- screenshots whose publication rights have not been classified.

An accepted fact derived from private evidence may appear in the public
validation or provenance summary. The private evidence itself remains under
private custody unless separately approved for release.

## Promotion Gate

Before a public release:

1. Export only the approved file set into a clean tree.
2. Verify source provenance, authorship, and license continuation.
3. Scan current files and reachable history for private paths and secrets.
4. Validate local include closure and external dependency declarations.
5. Regenerate integrity manifests from the exported bytes.
6. Run repository and REUSE validation.
7. Inspect documentation links and install instructions.
8. Confirm that the public remote contains only the clean publication history.
9. Record the release tag and package hashes.

Hosting a development API snapshot does not by itself make every declaration a
stable public contract, wire cold material into a runtime umbrella, or
supersede a separately accepted frozen rail. Those transitions require their
own explicit decision and validation evidence.

## Repository Model

The intended model is one public OpenSurface storefront supplied by one or more
private development workspaces. A second private copy of the storefront is not
required. Private work is source material; the public repository is a curated
release product.
