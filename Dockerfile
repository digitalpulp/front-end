FROM digitalpulp/front-end:codeship
LABEL maintainer="digitalpulp"

RUN addgroup -g 82 -S www-data \
  && adduser -u 82 -D -S -G www-data www-data

RUN mkdir /var/www && chown -R www-data:www-data /var/www

VOLUME /var/www

USER www-data
