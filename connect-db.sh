#!/usr/bin/bash

PROJECT_ROOT=$1  # Root directory of DBMS
echo "from connect db" "$PROJECT_ROOT"
DB_PATH="$PROJECT_ROOT/DataBases"  # Path to the databases directory
dbConnect=$2
function connect {
    if [ -d "$DB_PATH/$dbConnect" ]; then
        cd "$DB_PATH/$dbConnect" || { 
            echo "Error: Could not change directory to $DB_PATH/$dbConnect"; 
            exit 1; 
        }
        
        whiptail --title "Connected to $dbConnect" --msgbox "Connected successfully to $dbConnect" 8 45
        echo "Connected to database: $PWD"
        
        # Source tableMenu.sh
        if [[ -f "$PROJECT_ROOT/tableMenu.sh" ]]; then
            . "$PROJECT_ROOT/tableMenu.sh" "$PROJECT_ROOT" "$dbConnect"
        else
            whiptail --title "Error" --msgbox "Error: tableMenu.sh not found!" 8 45
            exit 1
        fi
    else
        whiptail --title "Error Message" --msgbox "Connection failed. Database $dbConnect not found!" 8 45
        echo "Error: Database $dbConnect not found at $DB_PATH"

        # Ensure main.sh exists
        if [[ -f "$PROJECT_ROOT/main.sh" ]]; then
            . "$PROJECT_ROOT/main.sh"
        else
            whiptail --title "Error" --msgbox "Error: main.sh not found!" 8 45
            exit 1
        fi
    fi
}

connect
