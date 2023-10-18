#!/bin/bash

set -eux

case "$1" in
    mysql)
        if [[ -z ${MYSQL_USER} ]] ; then
            echo 'Specify DB username to $MYSQL_USER'
        fi

        if [[ -z ${MYSQL_PASSWORD} ]] ; then
            echo 'Specify DB password to $MYSQL_PASSWORD'
        fi

        export DB_USER=$(echo -n $MYSQL_USER | base64 -w 0)
        export DB_PASSWORD=$(echo -n $MYSQL_PASSWORD | base64 -w 0)
        ;;

    sqlite)
        ;;

    *)
        echo 'Specify database [mysql/sqlite]'
        exit 1
        ;;
esac

DATABASE=$1
shift

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

export DB_CIPHER_KEY=$(cat /dev/random | fold -w 12 | base64 | head -n 1)

envsubst < ${DATABASE}.yml | podman play kube - $@
