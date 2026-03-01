# OpenClaw Backup Restore Guide

## Full Restore (new machine or after a wipe)

```bash
# 1. Install OpenClaw
npm i -g openclaw

# 2. Clone this backup
git clone git@github.com:silmarilclaw/clawbackup.git ~/.openclaw

# 3. Restore shared files
mkdir -p ~/Documents/OpenClaw
cp -r ~/.openclaw/shared-backup/* ~/Documents/OpenClaw/

# 4. Recreate symlinks in agent workspaces
cd ~/.openclaw/agents/main/workspace
ln -sf /Users/silclaw/Documents/OpenClaw shared
ln -sf shared/MEMORY.md MEMORY.md
ln -sf shared/TOOLS.md TOOLS.md
ln -sf shared/USER.md USER.md
ln -sf shared/memory memory

# 5. Remove restore artifacts
rm -rf ~/.openclaw/.git ~/.openclaw/shared-backup

# 6. Start the gateway
openclaw gateway start
```

## Partial Restore (just config or workspace)

- Config only: copy `openclaw.json` to `~/.openclaw/`
- Workspace only: copy `agents/main/workspace/` contents
- Memory only: copy `shared-backup/` to `~/Documents/OpenClaw/`

## What's NOT backed up

- **Sessions** — conversation history (large, regenerated)
- **Logs** — runtime logs
- **Credentials** — API keys in `credentials/` (backed up, but re-auth may be needed)
- **Device pairings** — `devices/` and `identity/` (re-pair after restore)

## Notes

- `shared-backup/` is a flat copy of `~/Documents/OpenClaw/` (the symlink target)
- Identity/device files are included but pairings may need refresh
- Telegram bot sessions may need re-auth
