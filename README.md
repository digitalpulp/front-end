# Overview
This container builds one directory:

- /home/www-data/node_modules

Which is then symlinked into the Drupal theme set via environment variables.

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
      THEME_NAME: your_name
    depends_on:
      - web
    volumes:
      - .:/var/www
      - front_end:/var/www/front_end
    networks:
      - internal
    working_dir: /var/www/docroot/themes/custom/your_name
volumes:
    front_end:
```

A gulp build could then be triggered in your directory:

```
docker-compose exec front-end /var/www/docroot/themes/custom/yourtheme/node_modules/.bin/gulp build
```
