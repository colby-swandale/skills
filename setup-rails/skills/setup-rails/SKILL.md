---
name: setup-rails
description: Take a Rails app to a green boot — server answering, tests passing — on this machine. Use when creating a new Rails application, when getting a cloned Rails app running for local development or testing, or when a Rails app fails to start because of local setup (wrong Ruby, missing gems, unprepared database).
---

# Setup a Rails App

The finish line is a **green boot**: the dev server answers HTTP *and* the test suite passes. Setup is done at green boot and not before — a clean `bundle install` proves nothing about a bootable app.

## Steps

1. **Pin the toolchain.** Read the app's Ruby pin (`.ruby-version`, or the `ruby` line in `Gemfile`) and activate it with mise: `mise use ruby@<version>` in the app directory (`mise install` if the version isn't present). A brand-new app with no pin gets the newest stable Ruby mise offers. *Done when `ruby -v` run inside the app directory prints the pinned version.*

2. **Create the app** *(new apps only — existing apps skip to step 3)*. `rails new <name> --database=postgresql --css=tailwind`; Postgres and Tailwind are the house defaults, so change flags only when the user names a different stack. If the `rails` command is missing, `gem install rails` first. *Done when the app directory contains `Gemfile` and `config/application.rb`.*

3. **Install and prepare.** When the repo ships `bin/setup`, run it — it is the app's own recipe and overrides the rest of this step. Otherwise: `bundle install`, start the backing services, then `bin/rails db:prepare`. Services come from the repo's own definition first: a `compose.yaml`/`docker-compose.yml` means starting the services per the apple-containers skill. With no compose file, start what `config/database.yml` and `config/cable.yml` name via `brew services start postgresql@<ver>` (likewise redis). Missing system packages (postgres, redis, libvips…) are machine changes — install them via the setup-environment skill. *Done when `bin/rails db:prepare` exits 0.*

4. **Green boot.** Verify both halves:
   - **Server** — start `bin/dev` (or `bin/rails server`) in the background, then request `/up` (Rails ≥ 7.1; older apps `/`). Green on HTTP 200.
   - **Tests** — `bin/rails test` (or `bundle exec rspec` when `spec/` exists). Green on exit 0; a fresh app's empty suite counts as green.

   *Done when both halves are green. A red half → find it in Blockers, fix, re-run that half.*

## Blockers

| Symptom | Fix |
|---|---|
| `ActiveSupport::MessageEncryptor::InvalidMessage`, missing `RAILS_MASTER_KEY` | The master key is a secret only the user holds — ask for `config/master.key` or the env var. Regenerating credentials replaces the real ones; leave that call to the user. |
| `pg` gem fails to build | Postgres/libpq missing — install via the setup-environment skill. |
| Containerized service misbehaving (won't start, connection refused, docker demanded) | The apple-containers skill owns container troubleshooting. |
| Port 3000 taken | Leave the running process alone; boot on another port (`-p 3001`) and probe that. |
| `.env.example` / `.env.sample` in repo | Copy to `.env`, fill local values (localhost hosts/ports), ask the user for real secrets. |
| Older app wants Node/Yarn (webpacker, jsbundling) | `mise use node@lts`, then install per lockfile (`yarn install` / `npm ci`). |
| `db:prepare` fails on pending data migrations or seeds | Read the failing migration/seed before rerunning — it usually names the service or env var it needs. |
