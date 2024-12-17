#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function listTBs(){
    dbName=$1
    DatabasesNo=$( ls -f $DB_PATH/$dbName/* |wc -l )
    DatabasesList=$( ls -f $DB_PATH/$dbName/* )
    whiptail --title "List of tables in" --msgbox "Number of databases: $DatabasesNo\n$DatabasesList" 10 40
}
listTBs "$1"