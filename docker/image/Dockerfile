FROM redhat/ubi9-init:9.4-14

RUN set -eux; \
    \
    sed -i /etc/dnf/plugins/subscription-manager.conf -e 's/^enabled=1/enabled=0/'; \
    \
    dnf update -y; \
    \
    dnf install -y yum-utils; \
    \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo; \
    \
    dnf install -y \
        docker-ce \
        docker-ce-cli \
        containerd.io \
        docker-buildx-plugin \
        docker-compose-plugin; \
    \
    dnf remove -y yum-utils; \
    dnf clean all; \
    \
    systemctl enable docker
