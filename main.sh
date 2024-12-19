#!/usr/bin/bash

shopt -s extglob 

# Get the absolute path of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"  # Ensure this points to the correct folder

# Debugging: Check directories
echo "Current directory: $(pwd)"
echo "Script directory: $SCRIPT_DIR"

# Ensure the database directory exists
if [[ ! -d "$DB_PATH" ]]; then
    mkdir -p "$DB_PATH"  # Create the DataBases directory if it doesn't exist
    echo "Created directory: $DB_PATH"
fi

cd "$DB_PATH" || exit 1  # Ensure the script runs from the DB_PATH

# Initialize the DBMS
whiptail --title "DBMS Initialization" --msgbox "DBMS is ready!" 10 40

# Main Menu
while true; do
    # Display the main menu
    option=$(whiptail --nocancel --title "Main Menu" --fb --menu "Select an option:" 15 60 5 \
        "1" "Create Database" \
        "2" "List Databases" \
        "3" "Connect to a Database" \
        "4" "Drop a Database" \
        "5" "Exit" 3>&1 1>&2 2>&3)
    
    case $option in
        1)
            dbName=$(whiptail --title "Create Database" --inputbox "Enter your database name:" 8 45 3>&1 1>&2 2>&3)
            if [[ -z $dbName ]]; then
                whiptail --title "Error" --msgbox "Database name cannot be empty!" 10 40
            else
                # Ensure we don't create nested directories incorrectly
                if [[ ! -d "$DB_PATH/$dbName" ]]; then
                    mkdir "$DB_PATH/$dbName"  # Create the new database directory
                    whiptail --title "Success" --msgbox "Database $dbName created successfully!" 10 40
                else
                    whiptail --title "Error" --msgbox "Database $dbName already exists!" 10 40
                fi
            fi
            ;;
        2)
            # List databases
            if [[ $(ls "$DB_PATH") ]]; then
                dbList=$(ls "$DB_PATH")
                whiptail --title "Databases" --msgbox "Databases available:\n$dbList" 10 40
            else
                whiptail --title "Error" --msgbox "No databases available!" 10 40
            fi
            ;;
        3)
            if [[ -f "$SCRIPT_DIR/connect-db.sh" ]]; then
                source "$SCRIPT_DIR/connect-db.sh"
            else
                whiptail --title "Error" --msgbox "connect-db.sh not found!" 10 40
            fi
            ;;
        4)
            if [[ -f "$SCRIPT_DIR/drop-db.sh" ]]; then
                source "$SCRIPT_DIR/drop-db.sh"
            else
                whiptail --title "Error" --msgbox "drop-db.sh not found!" 10 40
            fi
            ;;
        5)
            whiptail --title "Exit" --msgbox "Thank you for using DBMS. Goodbye!" 10 40
            exit 0
            ;;
        *)
            whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
            ;;
    esac
done
