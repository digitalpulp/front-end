#! /bin/sh

WORKING_DIR="/var/www/docroot/themes/custom"
if [ -n ${THEME_PATH} ]; then
    WORKING_DIR=${THEME_PATH}
fi
# If theme name is set, make sure we are in that directory.
if [ -n ${THEME_NAME} ]; then
  cd ${WORKING_DIR}/${THEME_NAME}
fi
# If theme name is set and a package.json is present,
# build the node modules.
if [ -n ${THEME_NAME} -a -r ${WORKING_DIR}/${THEME_NAME}/package.json ]; then
    touch BUILDING.txt
    npm install
fi
# compile the theme.
if [ -n ${THEME_NAME} -a -r ${WORKING_DIR}/${THEME_NAME}/gulpfile.js ]; then
    touch COMPILING.txt
    node_modules/.bin/gulp build
    touch INITIALIZED.txt
elif [ -n ${THEME_NAME} -a -r ${WORKING_DIR}/${THEME_NAME}/Gruntfile.js ]; then
    touch COMPILING.txt
    export GRUNT_TARGET=dist
    node_modules/.bin/grunt build
    touch INITIALIZED.txt
fi
# Keep the container present if not in a CI, otherwise exit.
if [ -z ${CI_BUILD_ID} ]; then
  tail -f /dev/null
fi
