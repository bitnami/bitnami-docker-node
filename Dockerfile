FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=node \
    BITNAMI_APP_USER=bitnami \
    BITNAMI_APP_VERSION=5.5.0-1 \
    NODE_PACKAGE_SHA256="d3f4aca8e9b47b9372e674fc7377dbe99434aa10e893198d94d72806b7ec6b24"

ENV BITNAMI_APP_DIR=/opt/bitnami/$BITNAMI_APP_NAME

ENV PATH=/opt/bitnami/python/bin:$BITNAMI_APP_DIR/bin:/opt/bitnami/common/bin:$PATH

RUN bitnami-pkg install $BITNAMI_APP_NAME-$BITNAMI_APP_VERSION

COPY rootfs/ /

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node"]
