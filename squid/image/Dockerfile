FROM redhat/ubi10-minimal:10.1-1764604111

RUN set -eux; \
    \
    microdnf install -y squid --setopt install_weak_deps=0; \
    \
    microdnf clean all

ENTRYPOINT ["/usr/sbin/squid"]
CMD ["-N"]
