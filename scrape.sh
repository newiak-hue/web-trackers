#!/usr/bin/env bash
set -euo pipefail

URL="https://coinmarketcap.com/currencies/bitcoin/"
TMPFILE="/tmp/scrape_bitcoin.html"
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0"


timestamp() { date +"%F %T"; }

echo "$(timestamp), Starting scrape..."

if ! curl -fsSL --max-time 20 -A "$USER_AGENT" "$URL" -o "$TMPFILE"; then
  echo "$(timestamp) ERROR: curl failed" >&2
  exit 1
fi

if ! grep -q "Bitcoin" "$TMPFILE"; then
  echo "$(timestamp) ERROR: page does not look like expected content" >&2
  exit 1
fi


price_raw=$(
 grep -oP '(?<=data-test="text-cdp-price-display">)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE" |
 head -n1 |
 tr -d '$,')

high24h=$(
  grep -oP '(?<=sc-65e7f566-0 eQBACe label">High</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
  tr -d '$,'
)

# Extract 24h Low  
low24h=$(
  grep -oP '(?<=sc-65e7f566-0 eQBACe label">Low</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
  tr -d '$,'
)

price="${price_raw:-0}"
high24="${high24h:-NULL}"
low24="${low24h:-NULL}"

if [[ -z "$price" || "$price" == "0" ]]; then
  echo "$(timestamp) ERROR: price empty after parsing" >&2
  exit 1
fi

echo "$(timestamp) Parsed: price = $price | high24 = $high24 | low24 = $low24"