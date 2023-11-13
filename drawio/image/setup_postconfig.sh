#!/bin/sh

set -eux

CONFIG="$CATALINA_HOME/webapps/draw/js/PostConfig.js"

if [ -n "${PLANT_URL}" ] ; then
    echo "window.PLANT_URL = '${PLANT_URL}';" >> "${CONFIG}"
    echo 'EditorUi.enablePlantUml = true;' >> "${CONFIG}"
fi
