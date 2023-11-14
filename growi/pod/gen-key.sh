#!/bin/bash

# パスワードのシードを生成
openssl rand -hex 24 > password_seed

# シークレットのトークンを生成
openssl rand -hex 24 > secret_token
