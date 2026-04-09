#!/bin/bash
set -e

MYSQL_PASSWORD="$(cat /run/secrets/db_password)"
WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
WP_USER_PASSWORD="$(cat /run/secrets/wp_user_password)"

WP_PATH="/var/www/html"

mkdir -p "$WP_PATH"

until mariadb -h"$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

if [ ! -f "$WP_PATH/wp-config.php" ]; then
    cd /tmp
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* "$WP_PATH"
    rm -rf /tmp/wordpress /tmp/latest.tar.gz

    cd "$WP_PATH"
    wp config create \
        --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$MYSQL_HOST"

    wp core install \
        --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL"

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --allow-root \
        --user_pass="$WP_USER_PASSWORD" \
        --role=author
fi

mkdir -p /run/php
exec /usr/sbin/php-fpm8.2 -F