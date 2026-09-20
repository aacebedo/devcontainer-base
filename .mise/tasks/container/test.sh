#!/usr/bin/env bash

#MISE description = "Smoke test the built container image"
#MISE depends = ["container:build"]
#MISE env.COMMIT_SHA = "{{vars.commit_sha}}"

set -euo pipefail

podman run --rm "${IMAGE_NAME}:${COMMIT_SHA}" /bin/zsh -lc "true"
