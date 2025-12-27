#!/bin/sh

set -e

if [ "$__NODE_PATH_VAR_LOADED" = 1 ]; then
	unset __NODE_PATH_VAR_LOADED
	return 0 2>/dev/null
fi

export __NODE_PATH_VAR_LOADED=1

JQ_FILTER='to_entries | .[] | select(.key | startswith("npm:")) |
.value[] | select(.active == true) | .install_path'

NODE_PATH_VALUE=""
for install_path in $(mise ls -J | jq -r "$JQ_FILTER"); do
	if [ -n "$NODE_PATH_VALUE" ]; then
		NODE_PATH_VALUE="${NODE_PATH_VALUE}:${install_path}/5/node_modules"
	else
		NODE_PATH_VALUE="${install_path}/5/node_modules"
	fi
done
export NODE_PATH="${NODE_PATH_VALUE}"
