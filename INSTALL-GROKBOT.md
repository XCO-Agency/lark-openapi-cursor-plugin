# Install on Grok Bot / Cursor agents

Use the official package. Do not paste App Secrets into chats.

## AddMcpServer

| Field | Value |
| --- | --- |
| name | `lark-openapi` |
| command | `npx` |
| args | `-y` `@larksuiteoapi/lark-mcp` `mcp` `-a` `${LARK_APP_ID}` `-s` `${LARK_APP_SECRET}` `-d` `${LARK_DOMAIN}` |
| env | `LARK_APP_ID`, `LARK_APP_SECRET`, optional `LARK_DOMAIN` |

Optional: `-t` `preset.default,preset.task.default,preset.calendar.default`, `--oauth`, `--token-mode` `user_access_token`.

Or run `bin/run-lark-mcp.sh` after exporting the same env vars.

## User login

```bash
./bin/login-lark-user.sh
```

Redirect URL must include `http://127.0.0.1:3000/callback`.
