
IMAGENAME := bitnoize/node

.PHONY: help build rebuild

.DEFAULT_GOAL := help

help:
	@echo "Makefile commands: build rebuild"

#build: export BUILD_OPTS := ...
#build: export PUSH_OPTS := ...
build: .build-18-bullseye .build-16-bullseye .push-18-bullseye .push-16-bullseye

rebuild: export BUILD_OPTS := --pull --no-cache
#rebuild: export PUSH_OPTS := ...
rebuild: .build-18-bullseye .build-16-bullseye .push-18-bullseye .push-16-bullseye

.build-18-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=18 \
		-t "$(IMAGENAME):18-bullseye" \
		-t "$(IMAGENAME):latest" \
		-f Dockerfile.bullseye \
		.

.build-16-bullseye:
	docker build $(BUILD_OPTS) \
		--build-arg NODE_VERSION=16 \
		-t "$(IMAGENAME):16-bullseye" \
		-f Dockerfile.bullseye \
		.

.push-18-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):18-bullseye"
	docker push $(PUSH_OPTS) "$(IMAGENAME):latest"

.push-16-bullseye:
	docker push $(PUSH_OPTS) "$(IMAGENAME):16-bullseye"

