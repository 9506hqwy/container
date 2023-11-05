#!/bin/bash

# セッションのキーを生成
podman run --rm -v $(pwd):/keys:Z concourse/concourse:7.11 \
    generate-key -t rsa -f /keys/session_signing_key

# TSA ホストのキーペアを生成
podman run --rm -v $(pwd):/keys:Z concourse/concourse:7.11 \
    generate-key -t ssh -f /keys/tsa_host_key

# worker のキーペアを生成
podman run --rm -v $(pwd):/keys:Z concourse/concourse:7.11 \
    generate-key -t ssh -f /keys/worker_key
