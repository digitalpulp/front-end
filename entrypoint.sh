#! /bin/sh

set -e

WORKING_DIR=${THEME_PATH:-"/var/www/docroot/themes/custom"}

[ "${THEME_NAME}" = "" ] && echo "Error, THEME_NAME variable not specified" && exit 1

THEME_DIR = "${WORKING_DIR}/${THEME_NAME}"

[ ! -d "$THEME_DIR" ] && mkdir -p "$THEME_DIR"

# Execute node-build "nodenv install" command from the theme directory.
cd ${THEME_DIR} && nodenv install

# Keep the container present if not in a CI, otherwise exit.
if [ -z ${CI_BUILD_ID} ]; then
  tail -f /dev/null
fi
