#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
echo "DB_PATH is: $DB_PATH"
ls -l "$DB_PATH"

function listDBs() {
 
    DatabasesNo=$( ls -d "$DB_PATH/*" |wc -l )
    DatabasesList=$( ls -d "$DB_PATH/*" | cut -d/ -f9)
     whiptail --title "List of DataBases" --msgbox "Number of databases: $DatabasesNo\n$DatabasesList" 15 40
}
listDBs