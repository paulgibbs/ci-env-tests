#!/bin/bash
set -eux

# wait for mysql to come up
while ! mysqladmin ping -h "db"; do
    echo "Waiting for mysql..."
    sleep 1
done

# wait for selenium (assume if the port is open then selenium is up)
until nc -z -v -w30 selenium 4444
do
  echo "Waiting for selenium..."
  sleep 1
done

vendor/bin/wp config create --path="$TRAVIS_BUILD_DIR" --dbhost='db' --dbname='wordpress' --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}"
vendor/bin/wp core install --path="$TRAVIS_BUILD_DIR" --url='http://wordpress/' --title="RS WordPress Install" --admin_user="admin" --admin_password="password" --admin_email="admin@example.com"
vendor/bin/wp theme activate --path="$TRAVIS_BUILD_DIR" twentyseventeen
vendor/bin/wp rewrite structure --path="$TRAVIS_BUILD_DIR" '/%year%/%monthnum%/%postname%/'
