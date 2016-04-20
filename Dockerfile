FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r05
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=node \
    BITNAMI_APP_VERSION=5.10.1-0  \
    BITNAMI_APP_CHECKSUM=c6ec28b7c9328aed677f8606d691a4aa6b5c0e708db8318ddedb78e3c78754b2

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
