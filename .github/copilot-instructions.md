## Overview

- This repo builds and publishes an Alpine-based docker image that is used as a base for devcontainer; the
  multi-stage [Dockerfile](../Dockerfile) is the “source code” and GitHub Actions wraps every workflow around that
  artifact.
- GHCR tags follow the pattern `ghcr.io/<repo>:<sha>-<run_id>`; keep that format in sync across build,
  release, and cleanup jobs.

## Image build

- [Dockerfile](Dockerfile) has `builder` and `final` stages: the builder downloads `mise` (musl)
  archive manually, while the final stage installs Alpine packages (`zsh`, `sudo`, `build-base`, etc.) that cannot be
  installed with mise.
- User `devcontaineruser` (UID 1000) in the final image, has passwordless sudo, and sources `mise activate zsh`
  through `/etc/zsh/zprofile`.

## Tooling & dependency çanagement

- [package.json](../package.json) only pins node based tools that are not installed with mise as the there is no way
  to install node packages in another tool.
- Renovate drives version bumps in all files using comments (`# renovate: datasource=...`); keep
  those hints intact when editing and add when some are missing.
- Workflows expect `just` targets named `lint`, `build`, `test`, `security-scan`, and `release`. Preserve those entry
  points (even if the Justfile is generated elsewhere) so automation does not break.

## GitHub Actions

- [pr](.github/workflows/pr.yaml) is triggered when a PR is created.
- [release](.github/workflows/release.yaml) is used when a release shall be done mirrors.

## Local development

- Always run `mise install` before executing any `just` target locally to ensure tooling is installed.
