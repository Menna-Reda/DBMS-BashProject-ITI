#!/usr/bin/bash

dbName=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases/$dbName"

function dropTable(){
    tbName=$(whiptail --title "Select table" --inputbox "Enter table name to be dropped" 8 45 3>&1 1>&2 2>&3)
    if ! [[ -f "$DB_PATH/$tbName" ]]; then
        whiptail --title "Error Message" --msgbox "No such table called $tbName in $dbName database!" 8 45 
    else
        rm "$DB_PATH/$tbName"
        rm "$DB_PATH/.$tbName"
        whiptail --title "Success Message" --msgbox "Table $tbName dropped successfully" 10 45

    fi

}
dropTable