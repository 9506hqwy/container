#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os.path
from mercurial.hgweb import hgweb


dir = os.path.dirname(__file__)
web = hgweb(os.path.join(dir, "hgweb.config").encode())


def app(environ, start_response):
    environ['REMOTE_USER'] = environ.get('HTTP_REMOTE_USER')
    return web(environ, start_response)
