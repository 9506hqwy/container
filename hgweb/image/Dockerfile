FROM alpine:3.18 as build

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        python3=3.11.6-r0 \
        python3-dev=3.11.6-r0 \
        py3-pip=23.1.2-r0 \
        gettext=0.21.1-r7 \
        gettext-dev=0.21.1-r7 \
        build-base=0.5-r3 \
        ; \
    \
    pip install --no-cache-dir wheel==0.41.2; \
    \
    pip wheel mercurial==6.5.2; \
    pip wheel hg-evolve==11.1.0; \
    pip wheel Pygments==2.16.1; \
    pip wheel 'gunicorn[gevent]==21.2.0'

FROM alpine:3.18

COPY --from=build /*.whl /

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        python3=3.11.6-r0 \
        py3-pip=23.1.2-r0 \
        gettext=0.21.1-r7 \
        ; \
    \
    mkdir /mnt/repos; \
    mkdir /opt/hgweb; \
    \
    pip install --no-cache-dir /*.whl; \
    \
    rm -f /*.whl

COPY application.py /opt/hgweb
COPY hgweb.config /opt/hgweb
COPY start.sh /opt/hgweb

RUN chmod +x /opt/hgweb/start.sh

EXPOSE 80

ENV LANG=ja_JP.UTF-8
ENV PORT=80

VOLUME /mnt/repos

CMD ["/opt/hgweb/start.sh"]
