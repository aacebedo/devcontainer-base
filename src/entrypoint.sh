#!/bin/sh
set -eu

# Without a terminal or piped input (e.g. a devcontainer with overrideCommand=false,
# or a detached `docker run`), the default login shell would read EOF and exit,
# stopping the container. Keep it alive instead so tools can exec into it.
if [ "$*" = "/bin/zsh -l" ] && [ ! -t 0 ] && [ ! -p /dev/stdin ]; then
	exec sleep infinity
fi

exec "$@"
