#!/bin/bash

set -eux

if [[ ! -d ${HOST_PATH} ]] ; then
    echo 'Specify directory to $HOST_PATH'
    exit 1
fi

envsubst < server.yml | podman play kube - $@

cat <<EOF
# To connect to the AWS emulator, set the following environment variables in your shell.
# see https://docs.aws.amazon.com/emulator/latest/userguide/point-sdk-to-emulator.html.
export AWS_ENDPOINT_URL=https://127.0.0.1:9297
export AWS_SHARED_CREDENTIALS_FILE=${HOST_PATH}/9297/emulator_credentials
export AWS_CONFIG_FILE=${HOST_PATH}/9297/config
export AWS_CA_BUNDLE=${HOST_PATH}/9297/ca.pem
export AWS_EC2_METADATA_DISABLED=true
export AWS_DISABLE_HOST_PREFIX_INJECTION=true
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1
EOF
