#!/usr/bin/bash

shopt -s extglob

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

# Ensure the DataBases directory exists
if [[ ! -d "$DB_PATH" ]]; then
    mkdir -p "$DB_PATH"
fi

# Display a message indicating that DBMS is ready
whiptail --title "DBMS Initialization" --msgbox "DBMS is ready!" 10 40

# Main menu function
function mainMenu() {
    while true; do
        # Display the main menu
        option=$(whiptail --nocancel --title "Main Menu" --fb --menu "Select an option:" 15 60 5 \
            "1" "Create DataBase" \
            "2" "List DataBases" \
            "3" "Connect To a DataBase" \
            "4" "Drop a DataBase" \
            "5" "Exit" 3>&1 1>&2 2>&3)

        case $option in
            1)
                dbName=$(whiptail --title "Create DataBase" --inputbox "Enter your database name to create" 8 45 3>&1 1>&2 2>&3)
                . "$SCRIPT_DIR/createdb.sh" "$dbName" "$SCRIPT_DIR"
                ;;
            2)
                . "$SCRIPT_DIR/listdbs.sh"
                ;;
            3)
                dbName=$(whiptail --title "Connect to DataBase" --inputbox "Enter the database name to connect" 8 45 3>&1 1>&2 2>&3)
                . "$SCRIPT_DIR/connect-db.sh" "$dbName" "$SCRIPT_DIR"
                ;;
            4)
                dbName=$(whiptail --title "Drop DataBase" --inputbox "Enter the database name to drop" 8 45 3>&1 1>&2 2>&3)
                . "$SCRIPT_DIR/drop-db.sh" "$dbName" "$SCRIPT_DIR"
                ;;
            5)
                whiptail --title "Exit" --yesno "Are you sure you want to exit?" 10 40
                if [[ $? -eq 0 ]]; then
                    whiptail --title "Goodbye" --msgbox "Thank you for using our DBMS!" 10 40
                    exit 0
                fi
                ;;
            *)
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac
    done
}

# Call the main menu
mainMenu
