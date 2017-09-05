#! /bin/sh

# If theme name is set and a symlink is not already present,
# create a symlink for the node modules.
if ! [ -n ${THEME_NAME} -a -h /var/www/docroot/themes/custom/${THEME_NAME}/node_modules ]; then
    ln -s -f /var/www/front_end/node_modules /var/www/docroot/themes/custom/${THEME_NAME}/node_modules
fi
# Keep the container present.
tail -f /dev/null
