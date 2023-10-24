FROM alpine:3.18

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        fcgiwrap \
        git-daemon \
        git-gitweb \
        highlight \
        nginx \
        perl-cgi \
        spawn-fcgi \
        ; \
    \
    mkdir /mnt/repos; \
    mkdir /opt/gitweb; \
    \
    chown -R nginx:www-data /usr/share/gitweb; \
    chown -R nginx:www-data /mnt/repos; \
    chmod +x /usr/share/gitweb/gitweb.cgi; \
    \
    rm -rf /etc/nginx/http.d/*

COPY gitweb.conf /etc/nginx/http.d
COPY gitweb.pl /opt/gitweb
COPY start.sh /opt/gitweb

RUN chmod +x /opt/gitweb/gitweb.pl; \
    chmod +x /opt/gitweb/start.sh

EXPOSE 80

VOLUME /mnt/repos

CMD ["/opt/gitweb/start.sh"]
