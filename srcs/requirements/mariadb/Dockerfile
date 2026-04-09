# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vvazzs <vvazzs@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/04/09 10:56:13 by vvazzs            #+#    #+#              #
#    Updated: 2026/04/09 11:22:09 by vvazzs           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

EXPOSE 3306

CMD ["/usr/local/bin/setup.sh"]