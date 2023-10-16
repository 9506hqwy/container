#!/bin/bash

set -eux

export SSH_USER_NAME=$(podman image inspect ssh:ubi | grep '"SSH_USER_NAME=' | cut -d '=' -f 2 | tr -d '"')

export HOST_PRIVATE_KEY=$(cat ssh_host_ed25519_key | base64 -w 0)
export HOST_PUBLIC_KEY=$(cat ssh_host_ed25519_key.pub | base64 -w 0)

export USER_PRIVATE_KEY=$(cat ${SSH_USER_NAME}_ed25519_key.pub | base64 -w 0)

envsubst < server.yml | podman play kube - $@
