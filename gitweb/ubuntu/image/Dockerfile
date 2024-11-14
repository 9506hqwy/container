FROM ubuntu:24.10

RUN --mount=type=bind,target=/src,Z \
    bash /src/build.sh

EXPOSE 80

VOLUME /mnt/repos

CMD ["/opt/gitweb/start.sh"]