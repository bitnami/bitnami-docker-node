FROM bitnami/node:6 as builder

FROM bitnami/minideb:jessie

LABEL maintainer "Bitnami <container@bitnami.com>"

COPY --from=builder /opt/bitnami/node /opt/bitnami/node

ENV NODE_PATH="/opt/bitnami/node/lib/node_modules" \
    PATH="/opt/bitnami/node/bin:$PATH"

CMD ["node"]
