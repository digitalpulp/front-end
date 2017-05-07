# Overview
This container builds two directories:

- /home/www-data/bower_components
- /home/www-data/node_modules

# Example docker-compose settings

```
web:
    image: drupaldocker/nginx
    depends_on:
      - database
      - php
    volumes:
      - .:/var/www
      - front_end:/var/www/front_end
front-end:
    image: digitalpulp/front-end:latest
    environment:
      THEME_NAME: project
    depends_on:
      - web
    volumes:
      - .:/var/www
      - front_end:/var/www/front_end
    networks:
      - internal
volumes:
    front_end:
```

A gulp build could then be triggered in your directory:

```
docker-compose exec front-end /var/www/docroot/themes/custom/yourtheme/node_modules/.bin/gulp build
```