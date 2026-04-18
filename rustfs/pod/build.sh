#!/bin/bash

set -eux

if [[ ! -d ${HOST_PATH} ]] ; then
    echo 'Specify directory to $HOST_PATH'
    exit 1
fi

if [[ ! -d ${HOST_PATH}/data ]] ; then
    echo "Create ${HOST_PATH}/data"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/logs ]] ; then
    echo "Create ${HOST_PATH}/logs"
    exit 1
fi

if [[ -z ${RUSTFS_ACCESS_KEY} ]] ; then
    echo 'Specify access key to $RUSTFS_ACCESS_KEY'
fi

if [[ -z ${RUSTFS_SECRET_KEY} ]] ; then
    echo 'Specify secert key to $RUSTFS_SECRET_KEY'
fi

export RUSTFS_ACCESS_KEY=$(echo -n $RUSTFS_ACCESS_KEY | base64 -w 0)
export RUSTFS_SECRET_KEY=$(echo -n $RUSTFS_SECRET_KEY | base64 -w 0)

envsubst < server.yml | podman play kube - $@
