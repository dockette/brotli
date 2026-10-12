# AGENTS.md

## Project

Dockette Brotli builds precompiled NGINX Brotli dynamic module artifacts with Docker. The exported files are `.so` modules for the configured NGINX version and Debian release.

## Artifacts

- Default image name for local Docker tagging: `dockette/brotli`.
- Build context: repository root `.` with `Dockerfile` and `mkbrotli.sh`.
- Default NGINX version: `1.23.3` via `NGINX_VERSION` in `Makefile`.
- Default Debian releases: `bookworm` and `trixie` via `DEBIAN_RELEASES` in `Makefile`.
- Exported artifacts are written to `dist/` and named `debian-<release>-<nginx>-ngx_http_brotli_<filter|static>_module.so`.

## Commands

- `make build` builds and exports Brotli artifacts for the default Debian releases.
- `make test` verifies the expected exported `.so` artifacts exist and are ELF shared objects.
- `make run` prints artifact usage because this repository does not run a long-lived service.

## Testing Notes

- Prefer `make build test` after Dockerfile, script, or artifact naming changes.
- Use `make -n build test run` to dry-run command wiring without requiring Docker.
- Full artifact builds require Docker Buildx and network access for Debian, NGINX, and ngx_brotli sources.

## Guidelines

- Keep `Dockerfile`, `Makefile`, README artifact URLs, and `.github/workflows/docker.yml` aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and the Maintenance section consistent with other Dockette artifact/image repos.
- Do not make `run` launch a fake service; this repo exports build artifacts only.
- Do not introduce unrelated formatting or structural changes.
