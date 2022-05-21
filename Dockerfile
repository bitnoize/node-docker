
FROM bitnoize/debian-backports:bullseye

ARG DEBIAN_FRONTEND=noninteractive
ARG NODE_RELEASE=18

RUN set -eux; \
    groupadd -g 1000 node; \
    useradd -M -d /home/node -s /bin/bash -g 1000 -u 1000 node; \
    mkdir -p /home/node; \
    chown node:node /home/node; \
    chmod 750 /home/node

RUN set -eux; \
    # Node.js APT
    echo "Package: *"                 >> /etc/apt/preferences.d/20nodesource; \
    echo "Pin: release o=Node Source" >> /etc/apt/preferences.d/20nodesource; \
    echo "Pin-Priority: 1000"         >> /etc/apt/preferences.d/20nodesource; \
    wget -q -O- "http://deb.nodesource.com/gpgkey/nodesource.gpg.key" | \
        gpg --dearmor > /usr/share/keyrings/nodesource-archive-keyring.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nodesource-archive-keyring.gpg] http://deb.nodesource.com/node_${NODE_RELEASE}.x bullseye main" > \
        /etc/apt/sources.list.d/nodesource.list; \
    # Yarn APT
    echo "Package: *"           >> /etc/apt/preferences.d/30yarn; \
    echo "Pin: release o=yarn"  >> /etc/apt/preferences.d/30yarn; \
    echo "Pin-Priority: 1000"   >> /etc/apt/preferences.d/30yarn; \
    wget -q -O- "http://dl.yarnpkg.com/debian/pubkey.gpg" | \
        gpg --dearmor > /usr/share/keyrings/yarn-archive-keyring.gpg; \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/yarn-archive-keyring.gpg] https://dl.yarnpkg.com/debian stable main" > \
        /etc/apt/sources.list.d/yarn.list; \
    # Debian packages
    apt-get update -q; \
    apt-get install -yq \
        gosu build-essential git nodejs yarn; \
    # Clean-up
	  rm -rf /var/lib/apt/lists/*; \
    # Smoke tests
    node --version; \
    npm --version; \
    yarn --version

COPY docker-entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["node"]

