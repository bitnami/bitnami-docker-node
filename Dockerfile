FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r07
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=6.1.0-r0 \
    BITNAMI_APP_NAME=node

RUN bitnami-pkg install node-6.1.0-0 --checksum 849b47ee214fc31f03a307272ead252a2b778d8278137b955a039175cf6d571d
ENV PATH=/opt/bitnami/python/bin:/opt/bitnami/$BITNAMI_APP_NAME/bin:/opt/bitnami/common/bin:$PATH

RUN bitnami-pkg install imagemagick-6.7.5-10-3 --checksum 617e85a42c80f58c568f9bc7337e24c03e35cf4c7c22640407a7e1e16880cf88
RUN bitnami-pkg install mysql-libraries-10.1.13-0 --checksum 71ca428b619901123493503f8a99ccfa588e5afddd26e0d503a32cca1bc2a389

CMD ["node"]

WORKDIR /app

EXPOSE 3000
