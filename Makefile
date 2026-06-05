DOCKER_IMAGE=dockette/brotli
DOCKER_TAG?=latest
DOCKER_PLATFORMS?=linux/amd64,linux/arm64
DOCKER_BUILD_PLATFORM?=linux/amd64
DEBIAN_RELEASES?=buster bullseye
DIST_DIR?=dist
NGINX_VERSION?=1.23.3

.PHONY: build
build: build-buster build-bullseye

.PHONY: build-bullseye
build-bullseye:
	${MAKE} build-release DEBIAN_RELEASE=bullseye

.PHONY: build-buster
build-buster:
	${MAKE} build-release DEBIAN_RELEASE=buster

.PHONY: build-release
build-release:
	docker buildx build --platform ${DOCKER_BUILD_PLATFORM} \
		--target export \
		--build-arg DEBIAN=${DEBIAN_RELEASE} \
		--build-arg NGINX=${NGINX_VERSION} \
		--tag ${DOCKER_IMAGE}:${DEBIAN_RELEASE} \
		--output ${DIST_DIR} \
		.

.PHONY: test
test:
	for debian in ${DEBIAN_RELEASES}; do \
		for module in filter static; do \
			artifact="${DIST_DIR}/debian-$${debian}-${NGINX_VERSION}-ngx_http_brotli_$${module}_module.so"; \
			test -f "$${artifact}"; \
			file "$${artifact}" | grep -q 'ELF.*shared object'; \
		done; \
	done

.PHONY: run
run:
	printf 'Brotli artifacts are exported to %s after make build.\n' '${DIST_DIR}'
	printf 'Use the *.so files in an NGINX modules directory matching NGINX %s.\n' '${NGINX_VERSION}'
