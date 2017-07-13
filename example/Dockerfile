FROM bitnami/node:8

ENV NODE_ENV="production"

COPY . /app

WORKDIR /app

RUN npm install

CMD ["npm", "start"]
