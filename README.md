# devcontainer-base

Alpine-based Docker image serving as a foundation for development containers. Built with [mise](https://mise.jdx.dev/)
for tooling management and automated via GitHub Actions.

## Features

- **Alpine Linux base** with essential build tools (`build-base`, `zsh`, `sudo`)
- **Non-root user** (`devcontaineruser`, UID 1000) with passwordless sudo
- **mise** pre-installed with automatic shell activation

## Quick start

### Using the image

Pull the latest image from GitHub Container Registry:

```bash
docker pull ghcr.io/aacebedo/devcontainer-base:latest
```

Run interactively:

```bash
docker run --rm -it ghcr.io/aacebedo/devcontainer-base:latest
```

### Local development

#### Install tooling

```bash
mise install
```

#### Build the image

```bash
just build
```

#### Run tests

```bash
just test
```

#### Run all quality checks

```bash
just lint
just security-scan
```

## Image structure

Multi-stage build:

1. **builder** stage: Downloads mise binary (musl-linked)
2. **final** stage: Installs Alpine packages, creates non-root user, configures zsh with mise activation

User `devcontaineruser` sources mise via `/etc/zsh/zprofile`, making all installed tools immediately available.

## Pre-commit Hooks

Install hooks locally:

```bash
pre-commit install
```

## License

MIT
