# Lark / Feishu OpenAPI — Cursor Plugin

Cursor plugin for people who want an agent to use **their own** Lark (international) or Feishu (China) custom app. It starts the official [`@larksuiteoapi/lark-mcp`](https://www.npmjs.com/package/@larksuiteoapi/lark-mcp) stdio server and adds skills for setup, messaging, calendar, and docs. It does not reimplement Lark HTTP APIs and it does not share one tenant across installers.

| | |
| --- | --- |
| Plugin name | `lark-openapi` |
| Display name | Lark / Feishu OpenAPI MCP |
| Manifest version | `0.1.0` (`.cursor-plugin/plugin.json`) |
| Publisher | `xco-agency` ([XCO Agency](https://xco.agency)) |
| Package | [`@larksuiteoapi/lark-mcp`](https://www.npmjs.com/package/@larksuiteoapi/lark-mcp) |
| Upstream | [larksuite/lark-openapi-mcp](https://github.com/larksuite/lark-openapi-mcp) |

Grok Bot and other Cursor agents that add an MCP server by command use [INSTALL-GROKBOT.md](./INSTALL-GROKBOT.md).

## What it ships

Cursor discovers components from the default folders. This repository contains:

| Path | Role |
| --- | --- |
| `.cursor-plugin/plugin.json` | Cursor plugin manifest: identity, logo, and the variable schema |
| `mcp.json` | One stdio MCP server, named `lark-openapi` |
| `skills/lark-setup/SKILL.md` | Custom app, host, credentials, scopes, OAuth, stdio install |
| `skills/lark-messaging/SKILL.md` | Chats and messages through the official IM tools |
| `skills/lark-calendar/SKILL.md` | Calendar tools, which need an explicit tool preset |
| `skills/lark-docs/SKILL.md` | Docs, Wiki, Drive, and Bitable read, search, and import |
| `bin/run-lark-mcp.sh` | Local stdio launch with tool presets and user OAuth |
| `bin/login-lark-user.sh` | One-time user OAuth login |
| `assets/logo.svg` | Logo referenced by the manifest |
| `.env.example` | Variable names for a local, untracked `.env` |
| `INSTALL-GROKBOT.md` | `AddMcpServer` field list for Grok Bot |
| `CHANGELOG.md` | Release notes for manifest `0.1.0` |

The manifest also sets `keywords`, `category` (`mcp`), `tags`, `homepage`, `repository`, `license`, and `author`. It does not set custom `skills`, `rules`, `agents`, `commands`, `hooks`, or `mcpServers` paths, so Cursor's folder discovery applies.

Also in the tree, and not plugin components: `LICENSE`, this README, and [docs/configuration.md](./docs/configuration.md).

These Cursor plugin locations are empty in this repository: `rules/`, `agents/`, `commands/`, `hooks/`. There is no root `plugin.json` (this is a Cursor plugin, with the manifest under `.cursor-plugin/`), no `.cursor-plugin/marketplace.json` (that file is for a multi-plugin repository), no `package.json`, no `CLAUDE.md`, and no `AGENTS.md`. Tasks are named in the manifest description and in the helper's default `LARK_TOOLS` preset. There is no tasks skill.

The installed server shows up in Cursor approval prompts as `plugin-lark-openapi-lark-openapi` (plugin name, then the server name from `mcp.json`). See [Plugins](https://cursor.com/docs/plugins).

## Requirements

- Node.js 20 or newer. The setup skill and [Lark's MCP install guide](https://open.larksuite.com/document/uAjLw4CM/ukTMukTMukTM/mcp_integration/mcp_installation) both say this. This repository has no `package.json` `engines` field.
- A custom app on the OpenAPI host that matches the tenant. The host is `LARK_DOMAIN`. The allowed values are the `enum` on that variable in `.cursor-plugin/plugin.json`.
- `LARK_APP_ID` and `LARK_APP_SECRET` from that app. Keep the secret out of git. `.env` is gitignored.

## Install and configure in Cursor

### Marketplace

When the plugin is available to you:

1. Open **Customize** in the sidebar.
2. Install **lark-openapi** and choose a user or project scope.
3. Open **Plugins → Configure** and set the variables declared in the manifest.

Values live in that Cursor configuration. The repository only stores the names. A fetch of the public marketplace homepage during this docs pass listed a different plugin, Lark Base, and did not show this plugin's display name. Treat a marketplace install as available only after you can see `lark-openapi` in Customize.

Team distribution is a separate step: a team admin imports a marketplace or adds a reviewed plugin under **Dashboard → Plugins & MCPs**. This repository is a single plugin at the repo root.

### Load a checkout locally

Cursor discovers unpacked plugins in `~/.cursor/plugins/local/<folder>` after a reload, when local plugin imports are allowed.

1. Copy this repository into `~/.cursor/plugins/local/lark-openapi`. Include `.cursor-plugin/plugin.json`.
2. Restart Cursor, or run **Developer: Reload Window**.
3. Open **Customize** and confirm the four skills and the `lark-openapi` MCP server.
4. Set `LARK_APP_ID`, `LARK_APP_SECRET`, and, when you need a host other than the manifest default, `LARK_DOMAIN`.

Cursor skips a symlink under `~/.cursor/plugins/local` when the target sits outside that folder. On Enterprise, local imports follow **Allow Local Plugin Imports** (Dashboard → Settings → Security & Identity → Marketplace and Plugins), which is off by default. A marketplace install of the same plugin name takes precedence over the local copy.

### Custom MCP entry

`mcp.json` is the server definition the plugin loads:

- command `npx`
- args `-y`, `@larksuiteoapi/lark-mcp`, `mcp`, `-a`, `${LARK_APP_ID}`, `-s`, `${LARK_APP_SECRET}`, `-d`, `${LARK_DOMAIN}`
- env `LARK_APP_ID`, `LARK_APP_SECRET`, `LARK_DOMAIN` set to those same placeholders

`${LARK_APP_ID}`, `${LARK_APP_SECRET}`, and `${LARK_DOMAIN}` are plugin variables. Cursor fills them when it loads this plugin. A hand-added MCP server needs those names in its own environment. Do not paste secret values into a committed config. Grok Bot field names are in [INSTALL-GROKBOT.md](./INSTALL-GROKBOT.md).

## Settings

Every name this repository reads. Purposes, which file reads each name, and the script defaults are in [docs/configuration.md](./docs/configuration.md).

| Name | Required | Where it is read |
| --- | --- | --- |
| `LARK_APP_ID` | yes | Manifest, `mcp.json`, both scripts |
| `LARK_APP_SECRET` | yes | Manifest, `mcp.json`, both scripts |
| `LARK_DOMAIN` | no | Manifest (default and enum), `mcp.json`, both scripts |
| `LARK_TOOLS` | no | `bin/run-lark-mcp.sh` only |
| `LARK_OAUTH_HOST` | no | `bin/login-lark-user.sh` only |
| `LARK_OAUTH_SCOPES` | no | `bin/login-lark-user.sh` only |
| `APP_ID` | no | Both scripts, as a fallback for `LARK_APP_ID` |
| `APP_SECRET` | no | Both scripts, as a fallback for `LARK_APP_SECRET` |

`.env.example` lists `LARK_APP_ID`, `LARK_APP_SECRET`, `LARK_DOMAIN`, `LARK_TOOLS`, and `LARK_OAUTH_HOST`. `LARK_OAUTH_SCOPES` is read by the login script and is not in that example.

Create the custom app in the developer console for the same host as `LARK_DOMAIN`. Enable **Bot** when the agent sends messages as the app. Grant the scopes the tools need, then publish the app version so the grants apply. The setup skill names a starting scope list. The login script requests `LARK_OAUTH_SCOPES` instead, and its built-in default is in `bin/login-lark-user.sh`.

## How the server is launched

**Plugin path (`mcp.json`).** The server process receives the app id, app secret, and domain. Tool choice and token mode are the upstream defaults for an `mcp` invocation that omits `-t` and `--token-mode`. Upstream's docs call those defaults `preset.default` and `auto`. This repo always runs `npx -y` and does not pin `@larksuiteoapi/lark-mcp`, so those defaults are whatever version npx installs.

**Helper (`bin/run-lark-mcp.sh`).** Same credentials and domain. It also passes `-t` from `LARK_TOOLS` and always passes `--oauth` and `--token-mode user_access_token`. With `LARK_TOOLS` unset, the script's own default is `preset.default,preset.task.default,preset.calendar.default`. Upstream treats `-t` as a full replacement of the default tool list. Extra arguments after the script name are forwarded.

**Login (`bin/login-lark-user.sh`).** Runs `lark-mcp login` with the app id, secret, domain, `--host` from `LARK_OAUTH_HOST`, and `--scope` from `LARK_OAUTH_SCOPES`. It does not pass a port. Extra arguments are forwarded. Run this before the helper when calls must use the logged-in user. Register the OAuth redirect for the host you set. Details are in [docs/configuration.md](./docs/configuration.md).

With the required variables unset, both scripts exit 1 and print which names to set.

## Skills

| Skill | Use it for |
| --- | --- |
| `lark-setup` | Creating the custom app, picking the host, scopes, OAuth, and the stdio install |
| `lark-messaging` | Sending or listing messages, creating or listing chats, resolving user ids |
| `lark-calendar` | Calendar events. The skill expects `preset.calendar.default` (or named tools) because a minimal tool list can omit calendar |
| `lark-docs` | Docs, Wiki, Drive, and Bitable. The skill says file upload/download and direct cloud-doc editing may be limited upstream |

Invoke a skill with `/skill-name` in chat, or let the agent select it. The calendar skill asks the agent to confirm the timezone with the user before scheduling.

## Develop and test locally

There is no test runner and no CI config in this repository. A local check is:

1. Copy `.env.example` to `.env` and export the names in your shell. Leave `.env` untracked.
2. `bash -n bin/run-lark-mcp.sh` and `bash -n bin/login-lark-user.sh`.
3. Run each script with `LARK_APP_ID`, `LARK_APP_SECRET`, `APP_ID`, and `APP_SECRET` unset. Each exits 1 with its usage line.
4. Export the required names, run `./bin/login-lark-user.sh`, complete the browser authorize step, then run `./bin/run-lark-mcp.sh`. The run script speaks MCP over stdio and waits.
5. Copy the tree into `~/.cursor/plugins/local/lark-openapi`, reload Cursor, and confirm the skills and the MCP server in **Customize**.

Gitignored local files: `.env` and `.env.*` (`.env.example` stays tracked), `.local/`, `mcp-runtime.json`, `*.log`, and `node_modules/`. No file in this repository writes `mcp-runtime.json`. It is only ignored.

This docs pass ran the syntax check and the unset-variable check. It did not complete a live Lark login, and it did not reload Cursor.

## Releases and publishing

Nothing in the repo publishes itself. There is no `.github/` workflow and no release script.

The version Cursor and the changelog share today is the `version` field in `.cursor-plugin/plugin.json`, which is `0.1.0`. `CHANGELOG.md` has a `0.1.0` section for that release.

Git history is ahead of that label:

| Identifier | What it points at |
| --- | --- |
| Manifest `version` | `0.1.0` on current `main` and on the tag below |
| Git tag `0.1.1` | Commit `3ba676c` (2026-09-19, marketplace logo). Current `main` is one commit later (`52f3558`, logo replacement) and is untagged |
| GitHub Release | Title `0.0.1`, attached to tag `0.1.1`, published 2026-09-19, no release assets. The body is a link to the commits on that tag |

Those three numbers were not updated together. This repository does not explain the difference.

Cursor's publish path for a plugin like this one is manual: a public Git repository, then submit the repository at [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish). The Cursor team reviews it before it is listed. Submission expects a valid `.cursor-plugin/plugin.json`, a unique kebab-case `name`, a README that covers usage and configuration, relative paths, a committed logo when `logo` is set, and every `${VAR}` from `mcp.json` declared under `variables`. This repo already declares `LARK_APP_ID`, `LARK_APP_SECRET`, and `LARK_DOMAIN`.

A later release means editing `version` and `CHANGELOG.md`, tagging, publishing or updating the GitHub Release, and submitting or refreshing the marketplace review. This documentation change does not bump the version or move the tag.

## License

MIT. See [LICENSE](./LICENSE). The copyright line there is Anass Ez-zouaine (ansezz). The manifest `author` is XCO Agency. `@larksuiteoapi/lark-mcp` stays under Lark Suite's package license.
