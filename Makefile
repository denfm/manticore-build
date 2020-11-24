-include .env
COMPOSE ?= docker-compose.yml
CF := UID=$(shell id -u) GID=$(shell id -g) docker-compose -f ${COMPOSE}
CFE := ${CF} exec build_manticore

.PHONY: *

build:
	${CF} build
up:
	${CF} up -d
down:
	${CF} down
ps:
	${CF} ps
logs:
	${CF} logs -f
server:
	${CFE} /bin/bash
build_manticore:
	${CFE} /bin/sh -c "rm -rf /manticore/build && mkdir -p /manticore/build && cd /manticore/build && cmake -DPACK=1 /manticore && make -j4 package"