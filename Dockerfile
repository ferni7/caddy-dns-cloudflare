FROM caddy:builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare 

FROM caddy:alpine

RUN mkdir -p /config/caddy /data/caddy; \
    addgroup -g 82 -S www-data; \
    adduser -u 82 -D -S -G www-data www-data; \
    chown -R www-data:www-data /config /data

USER www-data

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
