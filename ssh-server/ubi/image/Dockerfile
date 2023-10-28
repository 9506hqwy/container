FROM redhat/ubi8:8.8-1067.1698056881

ARG SSH_USER=dev

RUN set -eux; \
    SSHD_CONFIG=/etc/ssh/sshd_config; \
    SSH_USER_CONFIG=/home/${SSH_USER}/.ssh; \
    \
    dnf install --disableplugin=subscription-manager -y openssh-server; \
    dnf clean all; \
    \
    sed "${SSHD_CONFIG}" -i -e 's%^\(HostKey /etc/ssh/ssh_host_rsa_key\)%#\1%'; \
    sed "${SSHD_CONFIG}" -i -e 's%^\(HostKey /etc/ssh/ssh_host_ecdsa_key\)%#\1%'; \
    sed "${SSHD_CONFIG}" -i -e 's%^\(PermitRootLogin\) yes%\1 no%'; \
    sed "${SSHD_CONFIG}" -i -e 's%^\(PasswordAuthentication\) yes%\1 no%'; \
    sed "${SSHD_CONFIG}" -i -e 's%^\(KbdInteractiveAuthentication\) yes%\1 no%'; \
    sed "${SSHD_CONFIG}" -i -e 's%^\(GSSAPIAuthentication\) yes%\1 no%'; \
    \
    # https://stackoverflow.com/questions/21391142/why-is-it-needed-to-set-pam-loginuid-to-its-optional-value-with-docker
    # or `--privileged` option
    sed '/etc/pam.d/sshd' -i -e 's%session\s\+required\s\+pam_loginuid.so%session optional pam_loginuid.so%'; \
    touch /var/log/lastlog; \
    \
    PASSWORD=$(fold -w 12 < /dev/random | base64 | head -n 1); \
    echo "root:${PASSWORD}" | chpasswd; \
    \
    useradd -m ${SSH_USER}; \
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
