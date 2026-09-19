---
name: lark-calendar
description: >-
  Use this when scheduling, listing, or managing Feishu/Lark calendar events
  through the official Lark OpenAPI MCP (e.g. -t preset.calendar.default) —
  not when reimplementing Calendar OpenAPI by hand.
---

# Lark / Feishu calendar (via official MCP)

## Goal

Use calendar-related tools exposed by `@larksuiteoapi/lark-mcp`. Calendar APIs are often **not** in the minimal default set — enable them explicitly.

## Enable calendar tools

Override tools with `-t`, for example:

```bash
npx -y @larksuiteoapi/lark-mcp mcp -a <APP_ID> -s <APP_SECRET> \
  -t preset.calendar.default
```

You can combine presets/tools (comma-separated). Remember: `-t` **fully replaces** the default tool list.

## Prerequisites

- App scopes for Calendar APIs you will call (check each tool’s required permissions in Lark/Feishu docs).
- User-facing calendars usually need **user** identity: `login` + `--oauth --token-mode user_access_token`.
- Redirect URL: `http://localhost:3000/callback`.

## Agent guidance

1. Confirm timezone with the user (this user’s zone is often Asia/Kuala_Lumpur / UTC+8 unless they specify otherwise).
2. Prefer MCP calendar tools; do not invent REST clients.
3. If a tool is missing from the connected server, tell the user to add `-t preset.calendar.default` (or specific tool names) and restart MCP.
4. After adding user scopes, republish the app and re-run `login` if using user tokens.

## Related

- Install / OAuth → skill `lark-setup`
- Messaging invites follow-ups → skill `lark-messaging`
