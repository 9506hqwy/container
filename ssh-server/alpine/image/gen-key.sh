#!/bin/bash

# クライアントのキーペアを生成
ssh-keygen -t ed25519 -f dev_ed25519_key -C "" -N ""

# サーバのキーペアを生成
ssh-keygen -t ed25519 -f ssh_host_ed25519_key -C "" -N ""
