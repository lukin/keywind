-include .env

# BuildKit enables higher performance docker builds and caching possibility
# to decrease build times and increase productivity for free.
export DOCKER_BUILDKIT ?= 1
export COMPOSE_DOCKER_CLI_BUILD ?= 1

# https://github.com/vercel/turbo/issues/223
export FORCE_COLOR ?= 1

DOCKER ?= docker
DOCKER_COMPOSE ?= docker compose

# Support image with all needed binaries, like envsubst, mkcert, wait4x
SUPPORT_IMAGE ?= wayofdev/build-deps:alpine-latest

BUILDER_PARAMS ?= docker run \
 	--rm \
 	-i \
 	-v $(PWD):/app \
 	--workdir /app \
	--env-file ./.env

BUILDER ?= $(BUILDER_PARAMS) $(SUPPORT_IMAGE)

# Shorthand envsubst command, executed through build-deps
ENVSUBST ?= $(BUILDER) envsubst

NPM_BIN ?= pnpm
NPM_RUNNER ?= $(NPM_BIN)


# Self documenting Makefile code
# ------------------------------------------------------------------------------------
ifneq ($(TERM),)
	BLACK := $(shell tput setaf 0)
	RED := $(shell tput setaf 1)
	GREEN := $(shell tput setaf 2)
	YELLOW := $(shell tput setaf 3)
	LIGHTPURPLE := $(shell tput setaf 4)
	PURPLE := $(shell tput setaf 5)
	BLUE := $(shell tput setaf 6)
	WHITE := $(shell tput setaf 7)
	RST := $(shell tput sgr0)
else
	BLACK := ""
	RED := ""
	GREEN := ""
	YELLOW := ""
	LIGHTPURPLE := ""
	PURPLE := ""
	BLUE := ""
	WHITE := ""
	RST := ""
endif
MAKE_LOGFILE = /tmp/keywind.log
MAKE_CMD_COLOR := $(BLUE)

default: all

help: ## Show this menu
	@echo 'Management commands for package:'
	@echo 'Usage:'
	@echo '    ${MAKE_CMD_COLOR}make${RST}                       Prepares and spins up project with default settings'
	@grep -E '^[a-zA-Z_0-9%-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "    ${MAKE_CMD_COLOR}make %-21s${RST} %s\n", $$1, $$2}'
	@echo
	@echo '    📑 Logs are stored in      $(MAKE_LOGFILE)'
	@echo
	@echo '    📦 Package                 keywind (github.com/wayofdev/keywind)'
	@echo '    🤠 Authors                 Anthony Lukin (github.com/lukin), Andrij Orlenko (github.com/lotyp)'
	@echo '    🏢 ${YELLOW}Org                     wayofdev (github.com/wayofdev)${RST}'
.PHONY: help

.EXPORT_ALL_VARIABLES:


# Default action
# Defines default command when `make` is executed without additional parameters
# ------------------------------------------------------------------------------------
all: install hooks
.PHONY: all


# System Actions
# ------------------------------------------------------------------------------------
env: ## Generate .env file from example, use `make env FORCE=true`, to force re-create file
ifeq ($(FORCE),true)
	@echo "${YELLOW}Force re-creating .env file from example...${RST}"
	$(ENVSUBST) < ./.env.example > ./.env
else ifneq ("$(wildcard ./.env)","")
	@echo ""
	@echo "${YELLOW}The .env file already exists! Use FORCE=true to re-create.${RST}"
else
	@echo "Creating .env file from example"
	$(ENVSUBST) < ./.env.example > ./.env
endif
.PHONY: env

i: ## Install dependencies
	$(NPM_RUNNER) i
.PHONY: i

install: i ## Same as `make i`
.PHONY: install

update: ## Run pnpm to packages to their latest version based on the specified range
	$(NPM_RUNNER) update
.PHONY: update

purge: down ## Stops container and deletes node modules and temporary files
	find . | grep /node_modules$ | grep -v /node_modules/ | xargs rm -fR
	find . | grep /.turbo$ | grep -v /.turbo/ | xargs rm -fR
	rm -rf .pnpm-store pnpm-lock.yaml
.PHONY: purge

deps-check: ## Check for outdated dependencies
	$(NPM_RUNNER) run deps:check
.PHONY: deps-check

deps-update: ## Check for outdated dependencies and automatically update them using pnpm
	$(NPM_RUNNER) run deps:update
.PHONY: deps-update

dev: ## Run development server
	$(NPM_RUNNER) dev
.PHONY: dev

commit: ## Commit changes using commitizen
	$(NPM_RUNNER) commit
.PHONY: commit


# Docker Actions
# ------------------------------------------------------------------------------------
up: ## Spin up this project using docker
	$(DOCKER_COMPOSE) up --remove-orphans -d
	make _kc-wait kc-configure kc-update
.PHONY: up

down: ## Stops and removes all project containers
	$(DOCKER_COMPOSE) down --remove-orphans
.PHONY: down

restart: down up ## Removes containers and stops, then starts new instances
.PHONY: restart

clean: ## Stops and removes docker containers, specified in docker-compose.yml
	$(DOCKER_COMPOSE) rm --force --stop
.PHONY: clean

ps: ## Show running containers
	$(DOCKER_COMPOSE) ps
.PHONY: ps

logs: ## Show all project docker logs
	$(DOCKER_COMPOSE) logs -f
.PHONY: logs


# Testing and Code Quality
# ------------------------------------------------------------------------------------
lint: ## Run lint task to fix issues
	$(NPM_RUNNER) lint:fix
.PHONY: lint

lint-staged: ## Lint staged files
	$(NPM_RUNNER) lint:staged
.PHONY: lint-staged

lint-commits: ## Run commitlint to check commit message
	$(NPM_RUNNER) lint:commits
.PHONY: lint-commits

lint-md: ## Lint markdown files
	$(NPM_RUNNER) lint:md
.PHONY: lint-md

lint-secrets: ## Check if there are any missed secret credentials in code
	$(NPM_RUNNER) lint:secrets
.PHONY: lint-secrets

lint-yaml: ## Lints yaml files inside project
	yamllint .
.PHONY: lint-yaml

lint-actions: ## Lint github actions using actionlint
	$(BUILDER) actionlint -color
.PHONY: lint-actions

sort: ## Sort package.json files across project
	$(NPM_RUNNER) lint:package-json
.PHONY: sort


# Building components
# ------------------------------------------------------------------------------------
build: ## Build theme
	$(NPM_RUNNER) build
.PHONY: build

build-jar: ## Build jar theme file
	$(NPM_RUNNER) build:jar
.PHONY: build


# Keycloak Actions
# ------------------------------------------------------------------------------------
kc-up: ## Create and start keycloak container
	$(DOCKER_COMPOSE) up -d keycloak
.PHONY: kc-up

kc-recreate: kc-clean kc-up _kc-wait kc-configure kc-update ## Stop, delete container and volume, then create and start new one
.PHONY: kc-recreate

kc-clean: ## Removes keycloak, keycloak database containers and their volumes
	$(DOCKER_COMPOSE) rm -svf keycloak-database keycloak
	$(DOCKER) volume rm -f $(COMPOSE_PROJECT_NAME)_keycloak_data
.PHONY: kc-clean

_kc-wait:
	@$(DOCKER) run --rm --net=host --name='wait4x' atkrad/wait4x:latest \
		http $(shell docker inspect --format 'http://127.0.0.1:{{ (index (index .NetworkSettings.Ports "8080/tcp") 0).HostPort }}' keywind_keycloak) \
		-t 1m
.PHONY: _kc-wait

kc-configure: ## Configure keycloak realms
	$(DOCKER_COMPOSE) exec -T keycloak sh /tmp/setup/setup-master-realm.sh
	$(DOCKER_COMPOSE) exec -T keycloak sh /tmp/setup/setup-client-realm.sh
	$(DOCKER_COMPOSE) exec -T keycloak sh /tmp/setup/setup-admin-realm.sh
.PHONY: kc-configure

kc-update: ## Update keycloak realms
	$(DOCKER_COMPOSE) exec -T keycloak sh /tmp/setup/update-realms.sh
.PHONY: kc-update

kc-certs: ## Create self-signed certificates for keycloak
	mkcert -key-file docker/keycloak/certs/key.pem -cert-file docker/keycloak/certs/cert.pem auth.wod.docker *.wod.docker
.PHONY: mkcert


# Git Actions
# ------------------------------------------------------------------------------------
hooks: ## Install git hooks from husky
	$(NPM_RUNNER) run prepare
.PHONY: hooks
