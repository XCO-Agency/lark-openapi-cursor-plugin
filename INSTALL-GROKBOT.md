# Install on Grok Bot / Cursor agents

Use the official package `@larksuiteoapi/lark-mcp`. Put `LARK_APP_ID` and `LARK_APP_SECRET` in the environment or in the agent's secret store. Do not paste the secret into a chat.

This file is the only description of `AddMcpServer` in the repository.

## AddMcpServer

Matches `mcp.json`. This entry passes the app id, app secret, and domain. Tool presets and user OAuth are not part of it.

| Field | Value |
| --- | --- |
| name | `lark-openapi` |
| command | `npx` |
| args | `-y` `@larksuiteoapi/lark-mcp` `mcp` `-a` `${LARK_APP_ID}` `-s` `${LARK_APP_SECRET}` `-d` `${LARK_DOMAIN}` |
| env | `LARK_APP_ID`, `LARK_APP_SECRET`, `LARK_DOMAIN` |

`LARK_APP_ID` and `LARK_APP_SECRET` are required. `LARK_DOMAIN` is optional. Its allowed values are the manifest `enum`, and its default is the manifest `default`, both in `.cursor-plugin/plugin.json`. Setting names are listed in [docs/configuration.md](./docs/configuration.md).

## User identity and extra tools

`bin/run-lark-mcp.sh` is a different launch. It adds `-t` from `LARK_TOOLS` and always adds `--oauth` and `--token-mode user_access_token`. Use it after exporting the same credential names, when calls must run as the logged-in user or must include the task and calendar presets.

Log in once:

```bash
./bin/login-lark-user.sh
```

The script listens on `LARK_OAUTH_HOST` (default `127.0.0.1`) and does not set a port. Upstream `lark-mcp login` uses port `3000` and the path `/callback` unless you pass a port flag through to the script. The redirect URL registered on the app has to match that host.
