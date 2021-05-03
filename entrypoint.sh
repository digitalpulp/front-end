#! /bin/sh

if [ -z ${CI_BUILD_ID} ]; then
  set -e

  WORKING_DIR=${THEME_PATH:-"/var/www/docroot/themes/custom"}

  [ "${THEME_NAME}" = "" ] && echo "Error, THEME_NAME variable not specified. Exiting front-end." && exit 1

  THEME_DIR="${WORKING_DIR}/${THEME_NAME}"

  [ ! -f "$THEME_DIR/.node-version" ] && echo "Error, .node-version file not present in theme directory ${THEME_DIR}. Exiting front-end." && exit 1

  # Execute node-build "nodenv install" command from the theme directory.
  # Pass the "-s" flag to skip installing versions that already exist in
  # the base image.
  cd ${THEME_DIR} && nodenv install -s || true

  # Keep the container present.
  tail -f /dev/null
else
  # Running in CI - just execute the given command or script.
  exec "$@"
fi
