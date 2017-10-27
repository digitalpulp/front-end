#! /bin/sh

# If theme name is set and a package.json is present,
# build the node modules.
if [ -n ${THEME_NAME} -a -r /var/www/docroot/themes/custom/${THEME_NAME}/package.json ]; then
    touch BUILDING.txt
    npm install
fi
# compile the theme.
if [ -n ${THEME_NAME} -a -r /var/www/docroot/themes/custom/${THEME_NAME}/gulpfile.js ]; then
    touch COMPILING.TXT
    node_modules/.bin/gulp build
    touch INITIALIZED.txt
fi
# Keep the container present.
tail -f /dev/null
