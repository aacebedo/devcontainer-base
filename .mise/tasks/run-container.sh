#!/usr/bin/env bash

#MISE description = "Start an interactive container from the built image"
#MISE interactive = true
#MISE quiet = true

#MISE depends = ["build"]

#MISE env = { IMAGE_NAME = "{{vars.image_name}}" }
#MISE env = { COMMIT_SHA = "{{vars.commit_sha}}" }

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\033[31mError: this script must be run via 'mise run <task>' (not executed directly).\033[0m\n" >&2
	exit 1
fi

podman run -it --rm --privileged "${IMAGE_NAME}:${COMMIT_SHA}" "$@"
