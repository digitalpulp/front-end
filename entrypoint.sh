#! /bin/sh

# If theme name is set and a symlink is not already present,
# create a symlink for the node modules.
if ! [ -n ${THEME_NAME} -a -h /var/www/docroot/themes/custom/${THEME_NAME}/node_modules ]; then
    ln -s -f /var/www/front_end/node_modules /var/www/docroot/themes/custom/${THEME_NAME}/node_modules
fi
# If the theme path is set, force copy the bower_components into the theme.
# Unlike the node_modules that are only used in compilation, the bower_components
# need to be deployed with the site.
if [ -n ${THEME_NAME} -a -d /var/www/docroot/themes/custom/${THEME_NAME} -a -d /var/www/front_end/bower_components ]; then
    mv -f /var/www/front_end/bower_components /var/www/docroot/themes/custom/${THEME_NAME}/bower_components
fi

tail -f /dev/null