#! /usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function createDB {
    dbName=$1
    if [[ -d "$DB_PATH/$dbName" ]]; then
	echo "DataBase $dbName Already Exists";
	whiptail --title "Create Databse Message" --msgbox "DataBase $dbName Already Exists" 10 40
    else
        if [[ -z $dbName ]]; then
            whiptail --title "Invalid database name" --msgbox "Cannot create database with blank name" 10 40
        elif [[ $dbName =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]
        then 
            mkdir "$DB_PATH/$dbName"
            whiptail --title "Database Creadted" --msgbox "Database $dbName created successfully." 10 40

        else
            whiptail --title "Invalid database name" --msgbox "Database names should starts with letter or _ only and it shouldn't include any special character" 10 40
        fi
    fi

}
createDB "$1"