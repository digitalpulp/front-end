#! /bin/sh

# If theme path is set and a symlink is not already present,
# create a symlink for the node modules and the bower packages into the theme.
if ! [ -n ${THEME_NAME} -a -h /var/www/docroot/themes/custom/${THEME_NAME}/node_modules ]; then
    ln -s -f /var/www/front_end/node_modules /var/www/docroot/themes/custom/${THEME_NAME}/node_modules
fi

if ! [ -n ${THEME_NAME} -a -h /var/www/docroot/themes/custom/${THEME_NAME}/bower_components ]; then
    ln -s -f /var/www/front_end/bower_components /var/www/docroot/themes/custom/${THEME_NAME}/bower_components
fi

tail -f /dev/null