# 🐳 Docker

ifndef NODE_ENV
	# Determine if .env file exist
	ifneq ("$(wildcard .env)","")
		include .env
	endif
endif

project=-p ${PROJECT_NAME}
service=${PROJECT_NAME}:latest
interactive:=$(shell [ -t 0 ] && echo 1)
ifneq ($(interactive),1)
	optionT=-T
endif

exec:
	@docker-compose $(project) exec $(optionT) db $$cmd

# 🚀 Up app
up: 
	@docker-compose $(project) up -d
down: 
	@docker-compose $(project) down
build: 
	@docker-compose build

rebuild:
	make build
	make down
	make up

deploy:
	make rebuild
	yes y | docker system prune -a

