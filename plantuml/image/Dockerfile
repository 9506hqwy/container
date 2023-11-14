FROM plantuml/plantuml-server:jetty-v1.2023.12

ARG PORT=8080

COPY setup.sh /setup.sh

USER root
RUN set -eux; \
    echo '--module=http-forwarded' > './start.d/http-forwarded.ini'; \
    sed /entrypoint.sh -i -e 1a"/bin/sh /setup.sh"
USER jetty

ENV PORT=${PORT}

EXPOSE ${PORT}
