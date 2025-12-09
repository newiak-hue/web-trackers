#!/usr/bin/env bash
set -eu

#initialize MySQL connection parameters and scraping settings
MYSQL_DB="trackerdb"
MYSQL_USER="trackeruser"
MYSQL_PASS="trackerpass"
MYSQL_HOST="localhost"
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0"
MAX_RETRIES=3

BITCOIN_URL="https://coinmarketcap.com/currencies/bitcoin/"
ETHEREUM_URL="https://coinmarketcap.com/currencies/ethereum/"
GOLD_URL="https://kitco.com/charts/gold/"
SILVER_URL="https://www.kitco.com/charts/silver/"

#function that auto detects MySQL client path (Linux/Windows/WSL)
detect_mysql() {
    #checks if mysql command is available in PATH(for linux/WSL)
    if command -v mysql >/dev/null 2>&1; then
        echo "mysql"
        return
    fi
    
    #typical windows installation paths
    WIN_PATHS=(
        "/mnt/c/Program Files/MySQL"
        "/mnt/c/Program Files (x86)/MySQL"
        "/c/Program Files/MySQL"
        "/c/Program Files (x86)/MySQL"
    )
    #loops thru every possible windows path to find mysql.exe
    for base in "${WIN_PATHS[@]}"; do
        if [ -d "$base" ]; then
            exe=$(find "$base" -type f -iname "mysql.exe" 2>/dev/null | head -n 1)
            if [ -n "$exe" ]; then
                echo "$exe"
                return
            fi
        fi
    done
    #fallback to using powershell to find mysql.exe path in windows
    if command -v wslpath >/dev/null 2>&1; then
        win_exe=$(powershell.exe -NoLogo -NoProfile -Command "Get-Command mysql.exe -ErrorAction SilentlyContinue | Select -ExpandProperty Source" 2>/dev/null | tr -d '\r')
        if [ -n "$win_exe" ]; then
            echo "$(wslpath "$win_exe")"
            return
        fi
    fi
    echo ""
}

MYSQL_CMD="$(detect_mysql)"
if [ -z "$MYSQL_CMD" ]; then
    echo "ERROR: Could not find MySQL client on this system." >&2
    exit 1
fi

timestamp() { date +"%F %T"; }

#function to scrape bitcoin
scrape_bitcoin() {
    #initialize temp files and backup csv
    local TMPFILE="/tmp/scrape_bitcoin.html"
    local BACKUP_FILE="/tmp/bitcoin_backup.csv"
    
    echo "Scraping Bitcoin..."
    #attempt to fetch the webpage with max 3 retries
    RETRY=0
    SUCCESS=0
    while [[ $RETRY -lt $MAX_RETRIES ]]; do
        if curl -fsSL --max-time 20 -A "$USER_AGENT" "$BITCOIN_URL" -o "$TMPFILE"; then
            SUCCESS=1
            break
        fi
        RETRY=$((RETRY+1))
        sleep 3
    done
    #error handling (failed to fetch after retries, empty response and unexpected content)
    if [[ $SUCCESS -ne 1 ]]; then
        echo "ERROR: Failed to fetch Bitcoin data after $MAX_RETRIES attempts" >&2
        return 1
    fi

    if [[ ! -s "$TMPFILE" ]]; then
        echo "$(timestamp) ERROR: Empty response for Bitcoin (blocked or down)" >&2
        return 1
    fi

    if ! grep -q "Bitcoin" "$TMPFILE"; then
        echo "$(timestamp) ERROR: Bitcoin page does not look like expected content" >&2
        return 1
    fi

    #extract price, high and low values using grep and Perl regex
    local price_raw=$(
        grep -oP '(?<=data-test="text-cdp-price-display">)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE" |
        head -n1 |
        tr -d '$,'
    )

    local high24h=$(
        grep -oP '(?<=">High</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
        tr -d '$,'
    )

    local low24h=$(
        grep -oP '(?<=">Low</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
        tr -d '$,'
    )

    local price="${price_raw:-0}"
    local high24="${high24h:-NULL}"
    local low24="${low24h:-NULL}"

    if [[ -z "$price" || "$price" == "0" ]]; then
        echo "ERROR: Could not extract valid Bitcoin price" >&2
        return 1
    fi
    #append scraped data to backup csv file
    echo "$(timestamp),$price,$high24,$low24,$BITCOIN_URL" >> "$BACKUP_FILE"
    process_backup_file "$BACKUP_FILE" "bitcoin_price"
    echo "Bitcoin scraping completed: Current = \$$price, High = \$$high24, Low = \$$low24"
}

scrape_ethereum() {
    #same as bitcoin scraping function but for ethereum (will not comment further for the rest as well)
    local TMPFILE="/tmp/scrape_ethereum.html"
    local BACKUP_FILE="/tmp/ethereum_backup.csv"
    
    echo "Scraping Ethereum..."
    
    RETRY=0
    SUCCESS=0
    while [[ $RETRY -lt $MAX_RETRIES ]]; do
        if curl -fsSL --max-time 20 -A "$USER_AGENT" "$ETHEREUM_URL" -o "$TMPFILE"; then
            SUCCESS=1
            break
        fi
        RETRY=$((RETRY+1))
        sleep 3
    done

    if [[ $SUCCESS -ne 1 ]]; then
        echo "ERROR: Failed to fetch Ethereum data after $MAX_RETRIES attempts" >&2
        return 1
    fi

    if [[ ! -s "$TMPFILE" ]]; then
        echo "$(timestamp) ERROR: Empty response for Ethereum (blocked or down)" >&2
        return 1
    fi

    if ! grep -q "Ethereum" "$TMPFILE"; then
        echo "$(timestamp) ERROR: Ethereum page does not look like expected content" >&2
        return 1
    fi

    local price_raw=$(
        grep -oP '(?<=data-test="text-cdp-price-display">)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE" |
        head -n1 |
        tr -d '$,'
    )

    local high24h=$(
        grep -oP '(?<=">High</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
        tr -d '$,'
    )

    local low24h=$(
        grep -oP '(?<=">Low</div><span>)\$[0-9,]+(\.[0-9]+)?' "$TMPFILE"|
        tr -d '$,'
    )

    local price="${price_raw:-0}"
    local high24="${high24h:-NULL}"
    local low24="${low24h:-NULL}"

    if [[ -z "$price" || "$price" == "0" ]]; then
        echo "ERROR: Could not extract valid Ethereum price" >&2
        return 1
    fi

    echo "$(timestamp),$price,$high24,$low24,$ETHEREUM_URL" >> "$BACKUP_FILE"
    process_backup_file "$BACKUP_FILE" "ethereum_price"
    echo "Ethereum scraping completed: Current = \$$price, High = \$$high24, Low = \$$low24"
}

scrape_gold() {
    local TMPFILE="/tmp/scrape_gold.html"
    local BACKUP_FILE="/tmp/gold_backup.csv"
    
    echo "Scraping Gold..."
    
    RETRY=0
    SUCCESS=0
    while [[ $RETRY -lt $MAX_RETRIES ]]; do
        if curl -fsSL --max-time 20 -A "$USER_AGENT" "$GOLD_URL" -o "$TMPFILE"; then
            SUCCESS=1
            break
        fi
        RETRY=$((RETRY+1))
        sleep 3
    done

    if [[ $SUCCESS -ne 1 ]]; then
        echo "ERROR: Failed to fetch Gold data after $MAX_RETRIES attempts" >&2
        return 1
    fi

    if [[ ! -s "$TMPFILE" ]]; then
        echo "$(timestamp) ERROR: Empty response for Gold (blocked or down)" >&2
        return 1
    fi

    if ! grep -q "Gold" "$TMPFILE"; then
        echo "$(timestamp) ERROR: Gold page does not look like expected content" >&2
        return 1
    fi

    local price_raw=$(grep -oP '<h3[^>]*>\K[0-9,.]+' "$TMPFILE" | tr -d ',')
    local values=($(grep -oP '(?<=<div>)[0-9.]+(?=</div>)' "$TMPFILE"))
    local high24h="${values[1]}"
    local low24h="${values[0]}"

    local price="${price_raw:-0}"
    local high24="${high24h:-NULL}"
    local low24="${low24h:-NULL}"

    if [[ -z "$price" || "$price" == "0" ]]; then
        echo "ERROR: Could not extract valid Gold price" >&2
        return 1
    fi

    echo "$(timestamp),$price,$high24,$low24,$GOLD_URL" >> "$BACKUP_FILE"
    process_backup_file "$BACKUP_FILE" "gold_price"
    echo "Gold scraping completed: Current = \$$price, High = \$$high24, Low = \$$low24"
}

scrape_silver() {
    local TMPFILE="/tmp/scrape_silver.html"
    local BACKUP_FILE="/tmp/silver_backup.csv"
    
    echo "Scraping Silver..."
    
    RETRY=0
    SUCCESS=0
    while [[ $RETRY -lt $MAX_RETRIES ]]; do
        if curl -fsSL --max-time 20 -A "$USER_AGENT" "$SILVER_URL" -o "$TMPFILE"; then
            SUCCESS=1
            break
        fi
        RETRY=$((RETRY+1))
        sleep 3
    done

    if [[ $SUCCESS -ne 1 ]]; then
        echo "ERROR: Failed to fetch Silver data after $MAX_RETRIES attempts" >&2
        return 1
    fi

    if [[ ! -s "$TMPFILE" ]]; then
        echo "$(timestamp) ERROR: Empty response for Silver (blocked or down)" >&2
        return 1
    fi

    if ! grep -q "Gold" "$TMPFILE"; then
        echo "$(timestamp) ERROR: Silver page does not look like expected content" >&2
        return 1
    fi

    local price_raw=$(grep -oP '<h3[^>]*>\K[0-9,.]+' "$TMPFILE" | tr -d ',')
    local values=($(grep -oP '(?<=<div>)[0-9.]+(?=</div>)' "$TMPFILE"))
    local high24h="${values[1]}"
    local low24h="${values[0]}"

    local price="${price_raw:-0}"
    local high24="${high24h:-NULL}"
    local low24="${low24h:-NULL}"

    if [[ -z "$price" || "$price" == "0" ]]; then
        echo "ERROR: Could not extract valid Silver price" >&2
        return 1
    fi

    echo "$(timestamp),$price,$high24,$low24,$SILVER_URL" >> "$BACKUP_FILE"
    process_backup_file "$BACKUP_FILE" "silver_price"
    echo "Silver scraping completed: Current = \$$price, High = \$$high24, Low = \$$low24"
}

process_backup_file() {
    #function to process backup csv and insert into database
    #takes in 2 arguments(backup file path and table name)
    local BACKUP_FILE="$1"
    local TABLE_NAME="$2"
    
    #attempts to read backup file, quits if empty
    if [[ -s "$BACKUP_FILE" ]]; then
        #temporary file to avoid modifying while reading
        local TMP_INSERT="/tmp/${TABLE_NAME}_processing.csv"
        cp "$BACKUP_FILE" "$TMP_INSERT"

        #attempts to reads each line and inserts into database
        while IFS=',' read -r scrape_time price_val high_val low_val url_val; do
            sql="INSERT INTO $TABLE_NAME (scrape_time, price_usd, high_24, low_24, notes) VALUES ('$scrape_time', $price_val, ${high_val:-NULL}, ${low_val:-NULL}, '$url_val');"
            if "$MYSQL_CMD" -h "$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" -e "$sql"; then
                sed -i "1d" "$BACKUP_FILE"
            else
                echo "ERROR: Failed to insert into $TABLE_NAME" >&2
                break
            fi
        done < "$TMP_INSERT"
        
        rm -f "$TMP_INSERT"
    fi
}

#running all scraping functions
echo "$(timestamp) Starting to scrape all assets..."
scrape_bitcoin
scrape_ethereum
scrape_gold
scrape_silver
echo "$(timestamp) All scraping operations completed."
