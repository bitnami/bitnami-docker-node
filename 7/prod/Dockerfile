FROM bitnami/node:7 as builder

FROM bitnami/minideb:jessie
LABEL maintainer "Bitnami <container@bitnami.com>"

RUN install_packages libssl1.0.0

COPY --from=builder /opt/bitnami /opt/bitnami

ENV NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:/opt/bitnami/python/bin:$PATH"

CMD ["node"]
