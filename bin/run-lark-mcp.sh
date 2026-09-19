#!/usr/bin/env bash
# Launch official @larksuiteoapi/lark-mcp (stdio). Credentials from env only.
set -euo pipefail
APP_ID="${LARK_APP_ID:-${APP_ID:-}}"
APP_SECRET="${LARK_APP_SECRET:-${APP_SECRET:-}}"
DOMAIN="${LARK_DOMAIN:-https://open.larksuite.com}"
TOOLS="${LARK_TOOLS:-preset.default,preset.task.default,preset.calendar.default}"
if [[ -z "$APP_ID" || -z "$APP_SECRET" ]]; then
  echo "Set LARK_APP_ID and LARK_APP_SECRET (and optionally LARK_DOMAIN, LARK_TOOLS)." >&2
  exit 1
fi
export APP_ID APP_SECRET LARK_APP_ID="$APP_ID" LARK_APP_SECRET="$APP_SECRET" LARK_DOMAIN="$DOMAIN"
exec npx -y @larksuiteoapi/lark-mcp mcp \
  -a "$APP_ID" \
  -s "$APP_SECRET" \
  -d "$DOMAIN" \
  -t "$TOOLS" \
  --oauth \
  --token-mode user_access_token \
  "$@"
