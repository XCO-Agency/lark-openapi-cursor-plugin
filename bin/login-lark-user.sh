#!/usr/bin/env bash
# One-time OAuth login (saves user_access_token locally for lark-mcp).
# Prefer --host 127.0.0.1 so Chromium callback works on IPv4.
set -euo pipefail
APP_ID="${LARK_APP_ID:-${APP_ID:-}}"
APP_SECRET="${LARK_APP_SECRET:-${APP_SECRET:-}}"
DOMAIN="${LARK_DOMAIN:-https://open.larksuite.com}"
HOST="${LARK_OAUTH_HOST:-127.0.0.1}"
SCOPES="${LARK_OAUTH_SCOPES:-offline_access auth:user.id:read im:message im:message.send_as_user im:chat im:chat:readonly contact:user.base:readonly contact:user.id:readonly calendar:calendar calendar:calendar:readonly calendar:calendar.free_busy:read task:task:write task:task:read docs:doc docs:doc:readonly drive:drive drive:drive:readonly wiki:wiki wiki:wiki:readonly bitable:app bitable:app:readonly}"
if [[ -z "$APP_ID" || -z "$APP_SECRET" ]]; then
  echo "Set LARK_APP_ID and LARK_APP_SECRET (and optionally LARK_DOMAIN)." >&2
  exit 1
fi
exec npx -y @larksuiteoapi/lark-mcp login \
  -a "$APP_ID" \
  -s "$APP_SECRET" \
  -d "$DOMAIN" \
  --host "$HOST" \
  --scope "$SCOPES" \
  "$@"
