FROM node:alpine AS builder

WORKDIR /app/

COPY ./src/app ./

RUN npm i

FROM node:alpine AS runner

WORKDIR /app/

# Install dockerize
ENV DOCKERIZE_VERSION v0.9.4

RUN apk update --no-cache \
    && apk add --no-cache wget openssl \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apk del wget

COPY --from=builder /app/ ./

ENTRYPOINT [ "node", "index.js"]