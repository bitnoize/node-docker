
IMAGENAME := ghcr.io/bitnoize/node

.PHONY: help build rebuild push pull

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull"

#build: export BUILD_OPTS := ...
build: .build-20-bookworm .build-21-bookworm

rebuild: export BUILD_OPTS := --pull --no-cache
rebuild: .build-20-bookworm .build-21-bookworm

.build-20-bookworm:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=20 \
		-t "$(IMAGENAME):20-bookworm" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bookworm \
		.

.build-21-bookworm:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=21 \
		-t "$(IMAGENAME):21-bookworm" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bookworm \
		.

#push: export PUSH_OPTS := ...
push: .push-20-bookworm .push-21-bookworm

.push-20-bookworm:
	docker push $(PUSH_OPTS) "$(IMAGENAME):20-bookworm"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

.push-21-bookworm:
	docker push $(PUSH_OPTS) "$(IMAGENAME):21-bookworm"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

#pull: export PULL_OPTS := ...
pull: .pull-20-bookworm .pull-21-bookworm

.pull-20-bookworm:
	docker pull $(PULL_OPTS) "$(IMAGENAME):20-bookworm"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

.pull-21-bookworm:
	docker pull $(PULL_OPTS) "$(IMAGENAME):21-bookworm"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

