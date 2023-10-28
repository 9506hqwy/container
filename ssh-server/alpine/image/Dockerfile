FROM alpine:3.18

ARG SSH_USER=dev

RUN set -eux; \
    SSHD_CONFIG=/etc/ssh/sshd_config; \
    SSH_USER_CONFIG=/home/${SSH_USER}/.ssh; \
    \
    apk add --no-cache --no-interactive openssh-server=9.3_p2-r0; \
    \
    sed -i -e 's%^#\(HostKey /etc/ssh/ssh_host_ed25519_key\)%\1%' "${SSHD_CONFIG}"; \
    sed -i -e 's%^#\(StrictModes yes\)%\1%' "${SSHD_CONFIG}"; \
    sed -i -e 's%^#\(PubkeyAuthentication yes\)%\1%' "${SSHD_CONFIG}"; \
    sed -i -e 's%^#\(PasswordAuthentication\) yes%\1 no%' "${SSHD_CONFIG}"; \
    sed -i -e 's%^#\(KbdInteractiveAuthentication\) yes%\1 no%' "${SSHD_CONFIG}"; \
    \
    PASSWORD=$(fold -w 12 < /dev/random | base64 | head -n 1); \
    echo "root:${PASSWORD}" | chpasswd; \
    \
    adduser -D ${SSH_USER}; \
    PASSWORD=$(fold -w 12 < /dev/random | base64 | head -n 1); \
    echo "${SSH_USER}:${PASSWORD}" | chpasswd; \
    \
    mkdir ${SSH_USER_CONFIG}; \
    chown ${SSH_USER} ${SSH_USER_CONFIG}; \
    chgrp ${SSH_USER} ${SSH_USER_CONFIG}; \
    chmod 700 ${SSH_USER_CONFIG}

COPY ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub
COPY ${SSH_USER}_ed25519_key.pub /home/${SSH_USER}/.ssh/authorized_keys

COPY run.sh /run.sh
RUN chmod 700 /run.sh

ENV SSH_USER_NAME=${SSH_USER}

EXPOSE 22

ENTRYPOINT ["/run.sh"]
