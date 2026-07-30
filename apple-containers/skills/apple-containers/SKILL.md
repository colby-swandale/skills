---
name: apple-containers
description: Run containers on this Mac with Apple's `container` CLI. Use when a task needs a container or service image (postgres, redis…) running locally, a repo ships a compose.yaml or Dockerfile, an instruction says docker or docker compose, or another skill needs backing services started.
---

# Apple Containers

This machine runs containers exclusively through Apple's `container` CLI (github.com/apple/container) — no Docker, and installing it is off the table. **Translate** every `docker …` instruction into its `container` equivalent; subcommands and run flags (`-d --name -p -e -v --rm -it`) largely mirror Docker's.

- A `compose.yaml`/`docker-compose.yml` is a manifest to translate, not execute: skip services the repo builds natively (the app itself), `container run -d --name <service> …` each remaining one from its image/ports/env/volumes, dependencies first.
- Each container is its own lightweight VM — give databases `-m 1g` or more.
- There are no compose-style service hostnames between containers: publish ports and dial `localhost`, or use the container's own IP (`container ls` shows it); `container network create` when two containers must talk directly.

**Done** when each service shows running in `container ls` *and* `container logs <name>` reports it ready to serve — a running container whose service is still initializing refuses connections, so the logs are the finish line.

## Diagnostics

When you run into this error, do this:

- "apiserver is not running" → `container system start`, then retry.
- Platform/architecture error on an image → re-run with `--arch amd64` (Rosetta).
- A tool wants a docker socket or Docker API (testcontainers, act, dip…) → route around it: start the services it wanted via `container run` and point config at `localhost`.
- A flag or subcommand errors — the CLI is young and moves fast: `container <subcommand> --help` is ground truth, not Docker muscle memory.
