---
name: lark-setup
description: >-
  Use this when setting up Feishu/Lark OpenAPI MCP in Cursor or Grok Bot —
  creating a custom app, choosing open.larksuite.com vs open.feishu.cn,
  configuring App ID/Secret, OAuth redirect, scopes, and stdio npx install.
---

# Lark / Feishu MCP setup

## Goal

Get the **official** `@larksuiteoapi/lark-mcp` stdio server running. Do not reimplement Lark HTTP APIs.

## Steps

1. **Pick domain**
   - International Lark → `https://open.larksuite.com`
   - Feishu China → `https://open.feishu.cn`
   - App and domain must match.

2. **Create custom app** in the matching developer console; copy App ID and App Secret.

3. **Capabilities & scopes** — enable Bot if sending messages; grant scopes for the tools you will use. Default MCP set often needs:
   `im:chat:create, im:chat, im:message, wiki:wiki, wiki:wiki:readonly, docx:document, bitable:app, drive:drive, docs:document:import, contact:user.id:readonly`

4. **OAuth (optional, user identity)** — Redirect URL: `http://localhost:3000/callback`. Then:
   ```bash
   npx -y @larksuiteoapi/lark-mcp login -a <APP_ID> -s <APP_SECRET> -d <DOMAIN>/
   ```
   MCP args: `--oauth --token-mode user_access_token`

5. **Publish** the app version so permissions take effect.

6. **Run MCP**
   ```bash
   npx -y @larksuiteoapi/lark-mcp mcp -a <APP_ID> -s <APP_SECRET> -d <DOMAIN>
   ```
   Prefer env: `LARK_APP_ID`, `LARK_APP_SECRET`, `LARK_DOMAIN` — never commit secrets.

7. **Cursor** — use this plugin’s `mcp.json` + variables, or Add Custom MCP with the same command/args.

8. **Grok Bot** — see `INSTALL-GROKBOT.md` (`AddMcpServer`, command `npx`, args, env).

## Tool presets

`-t` replaces defaults. Example: `-t preset.im.default,preset.calendar.default` or individual tool names. See upstream preset docs.

## Troubleshooting

- Missing permission → enable scope, republish; for user token, re-login after new user scopes.
- Wrong domain → recreate/use app on the correct open platform.
- Node &lt; 20 → upgrade Node.js.
