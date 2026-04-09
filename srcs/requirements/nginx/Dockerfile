FROM debian:bookworm

RUN apt-get update && apt-get install -y nginx openssl && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/sites-available/default
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 443

CMD ["/usr/local/bin/setup.sh"]