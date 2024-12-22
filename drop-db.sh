#! /usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

DB_PATH="$SCRIPT_DIR/DataBases"
dropDB=$(whiptail --title "Drop DataBase" --inputbox "Enter your database name to drop" 8 45 3>&1 1>&2 2>&3)
if [[ -z "$dropDB" ]]; then
        whiptail --title "Invalid database name" --msgbox "Cannot drop database with blank name" 10 40
    
elif [ -d "$DB_PATH/$dropDB" ]; then
    whiptail --title "Drop Databse Message" --msgbox "You deleted $dropDB database successfully" 8 45
    rm -r $dropDB
else
    whiptail --title "Drop Databse Message" --msgbox "Error to delete database $dropDB" 8 45
fi


