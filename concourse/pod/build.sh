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

if [[ -z ${POSTGRES_USER} ]] ; then
    echo 'Specify DB username to $POSTGRES_USER'
    exit 1
fi

if [[ -z ${POSTGRES_PASSWORD} ]] ; then
    echo 'Specify DB password to $POSTGRES_PASSWORD'
    exit 1
fi

if [[ -z ${EXTERNAL_URL} ]] ; then
    echo 'Specify external URL to $EXTERNAL_URL'
    exit 1
fi


if [[ -z ${ADMIN_PASSWORD} ]] ; then
    echo 'Specify admin password to $ADMIN_PASSWORD'
    exit 1
fi

export SESSION_KEY=$(cat session_signing_key | base64 -w 0)

export TSA_PRIVATE_KEY=$(cat tsa_host_key | base64 -w 0)
export TSA_PUBLIC_KEY=$(cat tsa_host_key.pub | base64 -w 0)

export WORKER_PRIVATE_KEY=$(cat worker_key | base64 -w 0)
export WORKER_PUBLIC_KEY=$(cat worker_key.pub | base64 -w 0)

export DB_USER=$(echo -n $POSTGRES_USER | base64 -w 0)
export DB_PASSWORD=$(echo -n $POSTGRES_PASSWORD | base64 -w 0)

export EXTERNAL_URL

export ADMIN=$(echo -n "admin:$ADMIN_PASSWORD" | base64 -w 0)

envsubst < server.yml | podman play kube - $@
