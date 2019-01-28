#!/bin/bash
set -ex

WORDPRESS_DIR=/var/www/html

vendor/bin/wp config create --path="$WORDPRESS_DIR" --dbhost='db' --dbname='wordpress' --dbuser="wordpress" --dbpass="wordpress"
vendor/bin/wp core install --path="$WORDPRESS_DIR" --url='http://wordpress/' --title="RS WordPress Install" --admin_user="admin" --admin_password="password" --admin_email="admin@example.com"
vendor/bin/wp theme activate --path="$WORDPRESS_DIR" twentyseventeen
vendor/bin/wp rewrite structure --path="$WORDPRESS_DIR" '/%year%/%monthnum%/%postname%/'
