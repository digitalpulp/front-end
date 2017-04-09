FROM mhart/alpine-node:4.8.1

ENV HOME="/home/www-data"
RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data \
  && npm install --global npm@2.15.11 \
  && apk add --no-cache make gcc g++ python git

COPY package.json  bower.json gulpfile.js npm-shrinkwrap.json $HOME/
RUN chown -R www-data:www-data $HOME/* && mkdir -p /var/www && chown -R www-data:www-data /var/www

USER www-data
WORKDIR $HOME
RUN npm install && ./node_modules/.bin/bower install && npm cache clean

# Need the container to stay up so node is available when needed.
CMD tail -f /dev/null
