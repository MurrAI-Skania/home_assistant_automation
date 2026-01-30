# home_assistant_automation

# Safe push
rsync -av \
  --exclude 'secrets.yaml' \
  --exclude '*.db*' \
  --exclude '*.log*' \
  --exclude '.storage/**' \
  ./ha_config/ ha-server:/config/

# enforce exact match
rsync -av --delete \
  --exclude 'secrets.yaml' \
  --exclude '*.db*' \
  --exclude '*.log*' \
  --exclude '.storage/**' \
  ./ha_config/ ha-server:/config/


