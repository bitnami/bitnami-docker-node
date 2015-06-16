FROM bitnami/base-ubuntu:14.04
MAINTAINER The Bitnami Team <containers@bitnami.com>

ENV BITNAMI_APP_NAME nodejs
ENV BITNAMI_APP_VERSION 0.12.4-1
ENV BITNAMI_APP_DIR $BITNAMI_PREFIX/nodejs
ENV BITNAMI_APP_USER bitnami

RUN sh $BITNAMI_PREFIX/install.sh

ENV PATH $BITNAMI_PREFIX/python/bin:$BITNAMI_PREFIX/nodejs/bin:$BITNAMI_PREFIX/common/bin:$PATH
USER $BITNAMI_APP_USER

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3000
VOLUME ["/app"]
WORKDIR /app

CMD ["node"]
