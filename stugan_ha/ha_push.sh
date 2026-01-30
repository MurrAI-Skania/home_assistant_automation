#!/usr/bin/env bash
set -euo pipefail

REMOTE="ha-server"
SRC="./ha_config/"
DST="/config/"

rsync -av --delete \
  --no-owner --no-group --no-perms \
  --exclude 'secrets.yaml' \
  --exclude '*.db*' \
  --exclude '*.log*' \
  --exclude '.storage/**' \
  --exclude '/custom_components/' --exclude '/custom_components/**' \
  --exclude '/www/community/' --exclude '/www/community/**' \
  --exclude '/www/tapo_control/' --exclude '/www/tapo_control/**' \
  "$SRC" "${REMOTE}:${DST}"

echo "✅ Pushed curated HA config to ${REMOTE}:${DST}"
