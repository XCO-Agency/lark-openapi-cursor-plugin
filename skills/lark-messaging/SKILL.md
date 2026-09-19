---
name: lark-messaging
description: >-
  Use this when sending or listing Feishu/Lark messages, creating chats,
  listing chat members, or resolving user IDs via the official Lark OpenAPI MCP
  (IM tools / preset.im.default) — not when calling raw HTTP yourself.
---

# Lark / Feishu messaging (via official MCP)

## Goal

Use MCP IM tools from `@larksuiteoapi/lark-mcp` for chats and messages. Prefer the connected MCP server over hand-written OpenAPI calls.

## Typical MCP tools (defaults may include)

| Tool | Purpose |
| --- | --- |
| `im.v1.message.create` | Send a message |
| `im.v1.message.list` | Conversation history |
| `im.v1.chat.create` | Create a group |
| `im.v1.chat.list` | List groups |
| `im.v1.chatMembers.get` | List members |
| `contact.v3.user.batchGetId` | Resolve user ID by email/phone |

Enable bulk IM tools with `-t preset.im.default` (overrides full default set).

## Prerequisites

- App has **Bot** capability if acting as bot.
- Scopes: at least `im:message`, `im:chat`, `im:chat:create` as needed; `contact:user.id:readonly` for ID lookup.
- For “as the logged-in user”: `--oauth --token-mode user_access_token` after `login`.

## Agent guidance

1. Resolve receive IDs (open_id / user_id / chat_id) before send — use contact batch-get when the user gives email/phone.
2. Confirm chat vs DM target; do not spam unknown users.
3. If the tool returns a permission URL, ask the user to enable scopes and republish.
4. Do not invent API payloads when MCP tools are available — call the MCP tool.

## Related

- Setup / domain / OAuth → skill `lark-setup`
- Docs / Bitable / Wiki → skill `lark-docs`
