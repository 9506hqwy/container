#!/bin/sh

spawn-fcgi -U www-data -G www-data -s /var/run/fcgiwrap.sock /usr/sbin/fcgiwrap
nginx -g "daemon off;"
