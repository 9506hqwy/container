FROM alpine:3.18

RUN set -eux; \
    \
    apk add --no-cache --no-interactive \
        fcgiwrap=1.1.0-r7 \
        git-daemon=2.40.1-r0 \
        git-gitweb=2.40.1-r0 \
        highlight=4.5-r2 \
        nginx=1.24.0-r7 \
        perl-cgi=4.57-r0 \
        spawn-fcgi=1.6.5-r2 \
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
