#!/bin/sh

set -eux

sed /usr/local/tomcat/conf/server.xml -i -e "s%path=\"/\"%path=\"${BASE_URL}\"%"
sed /usr/local/tomcat/conf/server.xml -i -e "s/8080/${PORT}/"
