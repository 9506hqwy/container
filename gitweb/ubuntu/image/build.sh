#!/bin/bash
set -euo pipefail
pushd /src

apt update

apt install -y \
    fcgiwrap \
    gitweb \
    highlight \
    nginx \
    spawn-fcgi

apt clean
rm -rf /var/lib/apt/lists/*

mkdir /mnt/repos
mkdir /opt/gitweb

chown -R www-data:www-data /usr/share/gitweb
chown -R www-data:www-data /mnt/repos

cp gitweb.conf /etc/nginx/conf.d
rm -f /etc/nginx/sites-enabled/default

cp gitweb.pl /opt/gitweb
chmod +x /opt/gitweb/gitweb.pl

cp init_repo.sh /usr/local/bin
chmod +x /usr/local/bin/init_repo.sh

cp start.sh /opt/gitweb
chmod +x /opt/gitweb/start.sh
