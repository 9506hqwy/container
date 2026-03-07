#!/bin/bash

set -eux

if [[ ! -d ${HOST_PATH} ]] ; then
    echo 'Specify directory to $HOST_PATH'
    exit 1
fi

if [[ ! -d ${HOST_PATH}/grafana ]] ; then
    echo "Create ${HOST_PATH}/grafana"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/tempo ]] ; then
    echo "Create ${HOST_PATH}/tempo"
    exit 1
fi

envsubst < server.yml | podman play kube - $@
