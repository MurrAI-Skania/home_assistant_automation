#!/usr/bin/env bash
set -euo pipefail

REMOTE="ha-server"
DST="./ha_config/"
SRC="/config/"

# Pull curated config from HA into your repo folder.
# Uses --delete so your local curated folder matches HA's curated subset.
rsync -av --delete \
  --no-owner --no-group --no-perms \
  --exclude 'secrets.yaml' \
  --exclude '*.db*' \
  --exclude '*.log*' \
  --exclude '.storage/**' \
  --exclude '/custom_components/' --exclude '/custom_components/**' \
  --exclude '/www/community/' --exclude '/www/community/**' \
  --exclude '/www/tapo_control/' --exclude '/www/tapo_control/**' \
  "${REMOTE}:${SRC}" "$DST"

echo "✅ Pulled curated HA config from ${REMOTE}:${SRC} -> ${DST}"
