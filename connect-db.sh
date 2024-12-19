#!/usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script

function connect {
    dbConnect=$(whiptail --title "Connect to DataBase" --inputbox "Enter your database name to connect" 8 45 3>&1 1>&2 2>&3)

    if [ -d "$SCRIPT_DIR/$dbConnect" ]; then
        cd "$SCRIPT_DIR/$dbConnect" || { 
            echo "Error: Could not change directory to $SCRIPT_DIR/$dbConnect"; 
            exit 1; 
        }
        
        whiptail --title "Connected to $dbConnect" --msgbox "Connected successfully to $dbConnect" 8 45
        echo "Connected to database: $PWD"
        
        # Source tableMenu.sh from the DBMS-BashProject-ITI directory (relative path)
        if [[ -f "$SCRIPT_DIR/../tableMenu.sh" ]]; then
            . "$SCRIPT_DIR/../tableMenu.sh" "$dbConnect"
        else
            whiptail --title "Error" --msgbox "Error: tableMenu.sh not found!" 8 45
            echo "Error: tableMenu.sh not found!"
            exit 1
        fi
    else
        whiptail --title "Error Message" --msgbox "Connection failed. Database $dbConnect not found!" 8 45
        echo "Error: Database $dbConnect not found at $SCRIPT_DIR"

        # Ensure main.sh exists and source it from the DBMS-BashProject-ITI directory
        if [[ -f "$SCRIPT_DIR/../main.sh" ]]; then
            . "$SCRIPT_DIR/../main.sh"
        else
            whiptail --title "Error" --msgbox "Error: main.sh not found!" 8 45
            echo "Error: main.sh not found!"
            exit 1
        fi
    fi
}

connect
