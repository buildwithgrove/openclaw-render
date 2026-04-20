#!/usr/bin/env bash
# Boot-time seeding for the Render deployment.
#
# Runs on every container start. Idempotent and non-blocking:
#   - `openclaw config set` only writes the specified path, so Control-UI edits
#     and on-disk state survive untouched.
#   - Failures in install/config steps are logged but do not block the proxy.
#
# Override behavior via render.yaml envs without editing this script:
#   OPENCLAW_SEED_SKILLS       — space-separated ClawHub slugs (default: "grove")
#   OPENCLAW_SEED_SKIP_INSTALL — set to "1" to skip ClawHub installs this boot

set -o pipefail

log()  { printf '[seed] %s\n' "$*"; }
warn() { printf '[seed][warn] %s\n' "$*" >&2; }

state_dir="${OPENCLAW_STATE_DIR:-/data/.openclaw}"
workspace_dir="${OPENCLAW_WORKSPACE_DIR:-/data/workspace}"
mkdir -p "$state_dir" "$workspace_dir"

seed_skills="${OPENCLAW_SEED_SKILLS:-grove}"

if [ -z "$seed_skills" ]; then
  log "no skills to seed — skipping"
else
  # Install from ClawHub (idempotent; skipped without a token).
  if [ "${OPENCLAW_SEED_SKIP_INSTALL:-0}" = "1" ]; then
    log "OPENCLAW_SEED_SKIP_INSTALL=1 — skipping ClawHub installs"
  elif [ -z "${OPENCLAW_CLAWHUB_TOKEN:-}" ]; then
    log "OPENCLAW_CLAWHUB_TOKEN unset — skipping ClawHub installs"
  else
    for slug in $seed_skills; do
      log "installing ClawHub skill: $slug"
      if ! openclaw skills install "$slug" 2>&1 | sed 's/^/[seed] /'; then
        warn "install failed for $slug — continuing"
      fi
    done
  fi

  # Mark each seed skill enabled in openclaw.json (declarative; re-applied every boot).
  for slug in $seed_skills; do
    log "enabling skill: $slug"
    if ! openclaw config set "skills.entries.$slug.enabled" true --strict-json 2>&1 | sed 's/^/[seed] /'; then
      warn "enable failed for $slug — continuing"
    fi
  done
fi

log "seed complete — launching proxy"
exec /usr/local/bin/proxy "$@"
