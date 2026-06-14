FROM almalinux/9-init:9.8

RUN --mount=type=bind,target=/src,Z \
    bash /src/build.sh

EXPOSE 389/tcp 636/tcp
