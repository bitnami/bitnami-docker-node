FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

RUN install_packages libssl1.0.0 wget ca-certificates && \
    wget -qc https://downloads.bitnami.com/files/stacksmith/node-6.11.1-0-linux-x64-debian-8.tar.gz -P /tmp/ && \
    echo "30c14d5d23328aafdfe6d63a8956a8cca4eb6bf4f13cbdc6a080a05731b614c1  /tmp/node-6.11.1-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    mkdir -p /opt/bitnami && \
    tar -zxf /tmp/node-6.11.1-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-6.11.1-0-linux-x64-debian-8/files && \
    apt-get purge --auto-remove -y wget ca-certificates && \
    rm -rf /tmp/node-6.11.1-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="6.11.1-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

CMD ["node"]
