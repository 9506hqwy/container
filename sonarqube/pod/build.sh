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

if [[ ! -d ${HOST_PATH}/db ]] ; then
    echo "Create ${HOST_PATH}/db"
    exit 1
fi


export DB_USER=$(echo -n $POSTGRES_USER | base64 -w 0)
export DB_PASSWORD=$(echo -n $POSTGRES_PASSWORD | base64 -w 0)

envsubst < server.yml | podman play kube - $@
