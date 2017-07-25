FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages wget ca-certificates build-essential git pkg-config unzip ghostscript imagemagick libbz2-1.0 libc6 libgcc1 libmysqlclient18 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libstdc++6 libtinfo5 zlib1gg
RUN mkdir -p /opt/bitnami && \
    wget -qc https://downloads.bitnami.com/files/stacksmith/node-7.10.1-0-linux-x64-debian-8.tar.gz -P /tmp/ && \
    echo "544364fb68585a5e528fff8cf50f9fdbe6cee30f3767f5b3f475412370f2e7a6  /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-7.10.1-0-linux-x64-debian-8/files && \
    rm -rf /tmp/node-7.10.1-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="7.10.1-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

EXPOSE 3000

WORKDIR /app

CMD ["node"]
