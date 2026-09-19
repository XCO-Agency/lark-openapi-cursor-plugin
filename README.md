# Lark / Feishu OpenAPI — Cursor Plugin

**Publisher:** [XCO Agency](https://xco.agency) (Shopify Plus Partner)

Cursor marketplace plugin that wraps the **official** Feishu/Lark OpenAPI MCP. It does **not** reimplement Lark APIs.

- Package: [`@larksuiteoapi/lark-mcp`](https://www.npmjs.com/package/@larksuiteoapi/lark-mcp)
- Upstream: [larksuite/lark-openapi-mcp](https://github.com/larksuite/lark-openapi-mcp)
- Docs: [MCP installation](https://open.larksuite.com/document/uAjLw4CM/ukTMukTMukTM/mcp_integration/mcp_installation)

## What you get

- `mcp.json` — stdio MCP via `npx -y @larksuiteoapi/lark-mcp`
- Skills: setup, messaging, calendar, docs
- Optional helpers: `bin/run-lark-mcp.sh`, `bin/login-lark-user.sh`

Each installer uses **their own** Lark or Feishu custom app credentials. No shared tenant.

## Requirements

- Node.js ≥ 20
- Custom app on **Lark** (`https://open.larksuite.com`) or **Feishu** (`https://open.feishu.cn`)
- App ID + App Secret

## Create your app (quick)

1. Developer Console → Custom App → note App ID / App Secret.
2. Enable **Bot** if you want app-bot messaging.
3. Add API scopes your tools need. For send-as-user DMs you need at least:
   - `im:message`
   - `im:message.send_as_user`
   - plus chat/calendar/task/docs scopes as required
4. Security → Redirect URLs — add both if you use OAuth helpers:
   - `http://127.0.0.1:3000/callback`
   - `http://localhost:3000/callback`
5. Publish / approve the app version as your org requires.

Never commit App Secret.

## Install

### Cursor Marketplace (after listing)

Install **lark-openapi**, then configure plugin variables:

| Variable | Required | Notes |
| --- | --- | --- |
| `LARK_APP_ID` | yes | From developer console |
| `LARK_APP_SECRET` | yes | Secret |
| `LARK_DOMAIN` | no | Default `https://open.larksuite.com` |

### Manual MCP

```json
{
  "mcpServers": {
    "lark-openapi": {
      "command": "npx",
      "args": [
        "-y",
        "@larksuiteoapi/lark-mcp",
        "mcp",
        "-a", "${LARK_APP_ID}",
        "-s", "${LARK_APP_SECRET}",
        "-d", "${LARK_DOMAIN}"
      ],
      "env": {
        "LARK_APP_ID": "${LARK_APP_ID}",
        "LARK_APP_SECRET": "${LARK_APP_SECRET}",
        "LARK_DOMAIN": "${LARK_DOMAIN}"
      }
    }
  }
}
```

### User OAuth (send / act as the logged-in user)

```bash
export LARK_APP_ID=... LARK_APP_SECRET=... LARK_DOMAIN=https://open.larksuite.com
./bin/login-lark-user.sh
# open the printed authorize URL, click Authorize
```

Then run MCP with `--oauth --token-mode user_access_token` (see `bin/run-lark-mcp.sh`).

Tip: bind OAuth to `127.0.0.1` (default in our login script) so Chromium can complete the callback on IPv4.

## Tool presets

Default helper enables `preset.default`, `preset.task.default`, and `preset.calendar.default` via `LARK_TOOLS`.

## License

MIT — see [LICENSE](./LICENSE). Official MCP remains under Lark Suite’s package license.

## About XCO Agency

[XCO Agency](https://xco.agency) — Shopify Plus Partner. Built and maintained for the Cursor / agent ecosystem.
