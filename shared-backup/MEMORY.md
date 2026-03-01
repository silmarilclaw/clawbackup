# MEMORY.md - Shared Agent Memory

## System Setup (2026-02-13)
- Three-agent system: Link (main/webchat), Zelda (thinking/Telegram), Ganondorf (spawn-only/max power)
- Gateway runs on Mac mini de SilClaw (192.168.7.101)
- Manuel's main machine: Mac Studio (MacManu)
- Shared workspace via symlinks at `/Users/silclaw/Documents/OpenClaw/`
- Link upgraded from Sonnet 4 → Opus 4 per Manuel's request

## Preferences
- Manuel values directness and honesty
- "Ganon" = "Ganondorf"
- Timezone: Europe/Madrid (GMT+1)

## Key Events
- 2026-02-13: Initial multi-agent setup completed. Config patching issue wiped agent list (fixed). Silmaril Technologies analysis completed by Ganondorf.
- 2026-02-13: Link upgraded to Opus 4. Zelda/Ganondorf deleted and recreated fresh due to persistent session path errors. New Telegram bot created. Zelda agent id changed from "thinking" to "zelda".

## Key Lessons
- `config.patch` on `agents.list` replaces the entire array — always include all agents
- Telegram `channels.telegram.accounts` can hold stale bot configs
- Session stores with missing .jsonl files cause "path must be within sessions directory" errors
