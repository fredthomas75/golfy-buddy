#!/usr/bin/env bash
# Render build script — https://render.com/docs/deploy-rails
# rails is invoked via the ./bin/rails binstub (robust regardless of how
# `bundle exec` resolves gem executables in the build image).
set -o errexit

bundle install
yarn install --frozen-lockfile

# esbuild (JS) + Dart Sass (CSS) run automatically inside assets:precompile.
./bin/rails assets:precompile
./bin/rails assets:clean

# Run migrations against the DIRECT Supabase connection (port 5432), NOT the
# transaction pooler. Set MIGRATE_DATABASE_URL in the Render dashboard; it falls
# back to DATABASE_URL if unset.
DATABASE_URL="${MIGRATE_DATABASE_URL:-$DATABASE_URL}" ./bin/rails db:migrate
