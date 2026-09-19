---
name: lark-docs
description: >-
  Use this when reading, searching, or importing Feishu/Lark Docs, Wiki, Drive,
  or Bitable via the official Lark OpenAPI MCP — not when editing docs via
  unsupported raw APIs or reimplementing Drive/Docs yourself.
---

# Lark / Feishu docs, Wiki, Drive, Bitable (via official MCP)

## Goal

Use document-related MCP tools from `@larksuiteoapi/lark-mcp`. Upstream notes: **file upload/download** and **direct cloud-doc editing** may be limited; prefer supported import/read/search/Bitable tools.

## Typical MCP tools (defaults may include)

| Tool | Purpose |
| --- | --- |
| `docx.v1.document.rawContent` | Raw text of a Doc |
| `docx.builtin.search` | Search cloud documents |
| `docx.builtin.import` | Import flow (upload / task / result) |
| `wiki.v2.space.getNode` | Wiki node info |
| `wiki.v1.node.search` | Search Wiki |
| `drive.v1.permissionMember.create` | Add collaborator |
| `bitable.v1.app.create` / table / field / record tools | Bitable (Base) |

## Prerequisites

- Scopes such as `docx:document`, `wiki:wiki`, `wiki:wiki:readonly`, `drive:drive`, `docs:document:import`, `bitable:app` as needed.
- Personal docs often need `--oauth --token-mode user_access_token`.

## Agent guidance

1. Prefer MCP tools over ad-hoc HTTP.
2. For Bitable: create app → tables → fields → records in a sensible order.
3. If import/search fails, check Drive/Docs/Bitable scopes and republish.
4. Do not claim full rich-text editing if upstream only supports raw content / import / search.
5. Share links carefully; use permission tools only when the user asks.

## Related

- Setup → skill `lark-setup`
- Notify someone in chat → skill `lark-messaging`
