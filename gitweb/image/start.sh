#!/bin/sh

spawn-fcgi -U nginx -G www-data -s /var/run/fcgiwrap.sock /usr/bin/fcgiwrap
nginx -g "daemon off;"
