ARG DEBIAN=bookworm

FROM debian:${DEBIAN} AS builder

ARG NGINX=1.22.0

RUN apt update && \
    apt dist-upgrade -y && \
    apt install --no-install-recommends --no-install-suggests -y \
        ca-certificates \
        git \
        gcc \
        wget \
        make \
        cmake \
        sudo \
        libpcre2-8-0 \
        libpcre2-dev \
        zlib1g \
        zlib1g-dev \
        openssl \
        libssl-dev

ADD ./mkbrotli.sh /srv/mkbrotli.sh

RUN bash /srv/mkbrotli.sh ${NGINX}

FROM scratch AS export

ARG DEBIAN
ARG NGINX

COPY --from=builder /srv/ngx_http_brotli_filter_module.so /debian-${DEBIAN}-${NGINX}-ngx_http_brotli_filter_module.so
COPY --from=builder /srv/ngx_http_brotli_static_module.so /debian-${DEBIAN}-${NGINX}-ngx_http_brotli_static_module.so
