FROM conchoid/docker-nodenv-builtins
LABEL maintainer="digitalpulp"

COPY entrypoint.sh /usr/local/bin/
RUN apk add --no-cache make gcc g++ python git && chmod ugo=rx /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data

RUN mkdir /var/www && chown -R www-data:www-data /var/www

VOLUME /var/www

USER www-data
