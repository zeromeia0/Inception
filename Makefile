# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: vboxuser <vboxuser@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/04/09 10:34:17 by vboxuser            #+#    #+#              #
#    Updated: 2026/04/10 09:03:26 by vboxuser           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception
COMPOSE = docker compose -f srcs/docker-compose.yml

all: up

up:
	mkdir -p /home/vivaz-ca/data/mariadb
	mkdir -p /home/vivaz-ca/data/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart: down up

build:
	$(COMPOSE) build

logs:
	$(COMPOSE) logs -f

status:
	@echo "=== Containers ==="
	$(COMPOSE) ps

	@echo "\n=== Docker status ==="
	docker ps

	@echo "\n=== Volumes ==="
	docker volume ls

	@echo "\n=== Networks ==="
	docker network ls

inspect:
	docker inspect $$(docker ps -q)

gtm:
	docker exec -it mariadb /bin/bash

gin:
	docker exec -it nginx /bin/bash

giw:
	docker exec -it wordpress /bin/bash

tls:
	openssl s_client -connect vivaz-ca.42.fr:443 -tls1_3

clean:
	$(COMPOSE) down -v --rmi all

eval_clear:
	@echo "Stopping and removing all Docker resources..."
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker ps -qa)
	-docker rmi -f $$(docker images -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2>/dev/null
	@echo "Docker environment cleaned."

http_prove:
	echo "Trying to access https"
	curl -I https://vivaz-ca.42.fr
	echo "Trying to access http"
	curl -I http://vivaz-ca.42.fr

fclean: clean
	sudo rm -rf /home/vivaz-ca/data/mariadb
	sudo rm -rf /home/vivaz-ca/data/wordpress

re: fclean all

.PHONY: all up down start stop restart build logs ps clean fclean re