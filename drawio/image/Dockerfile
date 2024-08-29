FROM jgraph/drawio:24.7.8

ARG BASE_URL=/
ARG PORT=8080

COPY setup_server.sh /setup_server.sh
COPY setup_postconfig.sh /setup_postconfig.sh

USER root
RUN set -eux; \
    \
    sed /docker-entrypoint.sh -i -e 1a'/bin/sh /setup_server.sh'; \
    \
    LAST_POSTCONFIG=$(grep -n '^cat .*/PostConfig.js$' '/docker-entrypoint.sh' | cut -d ':' -f 1); \
    sed /docker-entrypoint.sh -i -e "${LAST_POSTCONFIG}i"'/bin/sh /setup_postconfig.sh'
USER tomcat

ENV BASE_URL=${BASE_URL}
ENV PORT=${PORT}

EXPOSE ${PORT}
