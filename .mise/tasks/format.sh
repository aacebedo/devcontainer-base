#!/usr/bin/env bash

#MISE description = "Format all code in the repository"

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\e[31mError: this script must be run via 'mise run <task>' (not executed directly).\e[0m\n" >&2
	exit 1
fi

dprint fmt
shfmt --write .
