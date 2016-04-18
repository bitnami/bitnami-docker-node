FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r05
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=node \
    BITNAMI_APP_VERSION=5.5.0-1 \
    BITNAMI_APP_CHECKSUM=d3f4aca8e9b47b9372e674fc7377dbe99434aa10e893198d94d72806b7ec6b24 \
    BITNAMI_APP_USER=bitnami

# Install application
RUN bitnami-pkg install $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION --checksum $BITNAMI_APP_CHECKSUM
ENV PATH=/opt/bitnami/python/bin:/opt/bitnami/$BITNAMI_APP_NAME/bin:/opt/bitnami/common/bin:$PATH

WORKDIR /app

# Exposing ports
EXPOSE 3000

# Setting entry point
COPY rootfs/ /
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["node"]
