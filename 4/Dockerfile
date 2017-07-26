FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages curl ca-certificates build-essential git pkg-config unzip ghostscript imagemagick libbz2-1.0 libc6 libgcc1 libmysqlclient18 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libstdc++6 libtinfo5 zlib1g

RUN mkdir -p /opt/bitnami

RUN curl -sSLO https://downloads.bitnami.com/files/stacksmith/node-4.8.4-0-linux-x64-debian-8.tar.gz && \
    echo "8efa0e5d8089757e5849c81b3245e9268d84bbafbd3444e00e011f6fbe88d85e  node-4.8.4-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    tar -zxf node-4.8.4-0-linux-x64-debian-8.tar.gz -C /opt/bitnami/ --strip 2 node-4.8.4-0-linux-x64-debian-8/files && \
    rm -rf node-4.8.4-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="4.8.4-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

EXPOSE 3000

WORKDIR /app

CMD ["node"]
