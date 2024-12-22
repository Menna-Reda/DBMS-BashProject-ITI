#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function listTBs(){
    dbName=$1
    DatabasesNo=$( ls  $DB_PATH/$dbName/* |wc -l )
    DatabasesList=$( ls  $DB_PATH/$dbName/* | cut -d/ -f10)
    whiptail --title "List of tables in" --msgbox "Number of Tables: $DatabasesNo\n$DatabasesList" 10 40
}
listTBs $1
