#! /usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

read -p "Enter database name: " dropDB

if [ -d "$dropDB" ]; then
    whiptail --title "Drop Databse Message" --msgbox "You deleted $dropName database secessfully" 8 45
    rmdir "$dropDB"
    echo "You deleted the database."
    break
else
    whiptail --title "Drop Databse Message" --msgbox "Error to delete database $dropName" 8 45
    echo "Directory '$dropDB' does not exist."
fi

