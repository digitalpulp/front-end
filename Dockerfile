FROM node:10.23-alpine AS node10

FROM node:12.20-alpine

LABEL maintainer="digitalpulp"

COPY entrypoint.sh /usr/local/bin/

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV NODENV_ROOT /opt/nodenv
ENV PATH "$NODENV_ROOT/shims:$NODENV_ROOT/bin:$PATH"

# Install and setup nodenv
# @see https://github.com/conchoid/docker-nodenv/blob/master/12.18.3-stretch/Dockerfile
# @see https://github.com/conchoid/docker-nodenv/blob/master/8.14.0-alpine3.8/Dockerfile
RUN apk add --no-cache curl python git bash build-base binutils-gold linux-headers openssl openssl-dev python2-dev libtool automake autoconf nasm zlib-dev zlib \
&& nodenv_version="v1.4.0" \
&& git clone https://github.com/nodenv/nodenv.git ${NODENV_ROOT} \
&& cd ${NODENV_ROOT} && git checkout ${nodenv_version} \
&& src/configure && make -C src \
&& node_build_version="v4.9.7" \
&& git clone https://github.com/nodenv/node-build.git ${NODENV_ROOT}/plugins/node-build \
&& cd ${NODENV_ROOT}/plugins/node-build && git checkout ${node_build_version} \
&& node_build_jxcore_version="1b6cdf343b767e77b9f1522d5c9fa111c5373794" \
&& git clone https://github.com/nodenv/node-build-jxcore.git $(nodenv root)/plugins/node-build-jxcore \
&& cd $(nodenv root)/plugins/node-build-jxcore && git checkout ${node_build_jxcore_version} \
&& npm_migrate_version="v0.1.1" \
&& git clone https://github.com/nodenv/nodenv-npm-migrate.git ${NODENV_ROOT}/plugins/nodenv-npm-migrate \
&& cd ${NODENV_ROOT}/plugins/nodenv-npm-migrate && git checkout ${npm_migrate_version} \
&& find ${NODENV_ROOT} -type d -name ".git" -exec rm -r "{}" \+

# Install our most used node versions.
# @see https://github.com/conchoid/docker-nodenv-builtins/blob/master/12.18.3-stretch/Dockerfile
# @see https://github.com/conchoid/docker-nodenv-builtins/blob/66b7628ea05c4ec32fa1ec7845931728ce7ecf90/8.14.0-alpine3.8/Dockerfile#L51
ENV NODE10 "10.23.0"
ENV NODE12 "12.20.0"
ENV PREINSTALLED_VERSIONS  "\
${NODE10}\n\
${NODE12}"

COPY --from=node10 "/usr/local/bin/node" "${NODENV_ROOT}/versions/${NODE10}/bin/"
COPY --from=node10 "/usr/local/lib/node_modules" "${NODENV_ROOT}/versions/${NODE10}/lib/node_modules"

SHELL ["/bin/bash", "-c"]
RUN set -x \
    && mkdir -p "${NODENV_ROOT}/versions/${NODE12}/bin/" "${NODENV_ROOT}/versions/${NODE12}/lib/" \
    && cp "$(nodenv which node)" "${NODENV_ROOT}/versions/${NODE12}/bin/" \
    && cp -R "/usr/local/lib/node_modules" "${NODENV_ROOT}/versions/${NODE12}/lib/" \
    && echo -e ${PREINSTALLED_VERSIONS} | while read version;do \
      NPM_SRC="${NODENV_ROOT}/versions/${version}/lib/node_modules/npm/bin/npm-cli.js" \
      && NPM_DST="${NODENV_ROOT}/versions/${version}/bin/npm" \
      # Override the shebang line of npm-cli.js to use the "node" path dynamically.
      && sed -i -E "1s/#.+/#!\/usr\/bin\/env node/" "${NPM_SRC}" \
      && ln -s -f "${NPM_SRC}" "${NPM_DST}";done \
    && nodenv rehash \
    && npm set progress false --global --quiet \
    && [ "$(nodenv versions --bare | xargs)" = "$NODE10 $NODE12" ] \
    && chmod ugo=rx /usr/local/bin/entrypoint.sh \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data \
    && mkdir /var/www \
    && chown -R www-data:www-data /var/www \
    && chown -R www-data:www-data /opt/nodenv \
    && curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash \
    && nodenv install --list

ENTRYPOINT ["entrypoint.sh"]

VOLUME /var/www

USER www-data
