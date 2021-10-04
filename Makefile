.ONESHELL:
# this is to run directives from makefile in one shell, not separate shells

SHELL := /bin/bash
CONDA_PATH := /home/ofedorov/anaconda3
# CONDA_PATH := $(conda info | grep -i 'base environment' | awk '{print $4}')
THIS_FILE := $(lastword $(MAKEFILE_LIST))
MONGOD_STARTED := $(shell systemctl is-active mongod)
DOCKER_CMD := docker
DOCKER_COMPOSE_DEV_CMD := docker-compose -f docker-compose.yml -f docker-compose.development.yml
SHELL_CMD := bash ./work/maintenance/env_preparations.sh

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
	notebook \
	env \
	vina \
	logs \
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
	-docker exec -ti notebook sh -c "source $(CONDA_PATH)/etc/profile.d/conda.sh && conda activate && bash -c '$(SHELL_CMD) $(c)'"

#  runs container with scipy jupyter notebook
notebook:
	-source ./maintenance/run_scipynotebook.sh

#  creates or updates vina env
env:
	-docker exec -ti notebook /bin/bash -c "$(SHELL_CMD) $(c)"

#  launches vina notebook
vina:
	-docker exec -ti notebook /bin/bash -c "conda run -n vina /bin/bash -c 'source ./work/maintenance/run_vina_notebook.sh'"

#  logs
logs:
	-$(DOCKER_CMD) logs --tail=100 -f $(c)

#  lists containers in docker-compose
ps:
	-docker ps

#  stops docker notebook container and removes it
tranclucate:
	-docker kill notebook &> /dev/null && docker rm notebook -f &> /dev/null