#! /usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

function connect {
dbConnect=$(whiptail --title "Connect to DataBase" --inputbox "Enter your database name to connect" 8 45 3>&1 1>&2 2>&3)
if [ -d "$DB_PATH/$dbConnect" ]; then
	 cd "$DB_PATH/$database_name"
                whiptail --title "Connected to $dbConnect" --msgbox "Connected successfully to $dbConnect " 8 45
                echo "Connected to database: $PWD"
                echo "Choose an option: "
                source tableMenu.sh	dbConnect
else
          whiptail --title "Error Message" --msgbox "Connection failed" 8 45
          echo "Database not found."
	  . ./main.sh  
               
fi                                

}

connect
