#!/bin/bash
set -ex

vendor/bin/wp config create --path="$TRAVIS_BUILD_DIR" --dbhost='db' --dbname='wordpress' --dbuser="wordpress" --dbpass="wordpress"
vendor/bin/wp core install --path="$TRAVIS_BUILD_DIR" --url='http://wordpress/' --title="RS WordPress Install" --admin_user="admin" --admin_password="password" --admin_email="admin@example.com"
vendor/bin/wp theme activate --path="$TRAVIS_BUILD_DIR" twentyseventeen
vendor/bin/wp rewrite structure --path="$TRAVIS_BUILD_DIR" '/%year%/%monthnum%/%postname%/'
