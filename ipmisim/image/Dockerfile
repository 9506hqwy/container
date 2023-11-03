FROM python:3.9-alpine3.18 as build

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        build-base=0.5-r3 \
        ; \
    \
    pip install --no-cache-dir wheel==0.41.2; \
    \
    pip wheel ipmisim==0.10

FROM python:3.9-alpine3.18

COPY --from=build /*.whl /

RUN set -eux; \
    \
    pip install --no-cache-dir /*.whl; \
    \
    rm -f /*.whl

EXPOSE 9001

CMD ["ipmisim"]
