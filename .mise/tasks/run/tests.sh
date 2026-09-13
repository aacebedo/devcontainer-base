#!/usr/bin/env bash

#MISE description = "Build and run the container image"

#MISE depends = ["build"]

#MISE env = { IMAGE_NAME = "{{vars.image_name}}" }
#MISE env = { COMMIT_SHA = "{{vars.commit_sha}}" }

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\e[31mError: this script must be run via 'mise run <task>' (not executed directly).\e[0m\n" >&2
	exit 1
fi

podman run --rm "${IMAGE_NAME}:${COMMIT_SHA}"
