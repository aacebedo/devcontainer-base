# devcontainer-base

Alpine-based Docker image serving as a foundation for development containers

## Features

- **Alpine Linux base** with essential build tools (`build-base`, `zsh`, `sudo`)
- **Non-root user** (`devcontaineruser`, UID 1000) with passwordless sudo
- **mise** pre-installed with automatic shell activation

## Using the image

Pull the latest image from GitHub Container Registry:

```bash
docker pull ghcr.io/aacebedo/devcontainer-base:latest
```

Run interactively:

```bash
docker run --rm -it ghcr.io/aacebedo/devcontainer-base:latest
```

## Image structure

Multi-stage build:

1. **builder** stage: Downloads mise binary (musl-linked)
2. **final** stage: Installs Alpine packages, creates non-root user, configures zsh with mise activation

User `devcontaineruser` sources mise via `/etc/zsh/zshrc`, making all installed tools immediately available.

## Development

This project uses [mise](https://mise.jdx.dev) to manage tool versions and tasks, and [prek](https://prek.j178.dev) for
git hooks.

```bash
mise tasks                  # list all available tasks
mise run lint               # run all linters via prek
mise run format             # format the repository
mise run container:build    # build the container image
mise run test               # build the image and smoke test it
mise run update-deps        # diff pinned dependency updates (add --apply to open PRs)
mise run release            # bump the version with cog and publish a GitHub release
```

### Using the devcontainer

Open this project in VS Code and "Reopen in Container" to get a fully configured environment.
