# REQUIRED SECTION
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ROOT_DIR)/.mk-lib/common.mk
# END OF REQUIRED SECTION

DC_CMD := $(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE)

.PHONY: help dependencies build up start stop restart status ps clean bash logs

bash: ## bash php
	@$(DC_CMD) exec php /bin/bash

bash-mysql: ## bash php-db
	@$(DC_CMD) exec db /bin/bash

bash-nginx: ## bash php-nginx
	@$(DC_CMD) exec nginx /bin/bash

bash-node: ## bash php-nginx
	@$(DC_CMD) exec node /bin/bash

up: ## Start all or c=<name> containers in foreground
	@$(DC_CMD) up $(c)

start: ## Start all or c=<name> containers in background
	@$(DC_CMD) up -d $(c)

stop: ## Stop all or c=<name> containers
	@$(DC_CMD) stop $(c)

restart: ## Restart all or c=<name> containers
	@$(DC_CMD) stop $(c)
	@$(DC_CMD) up $(c) -d

status: ## Show status of containers
	@$(DC_CMD) ps

ps: status ## Alias of status

clean: ## Clean all data
	@$(DC_CMD) down

build: ## Build php-fpm
	@$(DC_CMD) up --build -d

logs: ## Show all or c=<name> logs of containers
	@$(DC_CMD) logs $(c)