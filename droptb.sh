#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function dropTable(){
    dbName=$1
    tbName=$(whiptail --title "Select table" --inputbox "Enter table name to be dropped" 8 45 3>&1 1>&2 2>&3)
    if ! [[ -f "$DB_PATH/$dbName/$tbName" ]]; then
        whiptail --title "Error Message" --msgbox "No such table called $tbName in $dbName database!" 8 45 
    else
        rm $tbName
        rm .$tbName
        whiptail --title "Success Message" --msgbox "Table $tbName dropped successfully" 10 45

    fi

}
dropTable $1