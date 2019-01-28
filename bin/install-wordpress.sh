#!/bin/bash
set -ex

docker exec -it --user www-data docker_wpcli_1 config create --path="$TRAVIS_BUILD_DIR" --dbhost='db' --dbname='wordpress' --dbuser="wordpress" --dbpass="wordpress"
docker exec -it --user www-data docker_wpcli_1 core install --path="$TRAVIS_BUILD_DIR" --url='http://wordpress/' --title="RS WordPress Install" --admin_user="admin" --admin_password="password" --admin_email="admin@example.com"
docker exec -it --user www-data docker_wpcli_1 theme activate --path="$TRAVIS_BUILD_DIR" twentyseventeen
docker exec -it --user www-data docker_wpcli_  rewrite structure --path="$TRAVIS_BUILD_DIR" '/%year%/%monthnum%/%postname%/'
