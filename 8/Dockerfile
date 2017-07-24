FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages build-essential git pkg-config unzip ghostscript imagemagick libbz2-1.0 libc6 libgcc1 libmysqlclient18 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libstdc++6 libtinfo5 zlib1g
RUN mkdir -p /opt/bitnami && \
    install_packages libssl1.0.0 wget ca-certificates && \
    wget -qc https://downloads.bitnami.com/files/stacksmith/node-8.1.4-0-linux-x64-debian-8.tar.gz -P /tmp/ && \
    echo "e2f26aa2199e9886b00d33c71798ef4249b0d4f6d9205bd6d8e98a5bf11b7d50  /tmp/node-8.1.4-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/node-8.1.4-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-8.1.4-0-linux-x64-debian-8/files && \
    apt-get purge --auto-remove -y wget ca-certificates && \
    rm -rf /tmp/node-8.1.4-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="8.2.1-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

EXPOSE 3000

WORKDIR /app

CMD ["node"]
