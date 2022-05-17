#!/bin/sh

set -e

if [ "$(id -u)" = "0" ]; then
  if [ -n "$UID" ] && [ ! "$UID" = "$(id node -u)" ]; then
    usermod -u "$UID" node
  fi

  if [ -n "$GID" ] && [ ! "$GID" = "$(id node -g)" ]; then
    groupmod -g "$GID" node
  fi

  chown -R node:node /var/lib/node

  exec gosu node "$@"
else
  exec "$@"
fi
