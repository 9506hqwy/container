FROM rust:1.74.0 as build

WORKDIR /tmp/hello-world

RUN set -eux; \
    \
    rustup target add x86_64-unknown-linux-musl; \
    \
    cargo init; \
    cargo build --release --target=x86_64-unknown-linux-musl

FROM gcr.io/distroless/static-debian12:latest

COPY --from=build /tmp/hello-world/target/x86_64-unknown-linux-musl/release/hello-world /

ENTRYPOINT ["/hello-world"]
