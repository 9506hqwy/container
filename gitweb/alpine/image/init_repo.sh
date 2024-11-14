#!/bin/bash

set -eux

git init --bare "$1"
pushd "$1"

git update-server-info

cat <<EOF >> config
[http]
        receivepack = true
EOF

mv hooks/post-update.sample hooks/post-update

popd
