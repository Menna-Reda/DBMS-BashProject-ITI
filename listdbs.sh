#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

function listDBs() {
 
    DatabasesNo=$( ls -d "$DB_PATH/*" |wc -l )
    DatabasesList=$( ls -d "$DB_PATH/*" | cut -d/ -f9)
    menu_height=$(($DatabasesNo+8)) 

    if [ "$menu_height" -lt 10 ]; then
    menu_height=10
    fi
     whiptail --title "List of DataBases" --msgbox "Number of databases: $DatabasesNo\n$DatabasesList" 15 40
}
listDBs