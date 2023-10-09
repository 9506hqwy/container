#!/bin/sh

set -eux

# Change permission by using startup script
# because of podman 4.4 does not support `defaultMode`.
chmod 0600 /etc/ssh/ssh_host_ed25519_key

chown ${SSH_USER_NAME} /home/${SSH_USER_NAME}/.ssh/*
chgrp ${SSH_USER_NAME} /home/${SSH_USER_NAME}/.ssh/*
chmod 0600 /home/${SSH_USER_NAME}/.ssh/*

/usr/sbin/sshd -D
