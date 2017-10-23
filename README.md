# Overview
This container provides node and npm. If a Drupal theme set via environment variables and a package.json is present then npm install is run by the entrypoint script.

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
    networks:
      - internal
    working_dir: /var/www/docroot/themes/custom/{site_theme_name}
volumes:
    front_end:
```

A gulp build could then be triggered in your directory:

```
docker-compose exec front-end /var/www/docroot/themes/custom/yourtheme/node_modules/.bin/gulp build
```
