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

if [[ ! -d ${HOST_PATH}/configdb ]] ; then
    echo "Create ${HOST_PATH}/configdb"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/index ]] ; then
    echo "Create ${HOST_PATH}/index"
    exit 1
fi

if [[ -z ${EXTERNAL_HOST} ]] ; then
    echo 'Specify external URL to $EXTERNAL_HOST'
    exit 1
fi

export PASSWORD_SEED=$(cat password_seed | base64 -w 0)
export SECRET_TOKEN=$(cat secret_token | base64 -w 0)

export EXTERNAL_HOST

envsubst '$HOST_PATH $PASSWORD_SEED $SECRET_TOKEN $EXTERNAL_HOST' < server.yml | podman play kube - $@
