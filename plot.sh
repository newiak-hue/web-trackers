#!/usr/bin/env bash
set -eu

#initializing mysql connection parameters and output directory
MYSQL_DB="trackerdb"
MYSQL_USER="trackeruser"
MYSQL_PASS="trackerpass"
MYSQL_HOST="localhost"

PLOT_OUTPUT_DIR="./plots"
mkdir -p "$PLOT_OUTPUT_DIR"

detect_mysql() {
    #same function as in scrape.sh to detect mysql client
    if command -v mysql >/dev/null 2>&1; then
        echo "mysql"
        return
    fi

    WIN_PATHS=(
        "/mnt/c/Program Files/MySQL"
        "/mnt/c/Program Files (x86)/MySQL"
        "/c/Program Files/MySQL"
        "/c/Program Files (x86)/MySQL"
    )

    for base in "${WIN_PATHS[@]}"; do
        if [ -d "$base" ]; then
            exe=$(find "$base" -type f -iname "mysql.exe" 2>/dev/null | head -n 1)
            if [ -n "$exe" ]; then
                echo "$exe"
                return
            fi
        fi
    done

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
    echo "ERROR: Could not find MySQL client." >&2
    exit 1
fi

export_data() {
    #getting the data from specific asset table from mysql and exporting to csv file
    local table_name="$1"
    local csv_file="$2"
    "$MYSQL_CMD" -h "$MYSQL_HOST" -u"$MYSQL_USER" -p"$MYSQL_PASS" "$MYSQL_DB" -N -e "
        SELECT scrape_time, price_usd, high_24, low_24
        FROM $table_name
        ORDER BY scrape_time ASC;
    " > "$csv_file"
    [[ -s "$csv_file" ]]
}

plot_graph() {
    #function to plot graph using gnuplot
    #initializing parameters
    local asset="$1"
    local column="$2"
    local ylabel="$3"
    local csv_file="$4"
    local output_png="$5"

    #using gnuplot to plot the graph (time on x-axis and price on y-axis) by reading from csv file
    gnuplot <<EOF
set datafile separator whitespace
set terminal png size 1280,720
set output "$output_png"
set xdata time
set timefmt "%Y-%m-%d %H:%M:%S"
set format x "%m/%d\n%H:%M"
set grid
set title "$asset — $ylabel"
set xlabel "Time"
set ylabel "$ylabel (USD)"
plot "$csv_file" using (strcol(1)." ".strcol(2)):$column with lines lw 2 title "$ylabel"
EOF
}

plot_asset() {
    #function to plot all 3 graphs(current,high,low) for a specific asset
    local asset="$1"
    local table="${asset}_price"
    local csv="/tmp/${asset}.csv"

    export_data "$table" "$csv"

    echo "Plotting $asset graphs..."-

    plot_graph "$asset" 3 "Current Price" "$csv" "$PLOT_OUTPUT_DIR/${asset}_current.png"
    plot_graph "$asset" 4 "24h High" "$csv" "$PLOT_OUTPUT_DIR/${asset}_high24.png"
    plot_graph "$asset" 5 "24h Low" "$csv" "$PLOT_OUTPUT_DIR/${asset}_low24.png"

    echo "Done plotting $asset. Saved to $PLOT_OUTPUT_DIR/"
}

main() {
    #main function to handle command line arguments(can choose either four or all to plot)
    local cmd="${1:-}"
    case "$cmd" in
        bitcoin) plot_asset "bitcoin" ;;
        ethereum) plot_asset "ethereum" ;;
        gold) plot_asset "gold" ;;
        silver) plot_asset "silver" ;;
        all)
            plot_asset "bitcoin"
            plot_asset "ethereum"
            plot_asset "gold"
            plot_asset "silver"
            ;;
        *)
            echo "Usage: $0 {bitcoin|ethereum|gold|silver|all}"
            exit 1
            ;;
    esac
}

main "$@"
