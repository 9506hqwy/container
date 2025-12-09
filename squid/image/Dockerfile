FROM redhat/ubi10-init:10.1-1763368398

RUN set -eux; \
    \
    sed -i /etc/dnf/plugins/subscription-manager.conf -e 's/^enabled=1/enabled=0/'; \
    \
    dnf update -y; \
    dnf install -y squid; \
    \
    dnf clean all; \
    \
    systemctl enable squid
