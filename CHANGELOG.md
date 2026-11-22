# Changelog

## Unreleased

- Document the plugin layout, every setting name, local checks, and the manual release path in `README.md`, `docs/configuration.md`, and `INSTALL-GROKBOT.md`.
- Record that `mcp.json` passes app id, secret, and domain only, and that tool presets plus user OAuth are on `bin/run-lark-mcp.sh`.
- Record that manifest `0.1.0`, git tag `0.1.1`, and GitHub Release title `0.0.1` are different identifiers.

## 0.1.0

- Initial public release under XCO Agency
- Wraps official `@larksuiteoapi/lark-mcp`
- Plugin variables for App ID / Secret / domain
- Skills: setup, messaging, calendar, docs
- Helper scripts for MCP launch and user OAuth (`127.0.0.1` callback)
