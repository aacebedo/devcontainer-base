#!/usr/bin/env sh

#MISE description = "Run Trivy security scan on the built image"
#MISE depends = ["build"]
#MISE env = { DOCKER_TAG = "{{vars.docker_tag}}" }

set -eu
TEMP_DIR=$(mktemp -d)
podman save "$DOCKER_TAG" | gzip >"$TEMP_DIR/image.tar.gz"
trivy image --input "$TEMP_DIR/image.tar.gz" --format sarif \
	--skip-version-check --output /tmp/trivy-results.sarif
rm -rf "$TEMP_DIR"
