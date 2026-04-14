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
	mkdir -p /home/vboxuser/data/mariadb
	mkdir -p /home/vboxuser/data/wordpress
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

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean
	sudo rm -rf /home/vboxuser/data/mariadb
	sudo rm -rf /home/vboxuser/data/wordpress

re: fclean all

.PHONY: all up down start stop restart build logs ps clean fclean re