# Overview
This container provides nodenv, which provides shims for different versions of node and npm. If a Drupal theme set via environment variables and a .node-version file is present then nodenv install is executed from the theme folder to ensure the specified version of node exists in the image.

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
      THEME_NAME: yourtheme
    depends_on:
      - web
    volumes:
      - .:/var/www
    networks:
      - internal
    working_dir: /var/www/docroot/themes/custom/yourtheme
volumes:
    front_end:
```
Place a [.node_version](https://github.com/nodenv/nodenv/blob/master/README.md#choosing-the-node-version) file in your
theme directory.  When the container mounts, that version of node will be installed.

Node module installation could then be triggered in your directory:

```
docker-compose exec front-end /var/www/docroot/themes/custom/yourtheme/npm install
```

If your theme is not located in the container at
`/var/www/docroot/themes/custom` then set the additional environment variable
`THEME_PATH` to the proper path in the `environment` key within your
docker-compose.yml
