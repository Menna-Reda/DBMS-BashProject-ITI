#! /usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

if [ ! -d "$database_name" ]; then
		whiptail --title "Error Message" --msgbox "Connection failed" 8 45
                echo "Database not found."
		./main.sh
            else
                cd "$database_name"
                whiptail --title "Connected to $database_name" --msgbox "Connected successfully to Database " 8 45
       		. ./main.sh	
                echo "Connected to database: $PWD"
                echo "Choose an option: "
              #  ./tablemunue
fi                                
