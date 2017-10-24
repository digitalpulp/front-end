#! /bin/sh

# If theme name is set and a package.json is present,
# build the node modules.
if [ -n ${THEME_NAME} -a -r /var/www/docroot/themes/custom/${THEME_NAME}/package.json ]; then
    npm install
fi
# compile the theme.
if [ -n ${THEME_NAME} -a -r /var/www/docroot/themes/custom/${THEME_NAME}/gulpfile.js ]; then
    if node_modules/.bin/gulp build ; then
      touch COMPILED.txt
    fi
fi
# Keep the container present.
tail -f /dev/null
