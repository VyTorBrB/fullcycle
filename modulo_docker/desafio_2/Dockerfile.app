FROM node:alpine AS builder

# Install dockerize
ENV DOCKERIZE_VERSION v0.9.4

RUN apk update --no-cache \
    && apk add --no-cache wget openssl \
    && wget -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - -C /usr/local/bin \
    && apk del wget

WORKDIR /app/

COPY ./src/app ./

RUN npm i

FROM node:alpine AS runner

COPY --from=builder /usr/local/bin/dockerize /usr/local/bin/

WORKDIR /app/

COPY --from=builder /app/ ./

# Set the entrypoint to use dockerize with express
ENTRYPOINT ["dockerize", "-wait", "tcp://db:3306", "-timeout", "50s", "node", "index.js"]