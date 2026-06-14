#!/bin/bash
set -euo pipefail
pushd /src

dnf update -y

dnf install -y epel-release
dnf install -y \
    openldap-clients \
    openldap-servers

dnf clean all

systemctl enable slapd
