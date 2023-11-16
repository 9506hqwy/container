#!/bin/sh

set -eux

CONFIG="$CATALINA_HOME/webapps/draw/js/PostConfig.js"

if [ -n "${EXPORT_URL}" ] ; then
    echo "window.EXPORT_URL = '${EXPORT_URL}';" >> "${CONFIG}"
fi

if [ -n "${PLANT_URL}" ] ; then
    echo "window.PLANT_URL = '${PLANT_URL}';" >> "${CONFIG}"
    echo 'EditorUi.enablePlantUml = true;' >> "${CONFIG}"
fi
