#!/bin/bash

WORK_DIR=$(dirname $0)
FILES=$(find ${WORK_DIR} -name 'Dockerfile')

for FILE in ${FILES}
do
    echo "----- ${FILE} -----"
    podman run --rm -i hadolint/hadolint hadolint --ignore DL4006 - < "${FILE}"
    # DL4006: WARN[0007] SHELL is not supported for OCI image format.
done
