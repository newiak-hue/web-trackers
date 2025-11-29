#!/usr/bin/env bash
set -eu

URL="https://coinmarketcap.com/currencies/bitcoin/"
TMPFILE="/tmp/scrape_bitcoin.html"
BACKUP_FILE="/tmp/bitcoin_backup.csv"
USER_AGENT=("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0")
MYSQL_DB="trackerdb"
MYSQL_USER="trackeruser"
MYSQL_PASS="trackerpass"
MYSQL_HOST="localhost"

if grep -qi "microsoft" /proc/version 2>/dev/null; then
    MYSQL_CMD="/mnt/c/Program Files/MySQL/MySQL Server 9.5/bin/mysql.exe"
else
    MYSQL_CMD="mysql"
fi

MYSQL_BIN=("$MYSQL_CMD")

timestamp() { date +"%F %T"; }

MAX_RETRIES=3
RETRY=0
SUCCESS=0

while [[ $RETRY -lt $MAX_RETRIES ]]; do
  if curl -fsSL --max-time 20 -A "$USER_AGENT" "$URL" -o "$TMPFILE"; then
    SUCCESS=1
    break
  fi
  RETRY=$((RETRY+1))
  sleep 3
done

if [[ $SUCCESS -ne 1 ]]; then
  exit 1
fi

if [[ ! -s "$TMPFILE" ]]; then
  echo "$(timestamp) ERROR: Empty response (blocked or down)" >&2
  exit 1
fi

if ! grep -q "Bitcoin" "$TMPFILE"; then
  echo "$(timestamp) ERROR: page does not look like expected content" >&2
  exit 1
fi


price_raw=$(
 grep -oP '(?<=data-test="text-cdp-price-display">)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE" |
 head -n1 |
 tr -d '$,'
)

high24h=$(
 grep -oP '(?<=">High</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
 tr -d '$,'
)

low24h=$(
 grep -oP '(?<=">Low</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
 tr -d '$,'
)

price="${price_raw:-0}"
high24="${high24h:-NULL}"
low24="${low24h:-NULL}"

if [[ -z "$price" || "$price" == "0" ]]; then
  exit 1
fi

echo "$(timestamp),$price,$high24,$low24,$URL" >> "$BACKUP_FILE"

if [[ -s "$BACKUP_FILE" ]]; then
  TMP_INSERT="/tmp/bitcoin_backup_processing.csv"
  cp "$BACKUP_FILE" "$TMP_INSERT"

  while IFS=',' read -r scrape_time price_val high_val low_val url_val; do
    sql="INSERT INTO bitcoin_price (scrape_time, price_usd, high_24h_usd, low_24h_usd, notes) VALUES ('$scrape_time', $price_val, ${high_val:-NULL}, ${low_val:-NULL}, '$url_val');"
    if "${MYSQL_BIN[@]}" -h "$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" -e "$sql"; then
      sed -i "1d" "$BACKUP_FILE"
    else
      break
    fi
  done < "$TMP_INSERT"

  rm -f "$TMP_INSERT"
fi
