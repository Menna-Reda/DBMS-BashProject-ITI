#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function listDBs() {
 
    DatabasesNo=$( ls -d $DB_PATH/* |wc -l )
    DatabasesList=$( ls -d $DB_PATH/* | cut -d/ -f9)
     whiptail --title "List of DataBases" --msgbox "Number of databases: $DatabasesNo\n$DatabasesList" 10 40
}
listDBs