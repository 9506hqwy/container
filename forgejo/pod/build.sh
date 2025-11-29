#!/bin/bash

set -eux

if [[ -z ${DOMAIN} ]] ; then
    echo 'Specify domain to $DOMAIN'
fi

if [[ -z ${FQDN} ]] ; then
    echo 'Specify FQDN or IP address to $FQDN'
fi

if [[ -z ${POSTGRES_USER} ]] ; then
    echo 'Specify DB username to $POSTGRES_USER'
fi

if [[ -z ${POSTGRES_PASSWORD} ]] ; then
    echo 'Specify DB password to $POSTGRES_PASSWORD'
fi

export DB_USER=$(echo -n $POSTGRES_USER | base64 -w 0)
export DB_PASSWORD=$(echo -n $POSTGRES_PASSWORD | base64 -w 0)

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

envsubst < server.yml | podman play kube - $@
