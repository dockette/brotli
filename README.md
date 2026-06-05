<h1 align=center>Brotli (precompiled)</h1>

<p align=center>
   <a href="https://github.com/dockette/brotli/actions"><img src="https://github.com/dockette/brotli/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/brotli"><img src="https://img.shields.io/docker/pulls/dockette/brotli.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Precompiled Brotli dynamic modules for NGINX.
</p>

-----

## Usage

```Dockerfile
FROM dockette/debian:buster

ENV NGINX_VERSION=1.23.2
ENV NGINX_MODULES=/usr/lib/nginx/modules

RUN apt update
RUN apt install -y nginx curl
RUN curl -L https://github.com/dockette/brotli/releases/download/latest/debian-buster-${NGINX_VERSION}-ngx_http_brotli_filter_module.so \
    -o ${NGINX_MODULES}/ngx_http_brotli_filter_module.so
```

## Build

This repo using tool [Docker](https://docs.docker.com/get-docker/).

```
make build
make test
```

Artifacts are exported to `dist/`.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
