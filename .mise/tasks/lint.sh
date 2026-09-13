#!/usr/bin/env bash

#MISE description = "Apply linters"

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\e[31mError: this script must be run via 'mise run <task>' (not executed directly).\e[0m\n" >&2
	exit 1
fi

prek run --all-files
