#!/usr/bin/env bash
chmod +r "$1"
exec gosu "${DEVCONTAINER_USERNAME}" zsh -l -e "$1"
