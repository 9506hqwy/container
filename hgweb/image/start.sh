#!/bin/sh

gunicorn \
    --bind 0.0.0.0:${PORT} \
    --timeout 600 \
    --preload \
    --access-logfile /dev/stdout \
    --error-logfile /dev/stderr \
    --log-level debug \
    --pythonpath $(dirname $0) \
    --workers 4 \
    --worker-class gevent application:app
