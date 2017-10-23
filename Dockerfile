FROM mhart/alpine-node:6.11.4

VOLUME /var/www

RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data \
  && apk add --no-cache make gcc g++ python git

COPY entrypoint.sh /usr/local/bin/
RUN chown -R www-data:www-data /var/www && chmod +x /usr/local/bin/entrypoint.sh

USER www-data

ENTRYPOINT ["entrypoint.sh"]
