#!/usr/bin/env bash
# SessionStart hook for Claude Code (web) — bootstraps the dev environment so
# tests/linters/server can run immediately. Every step is best-effort: a hiccup
# must never block the session.
set +e

# 1. Start PostgreSQL if it isn't already accepting connections.
pg_isready -q 2>/dev/null || service postgresql start >/dev/null 2>&1 || true

# 2. Ensure a 'root' Postgres superuser exists (local socket / peer auth).
sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname='root'" 2>/dev/null | grep -q 1 \
  || sudo -u postgres psql -c "CREATE ROLE root SUPERUSER LOGIN;" >/dev/null 2>&1 || true

# 3. Install dependencies (no-ops when already satisfied).
bundle check >/dev/null 2>&1 || bundle install
[ -d node_modules ] || yarn install --frozen-lockfile

echo "golfy-buddy: postgres up, gems + node deps ready"
