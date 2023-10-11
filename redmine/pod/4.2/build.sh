#!/bin/bash

set -eux

if [[ ! -d ${HOST_PATH} ]] ; then
    echo 'Specify directory to $HOST_PATH'
    exit 1
fi

if [[ ! -d ${HOST_PATH}/db ]] ; then
    echo "Create ${HOST_PATH}/db"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/files ]] ; then
    echo "Create ${HOST_PATH}/files"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/log ]] ; then
    echo "Create ${HOST_PATH}/log"
    exit 1
fi

if [[ ! -d ${HOST_PATH}/plugins ]] ; then
    echo "Create ${HOST_PATH}/plugins"
    exit 1
fi

if [[ -z ${POSTGRES_USER} ]] ; then
    echo 'Specify DB username to $POSTGRES_USER'
fi

if [[ -z ${POSTGRES_PASSWORD} ]] ; then
    echo 'Specify DB password to $POSTGRES_PASSWORD'
fi

export DB_USER=$(echo -n $POSTGRES_USER | base64 -w 0)
export DB_PASSWORD=$(echo -n $POSTGRES_PASSWORD | base64 -w 0)

export DB_CIPHER_KEY=$(cat /dev/random | fold -w 12 | base64 | head -n 1)

envsubst < postgresql.yml | podman play kube - $@
