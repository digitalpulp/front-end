# Overview
This container builds two directories:

- /home/www-data/bower_components
- /home/www-data/node_modules

# Example docker-compose settings

```
front-end:
    image: digitalpulp/front-end:latest
    environment:
      THEME_NAME: project
    depends_on:
      - web
    volumes:
      - docroot:/var/www
    networks:
      - internal
```

A gulp build could then be triggered in your directory:

```
docker-compose exec front-end /var/www/docroot/themes/custom/yourtheme/node_modules/.bin/gulp build
```