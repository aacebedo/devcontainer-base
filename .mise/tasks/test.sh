#!/usr/bin/env sh

#MISE description = "Build and run the container image"
#MISE env = { DOCKER_TAG = "{{vars.docker_tag}}" }

set -eu
podman run --rm "$DOCKER_TAG"
