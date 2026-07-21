#!/usr/bin/env bash

#MISE description = "Lint, test, security-scan, then publish a release"
#MISE depends = ["lint", "test", "security-scan"]
#MISE env = { GITHUB_TOKEN = { required = true, redact = true } }
#MISE env = { DOCKER_USERNAME = { required = true, redact = true } }
#MISE env = { DOCKER_PASSWORD = { required = true, redact = true } }
#MISE env = { DOCKER_TAG = "{{vars.docker_tag}}" }

set -euxo pipefail

# Export the built image (produced by `build` via `security-scan`) as a
# tarball so publisher-oci can push it to GHCR via `oras push`.
mkdir -p dist
podman save "$DOCKER_TAG" -o dist/image.tar

# Authenticate oras to GHCR for publisher-oci's `oras push`.
oras login ghcr.io -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

# Run the semrel pipeline: analyze commits, generate/commit the changelog,
# create the version tag, publish the GitHub release, and push the image
# tarball to GHCR as OCI artifacts (:<version> and :latest) via publisher-oci.
semrel release

# Clean up the exported tarball.
rm -rf dist
