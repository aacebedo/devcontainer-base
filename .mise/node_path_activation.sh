#!/bin/sh

set -e

NODE_PATH_VALUE=""
JQ_FILTER='to_entries | .[] | select(.key | startswith("npm:")) |
  .value[] | select(.active == true) | .install_path'
for install_path in $(mise ls -J | jq -r "$JQ_FILTER"); do
	if [ -n "$NODE_PATH_VALUE" ]; then
			NODE_PATH_VALUE="${NODE_PATH_VALUE}:${install_path}/5/node_modules"
	else
			NODE_PATH_VALUE="${install_path}/5/node_modules"
	fi
done
export NODE_PATH="${NODE_PATH_VALUE}"
