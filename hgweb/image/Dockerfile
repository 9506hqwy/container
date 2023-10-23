FROM alpine:3.18

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        python3 \
        python3-dev \
        py3-pip \
        gettext \
        gettext-dev \
        build-base \
        ; \
    \
    pip install wheel; \
    \
    pip wheel mercurial; \
    pip wheel hg-evolve; \
    pip wheel Pygments; \
    pip wheel gunicorn[gevent]

FROM alpine:3.18

COPY --from=0 /*.whl /

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        python3 \
        py3-pip \
        gettext \
        ; \
    \
    mkdir /mnt/repos; \
    mkdir /opt/hgweb; \
    \
    pip install /*.whl; \
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
