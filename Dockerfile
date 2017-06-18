FROM mhart/alpine-node:4.8.1

ENV HOME="/home/www-data"
RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data \
  && npm install --global npm@2.15.11 \
  && apk add --no-cache make gcc g++ python git

COPY package.json npm-shrinkwrap.json ${HOME}/
COPY entrypoint.sh /usr/local/bin/
RUN chown -R www-data:www-data ${HOME}/* && mkdir -p /var/www/front_end && chown -R www-data:www-data /var/www && chmod +x /usr/local/bin/entrypoint.sh

USER www-data
WORKDIR ${HOME}
RUN npm install && npm cache clean && mv ./node_modules /var/www/front_end

ENTRYPOINT ["entrypoint.sh"]
