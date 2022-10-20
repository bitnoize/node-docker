
IMAGENAME := ghcr.io/bitnoize/node

.PHONY: help build rebuild push pull

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild push pull"

#build: export BUILD_OPTS := ...
build: .build-19-bullseye .build-18-bullseye .build-16-bullseye

rebuild: export BUILD_OPTS := --pull --no-cache
rebuild: .build-19-bullseye .build-18-bullseye .build-16-bullseye

.build-19-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=19 \
		-t "$(IMAGENAME):19-bullseye" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bullseye \
		.

.build-18-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=18 \
		-t "$(IMAGENAME):18-bullseye" \
		-f Dockerfile.bullseye \
		.

.build-16-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=16 \
		-t "$(IMAGENAME):16-bullseye" \
		-f Dockerfile.bullseye \
		.

#push: export PUSH_OPTS := ...
push: .push-19-bullseye .push-18-bullseye .push-16-bullseye

.push-19-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):19-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

.push-18-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):18-bullseye"

.push-16-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):16-bullseye"

#pull: export PULL_OPTS := ...
pull: .pull-19-bullseye .pull-18-bullseye .pull-16-bullseye

.pull-19-bullseye:
	docker pull $(PULL_OPTS) "$(IMAGENAME):19-bullseye"
	docker pull $(PULL_OPTS) "$(IMAGENAME):latest"

.pull-18-bullseye:
	docker pull $(PULL_OPTS) "$(IMAGENAME):18-bullseye"

.pull-16-bullseye:
	docker pull $(PULL_OPTS) "$(IMAGENAME):16-bullseye"

