#!/bin/sh

set -e

mkdir -p -m 0750 /run/php

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id php -u)" ]; then
    usermod -u "$UID" php
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id php -g)" ]; then
    groupmod -g "$GID" php
  fi

  chown -R php:php \
    /run/php \
    /var/lib/php \
    /var/log/php

  if [ -d "/lib/entrypoint" ]; then
    run-parts -v --regex '.*sh$' /lib/entrypoint
  fi

  exec gosu php "$@"
else
  exec "$@"
fi

