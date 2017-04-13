# Overview
This container builds two directories:

- /home/www-data/bower_components
- /home/www-data/node_modules

# Example docker-compose settings

```
front-end:
    image: digitalpulp/front-end:latest
    command: ln -s /home/www-data/bower_components /var/www/docroot/themes/custom/yourtheme/bower_components && ln -s /home/www-data/node_modules /var/www/docroot/themes/custom/yourtheme/node_modules && tail -f /dev/null
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