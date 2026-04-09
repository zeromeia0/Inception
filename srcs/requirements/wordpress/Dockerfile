FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    wget \
    mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf 
#lembrar que a versao php pode mudar, verificar na 42
COPY toold/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 9000

CMD ["/usr/local/bin/setup.sh"]