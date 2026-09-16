#!/usr/bin/env bash

#MISE description = "Remove generated Vale configuration files"

set -euo pipefail

if [ -z "${MISE_TASK_NAME:-}" ]; then
	printf "\e[31mError: this script must be run via 'mise run <task>' (not executed directly).\e[0m\n" >&2
	exit 1
fi

rm -rf .vale/.vale-config .vale/Google
rm -rf .rumdl_cache
