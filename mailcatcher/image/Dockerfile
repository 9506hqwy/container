FROM ruby:3.4

RUN set -eux; \
    \
    apt-get update; \
    \
    gem install mailcatcher

EXPOSE 1025
EXPOSE 1080

CMD ["mailcatcher", "--ip", "0.0.0.0", "--foreground", "--verbose"]
