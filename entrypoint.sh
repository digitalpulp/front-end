#! /bin/sh

set -e

WORKING_DIR=${THEME_PATH:-"/var/www/docroot/themes/custom"}

[ "${THEME_NAME}" = "" ] && echo "Error, THEME_NAME variable not specified. Exiting front-end." && exit 1

THEME_DIR="${WORKING_DIR}/${THEME_NAME}"

[ ! -d "$THEME_DIR" ] && mkdir -p "$THEME_DIR"

# Execute node-build "nodenv install" command from the theme directory.
# Pass the "-s" flag to skip installing versions that already exist in 
# the base image.
cd ${THEME_DIR} && nodenv install -s || true

# Keep the container present if not in a CI, otherwise exit.
if [ -z ${CI_BUILD_ID} ]; then
  tail -f /dev/null
fi
