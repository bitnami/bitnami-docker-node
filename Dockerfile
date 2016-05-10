FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r06
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=6.1.0-0-r0 \
    BITNAMI_APP_NAME=node

RUN bitnami-pkg install node-6.1.0-0 --checksum 849b47ee214fc31f03a307272ead252a2b778d8278137b955a039175cf6d571d
ENV PATH=/opt/bitnami/python/bin:/opt/bitnami/$BITNAMI_APP_NAME/bin:/opt/bitnami/common/bin:$PATH

CMD ["node"]

EXPOSE 3000
