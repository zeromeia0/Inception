#!/bin/bash
set -e

SSL_DIR="/etc/nginx/ssl"
CERT="$SSL_DIR/inception.crt"
KEY="$SSL_DIR/inception.key"

mkdir -p "$SSL_DIR"

if [ ! -f "$CERT" ] || [ ! -f "$KEY" ]; then
    echo "Generating SSL certificate..."
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout "$KEY" \
        -out "$CERT" \
        -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=student/CN=${DOMAIN_NAME}" #fills certificate info automatically
fi

echo "Starting nginx..."
exec nginx -g "daemon off;"