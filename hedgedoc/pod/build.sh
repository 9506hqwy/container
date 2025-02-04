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

if [[ -z ${POSTGRES_USER} ]] ; then
    echo 'Specify DB username to $POSTGRES_USER'
    exit 1
fi

if [[ -z ${POSTGRES_PASSWORD} ]] ; then
    echo 'Specify DB password to $POSTGRES_PASSWORD'
    exit 1
fi

export DB_USER=$(echo -n $POSTGRES_USER | base64 -w 0)
export DB_PASSWORD=$(echo -n $POSTGRES_PASSWORD | base64 -w 0)
export CMD_DB_URL=$(echo -n "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@127.0.0.1/hedgedoc" | base64 -w 0)

envsubst < server.yml '$HOST_PATH $DB_USER $DB_PASSWORD $CMD_DB_URL' | podman play kube - $@
