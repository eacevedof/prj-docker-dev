#!/bin/bash
TODAY := $(shell date +'%Y-%m-%d')
CURRENT_BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

help: ## Show this help message
	@echo "usage: make [target]"
	@echo
	@echo "targets:"
	@egrep "^(.+)\:\ ##\ (.+)" ${MAKEFILE_LIST} | column -t -c 2 -s ":#"

gitpush: ## git push m=any message
	clear;
	git add .; git commit -m "$(m)"; git push;

rebuild-all: ## rebuild all containers
	clear
	docker-compose down
	docker-compose -f docker-compose.yml up -d --build --remove-orphans
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-apache: ## rebuild apache container
	clear
	docker-compose build apache
	docker-compose up --no-deps -d apache
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-spark: ## rebuild spark container
	clear
	docker-compose build spark
	docker-compose up --no-deps -d spark
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-php85: ## rebuild php-fpm-8.5
	clear
	docker-compose up -d --build php-fpm-8.5
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-mariadb: ## rebuild mariadb
	clear
	docker-compose up -d --build mariadb
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-pg: ## rebuild postgres
	clear
	docker-compose up -d --build postgres
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-redis: ## rebuild redis
	clear
	docker-compose up -d --build redis
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-py: ## rebuild py-3.15
	clear
	docker-compose up -d --build py-3.15
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-n8n: ## rebuild n8n (standby: fuera del up por defecto)
	clear
	docker-compose --profile standby up -d --build n8n
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

rebuild-kafka-br1: ## rebuild kafka-br1 (broker 1)
	clear
	docker-compose up -d --build kafka-br1
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

destroy-all: ## destroy container and image
	docker-compose down --rmi all

ssh-apache: ## connect to  cont-lr-apache
	docker exec -it --user root cont-lr-apache bash

ssh-php85: ## connect to  cont-php-fpm-8.5
	docker exec -it --user root cont-php-fpm-8.5 bash

ssh-redis: ## connect to  cont-redis
	docker exec -it --user root cont-redis sh

ssh-mariadb: ## connect to cont-lr-mariadb
	docker exec -it --user root cont-lr-mariadb bash

ssh-spark: ## connect to cont-lr-spark
	docker exec -it --user root cont-lr-spark bash

ssh-pg: ## connect to cont-db-postgres
	docker exec -it --user root cont-db-postgres bash

ssh-py315: ## connect to cont-py-3.15
	docker exec -it --user root cont-py-3.15 bash

ssh-n8n: ## connect to  cont-n8n
	docker exec -it --user root cont-n8n bash

ssh-kafka: ## connect to  cont-n8n
	docker exec -it --user root cont-kafka-br1 bash

restart-apache: ## restart apache
	docker-compose restart apache

docker-ps: ## show docker ps
	docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

start:  ## start container
	docker-compose start

stop:   ## stop it
	docker-compose stop
