#!/bin/bash
# Restore OpenClaw from GitHub backup
# Lists available branches numbered so you just pick one

set -e

REPO="https://github.com/silmarilclaw/clawbackup.git"
DEST="$HOME/.openclaw"
SHARED="$HOME/Documents/OpenClaw"

echo "Fetching available backups..."
BRANCHES=$(git ls-remote --heads "$REPO" 2>/dev/null | awk '{print $2}' | sed 's|refs/heads/||' | sort -r)

if [ -z "$BRANCHES" ]; then
  echo "No branches found in $REPO"
  exit 1
fi

# Number them
i=1
declare -a BRANCH_LIST
echo ""
echo "Available backups:"
echo "─────────────────────"
while IFS= read -r branch; do
  printf "  %2d) %s\n" "$i" "$branch"
  BRANCH_LIST+=("$branch")
  ((i++))
done <<< "$BRANCHES"
echo ""

read -p "Pick a number (or q to quit): " CHOICE

if [[ "$CHOICE" == "q" || -z "$CHOICE" ]]; then
  echo "Cancelled."
  exit 0
fi

if ! [[ "$CHOICE" =~ ^[0-9]+$ ]] || [ "$CHOICE" -lt 1 ] || [ "$CHOICE" -gt "${#BRANCH_LIST[@]}" ]; then
  echo "Invalid choice."
  exit 1
fi

SELECTED="${BRANCH_LIST[$((CHOICE-1))]}"
echo ""
echo "Restoring from: $SELECTED"
echo ""

# Fetch into existing repo or clone fresh
cd "$DEST"

if git remote get-url backup &>/dev/null; then
  git fetch backup
else
  git remote add backup "$REPO"
  git fetch backup
fi

# Restore workspace files from the selected branch
git checkout "backup/$SELECTED" -- . 2>&1

# If there's a shared-backup folder, restore shared files
if [ -d shared-backup ]; then
  mkdir -p "$SHARED"
  cp -rL shared-backup/* "$SHARED/" 2>/dev/null || true
  echo "Restored shared files to $SHARED"
fi

echo ""
echo "✅ Restored from '$SELECTED'. Restart OpenClaw to pick up changes."
