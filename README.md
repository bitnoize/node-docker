node-docker
===========

Dockerfile for projects on top of Node.js.

## Build

```sh
# Latest version
$ docker build  -t bitnoize/node:18.0.0-bullseye -t bitnoize/node:18-bullseye -t bitnoize/node:latest .
# Specific version
$ docker build --build-arg NODE_VERSION=16 -t bitnoize/node:16.15.0-bullseye -t bitnoize/node:16-bullseye .

```

