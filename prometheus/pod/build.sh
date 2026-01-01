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

if [[ ! -d ${HOST_PATH}/prometheus ]] ; then
    echo "Create ${HOST_PATH}/prometheus"
    exit 1
fi

envsubst < server.yml | podman play kube - $@
