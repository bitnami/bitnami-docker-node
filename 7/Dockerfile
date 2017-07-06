FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

RUN install_packages libssl1.0.0 wget ca-certificates && \
    wget -qc https://downloads.bitnami.com/files/stacksmith/node-7.10.1-0-linux-x64-debian-8.tar.gz -P /tmp/ && \
    echo "544364fb68585a5e528fff8cf50f9fdbe6cee30f3767f5b3f475412370f2e7a6  /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    mkdir -p /opt/bitnami && \
    tar -zxf /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-7.10.1-0-linux-x64-debian-8/files && \
    apt-get purge --auto-remove -y wget ca-certificates && \
    rm -rf /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="7.10.1-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

CMD ["node"]
