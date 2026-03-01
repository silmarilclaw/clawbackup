#!/bin/bash
# OpenClaw automated backup
# Pushes to main + a date-based branch

set -e

REPO="$HOME/.openclaw"
SHARED="$HOME/Documents/OpenClaw"
DATE=$(date +%Y-%m-%d)
BRANCH="backup/$DATE"

cd "$REPO"

# Update shared-backup with latest shared files
rm -rf shared-backup
mkdir -p shared-backup
cp -rL "$SHARED"/* shared-backup/ 2>/dev/null || true

# Stage everything
git add -A

# Skip if nothing changed
if git diff --cached --quiet 2>/dev/null; then
  echo "No changes to backup"
  exit 0
fi

# Commit on main
git commit -m "backup $DATE $(date +%H:%M)"

# Push main
git push origin main

# Create/update date branch
git branch -f "$BRANCH" main
git push origin "$BRANCH" --force

echo "Backed up to main + $BRANCH"
