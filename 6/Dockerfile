FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages curl ca-certificates build-essential git pkg-config unzip ghostscript imagemagick libbz2-1.0 libc6 libgcc1 libmysqlclient18 libncurses5 libreadline6 libsqlite3-0 libssl1.0.0 libstdc++6 libtinfo5 zlib1g

RUN curl -#SLO https://downloads.bitnami.com/files/stacksmith/node-6.11.1-0-linux-x64-debian-8.tar.gz && \
    echo "30c14d5d23328aafdfe6d63a8956a8cca4eb6bf4f13cbdc6a080a05731b614c1  node-6.11.1-0-linux-x64-debian-8.tar.gz" | sha256sum -c - && \
    tar -zxf node-6.11.1-0-linux-x64-debian-8.tar.gz --transform 's|^.*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf node-6.11.1-0-linux-x64-debian-8.tar.gz

ENV BITNAMI_APP_NAME="node" \
    BITNAMI_IMAGE_VERSION="6.11.1-r0" \
    NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

EXPOSE 3000

WORKDIR /app

CMD ["node"]
