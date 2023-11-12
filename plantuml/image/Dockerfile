FROM plantuml/plantuml-server:jetty-v1.2023.12

ARG PORT=8080

COPY setup.sh /setup.sh

USER root
RUN sed /entrypoint.sh -i -e 1a"/bin/sh /setup.sh"
USER jetty

ENV PORT=${PORT}

EXPOSE ${PORT}
