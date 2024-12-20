#! /usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBase"

dropDB=$(whiptail --title "Drop DataBase" --inputbox "Enter your database name to drop" 8 45 3>&1 1>&2 2>&3)

echo $dropDB
if [ -d "$DB_PATH/$dropDB" ]; then
    whiptail --title "Drop Databse Message" --msgbox "You deleted $dropDB database successfully" 8 45
    rm -r "$DB_PATH/$dropDB"
    echo "You deleted the database $dropDB."
else
    whiptail --title "Drop Databse Message" --msgbox "Error to delete database $dropDB" 8 45
    echo "Directory '$dropDB' does not exist."
fi


