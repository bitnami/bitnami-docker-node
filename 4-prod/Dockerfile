FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

RUN install_packages libssl1.0.0 wget ca-certificates && \
    wget -qc https://downloads.bitnami.com/files/stacksmith/node-4.8.3-0-linux-x64-debian-8.tar.gz -P /tmp/ && \
    echo "82ac604d6b97bd2070c8ff613de802096e5addd644d6817745ca2aa71d689aa3  /tmp/node-4.8.3-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    mkdir -p /opt/bitnami && \
    tar -zxf /tmp/node-4.8.3-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-4.8.3-0-linux-x64-debian-8/files && \
    apt-get purge --auto-remove -y wget ca-certificates && \
    rm -rf /tmp/node-4.8.3-0-linux-x64-debian-8.tar.gz

ENV NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    NODE_ENV="production" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

CMD ["node"]
