# Configuration

Names only. Set them in **Plugins → Configure** for a Cursor install, or in an untracked `.env` / your shell for the scripts. Do not commit app secrets.

The manifest schema is `.cursor-plugin/plugin.json` → `variables`. `mcp.json` references plugin variables as `${NAME}`. Cursor substitutes those when it loads the plugin. The shell scripts read the process environment and fall back to `APP_ID` / `APP_SECRET`.

## Names

| Name | Required | Read by | Role |
| --- | --- | --- | --- |
| `LARK_APP_ID` | yes | Manifest, `mcp.json`, `bin/run-lark-mcp.sh`, `bin/login-lark-user.sh` | Custom app id. Passed as `-a`. |
| `LARK_APP_SECRET` | yes | Manifest, `mcp.json`, both scripts | Custom app secret. Passed as `-s`. |
| `LARK_DOMAIN` | no | Manifest, `mcp.json`, both scripts | OpenAPI host. Allowed values are the `enum` on this property in the manifest. When the variable is unset, each script substitutes the fallback written in that script. That fallback matches the manifest `default` today. The strings are separate, so a later edit can make them differ. The app and the host have to belong to the same tenant. |
| `LARK_TOOLS` | no | `bin/run-lark-mcp.sh` | Comma-separated presets or tool names, passed as `-t`. When unset, the script uses `preset.default,preset.task.default,preset.calendar.default`. `mcp.json` does not pass `-t`. |
| `LARK_OAUTH_HOST` | no | `bin/login-lark-user.sh` | Listen host for `lark-mcp login --host`. When unset, the script uses `127.0.0.1`. |
| `LARK_OAUTH_SCOPES` | no | `bin/login-lark-user.sh` | Scope string passed as `--scope`. When unset, the script uses the fallback in that file (listed below). |
| `APP_ID` | no | Both scripts | Used only when `LARK_APP_ID` is unset. This is the upstream name for the app id. The run script exports it to the child process. |
| `APP_SECRET` | no | Both scripts | Used only when `LARK_APP_SECRET` is unset. The run script exports it to the child process. |

`.env.example` includes the first five names. `LARK_OAUTH_SCOPES` is not in that file.

Upstream also documents `LARK_TOKEN_MODE` and `USER_ACCESS_TOKEN`. No file in this repository reads them. The run script sets user identity with the CLI flags `--oauth` and `--token-mode user_access_token`.

Whether Cursor injects the manifest `default` for an empty `LARK_DOMAIN` inside `mcp.json` was not executed in this docs pass. The shell scripts apply that default themselves.

## What each entrypoint passes

| | `mcp.json` | `bin/run-lark-mcp.sh` | `bin/login-lark-user.sh` |
| --- | --- | --- | --- |
| Command | `npx -y @larksuiteoapi/lark-mcp mcp` | same | `npx -y @larksuiteoapi/lark-mcp login` |
| App id / secret | `-a` `${LARK_APP_ID}`, `-s` `${LARK_APP_SECRET}` | `-a` / `-s` from `LARK_APP_ID` or `APP_ID`, and the secret pair | same as the run script |
| Domain | `-d` `${LARK_DOMAIN}` | `-d` from `LARK_DOMAIN` or the script default | same |
| Tools | omitted | `-t` from `LARK_TOOLS` or the script default | omitted |
| User token | omitted | `--oauth` `--token-mode user_access_token` | login flow |
| Host | omitted | omitted | `--host` from `LARK_OAUTH_HOST` or the script default |
| Scopes | omitted | omitted | `--scope` from `LARK_OAUTH_SCOPES` or the script default |
| Extra argv | none | forwarded | forwarded |

`-t` replaces the upstream default tool list. Combining presets is a comma-separated `-t` value. Upstream's CLI reference is [larksuite/lark-openapi-mcp `docs/reference/cli/cli.md`](https://github.com/larksuite/lark-openapi-mcp/blob/main/docs/reference/cli/cli.md). Preset membership is in that repo's `docs/reference/tool-presets/presets.md`.

## Login scopes and redirect

Default for `LARK_OAUTH_SCOPES`, from `bin/login-lark-user.sh`:

`offline_access` `auth:user.id:read` `im:message` `im:message.send_as_user` `im:chat` `im:chat:readonly` `contact:user.base:readonly` `contact:user.id:readonly` `calendar:calendar` `calendar:calendar:readonly` `calendar:calendar.free_busy:read` `task:task:write` `task:task:read` `docs:doc` `docs:doc:readonly` `drive:drive` `drive:drive:readonly` `wiki:wiki` `wiki:wiki:readonly` `bitable:app` `bitable:app:readonly`

The skills name other scope lists (`lark-setup`, `lark-messaging`, `lark-docs`). Those lists guide the agent. They are not the login request unless `LARK_OAUTH_SCOPES` is set to them. Enable the scopes on the custom app and publish the app version before expecting the tools to succeed.

The login script does not pass `--port`. Upstream's `login` command defaults the port to `3000` and the callback path to `/callback`, and it defaults the host to `localhost` when `--host` is omitted. This script always passes `--host`. With `LARK_OAUTH_HOST` unset, register the callback on `127.0.0.1` at that default port. `skills/lark-setup/SKILL.md` and `skills/lark-calendar/SKILL.md` still tell the agent to register the `localhost` callback. Register the host you actually run. To use another port, pass the login command's port flag after the script name (the script forwards extra arguments).

## Files to keep local

| Path | Tracked? |
| --- | --- |
| `.env.example` | yes — names and the domain default only |
| `.env`, `.env.*` | no |
| `.local/` | no |
| `mcp-runtime.json` | no — listed in `.gitignore` only; nothing in this repo writes it |
| `node_modules/`, `*.log` | no |
