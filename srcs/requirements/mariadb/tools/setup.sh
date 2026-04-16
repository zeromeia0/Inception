#!/bin/bash
set -e

MYSQL_PASSWORD="$(cat /run/secrets/db_password)"
MYSQL_ROOT_PASSWORD="$(cat /run/secrets/db_root_password)"
MYSQL_ADMIN_PASSWORD="$(cat /run/secrets/db_admin_password)"

DB_PATH="/var/lib/mysql"
SOCKET="/run/mysqld/mysqld.sock"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql "$DB_PATH"

mkdir -p /var/log/mysql
touch /var/log/mysql/error.log
chown -R mysql:mysql /var/log/mysql

if [ ! -d "$DB_PATH/mysql" ]; then
    echo "Initializing MariaDB database..."
    mariadb-install-db --user=mysql --datadir="$DB_PATH"

    echo "Starting MariaDB temporarily..."
    mysqld --user=mysql --datadir="$DB_PATH" --socket="$SOCKET" --skip-networking &

    until mariadb-admin --protocol=socket --socket="$SOCKET" ping --silent; do
        sleep 1
    done

    echo "Configuring MariaDB..."
    mariadb --protocol=socket --socket="$SOCKET" -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_ADMIN_USER}'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

    echo "Stopping temporary MariaDB..."
    mariadb-admin --protocol=socket --socket="$SOCKET" -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

echo "Starting MariaDB in foreground..."
exec mysqld --user=mysql --datadir="$DB_PATH" --socket="$SOCKET"