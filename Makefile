.ONESHELL:
# this is to run directives from makefile in one shell, not separate shells

SHELL := /bin/bash
CONDA_PATH := /home/ofedorov/anaconda3
# CONDA_PATH := $(conda info | grep -i 'base environment' | awk '{print $4}')
THIS_FILE := $(lastword $(MAKEFILE_LIST))
MONGOD_STARTED := $(shell systemctl is-active mongod)
DOCKER_COMPOSE_CMD := docker-compose -f docker-compose.yml
DOCKER_COMPOSE_DEV_CMD := docker-compose -f docker-compose.yml -f docker-compose.development.yml
SHELL_CMD := source ./preparations.sh
## COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

HELP_TARGET_MAX_CHAR_NUM=20

.PHONY: \
	help \
	goto_app_src \
	start \
	stop \
	restart \
	logs \
	logs_api \
	notebook \
	ps \

#  Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-0-9_]+:/ { \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(HELP_TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

goto_app_src:
	-cd ~/vendor_bot/

#  reloads .bashrc, activates&&updates conda environment, starts jupyter-notebook
start:
	-source $(CONDA_PATH)/etc/profile.d/conda.sh && conda activate && bash -c "$(SHELL_CMD) $(c)"

notebook:
	-python ./psswdgen.py | grep "sha1" 

# sudo bash ./run_scipynotebook.sh 'sha1:1f44b533bdd1:34e68851b0bb05a774ed26b60f839a045f3ab022'
logs:
	-$(DOCKER_COMPOSE_CMD) logs --tail=100 -f $(c)

#  lists application for bot container
logs_api:
	-$(DOCKER_COMPOSE_CMD) logs --tail=100 -f bot_container

#  lists containers in docker-compose
ps:
	-$(DOCKER_COMPOSE_CMD) ps
