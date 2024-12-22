#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function listTBs(){
    dbName=$1
    TablesNo=$( ls  $DB_PATH/$dbName/* |wc -l )
    DatabasesList=$( ls  $DB_PATH/$dbName/* | cut -d/ -f10)
    menu_height=$(($TablesNo*2)) # Add padding for borders
    echo "menu_height: $menu_height"
    # Minimum height to ensure proper display
    if [ "$menu_height" -lt 10 ]; then
    menu_height=10
    fi
    whiptail --title "List of tables in" --msgbox "Number of Tables: $TablesNo\n$DatabasesList" $menu_height 40
}
listTBs $1
