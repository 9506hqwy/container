#!/bin/sh

set -eux

sed /usr/local/jetty/etc/jetty-http.xml -i -e "s/8080/${PORT}/"
