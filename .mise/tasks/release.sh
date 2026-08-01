#!/usr/bin/env bash

#MISE description = "Publish a release"
#MISE depends = ["lint", "test", "security-scan"]
#MISE env = { GITHUB_TOKEN = { required = true, redact = true } }
#MISE env = { GITHUB_USERNAME = { required = true, redact = true } }
#MISE env = { IMAGE_NAME = "{{vars.image_name}}" }
#MISE env = { REPO_OWNER = "{{vars.repo_owner}}" }
#MISE env = { REPO_NAME = "{{vars.repo_name}}" }

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\033[31mError: this script must be run via 'mise run <task>' (not executed directly).\033[0m\n" >&2
	exit 1
fi

podman login ghcr.io -u "${GITHUB_USERNAME}" -p "${GITHUB_TOKEN}"
cog bump --auto --skip-ci
