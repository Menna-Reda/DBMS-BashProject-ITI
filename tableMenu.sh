#!/usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
PROJECT_ROOT="$SCRIPT_DIR/../.."         # Go up two levels to the project root
echo "SCRIPT_DIR: $SCRIPT_DIR"           # Debugging: Print the script directory
echo "PROJECT_ROOT: $PROJECT_ROOT"       # Debugging: Print the project root directory

function mainMenu() {
    dbName=$1
    echo "Selected database: $dbName"

    while true; do
        option=$(whiptail --nocancel --title "Tables Menu" --fb --menu "Select an option" 15 60 8 \
            "1" "Create table" \
            "2" "List tables" \
            "3" "Drop table" \
            "4" "Insert into table" \
            "5" "Select from table" \
            "6" "Delete from table" \
            "7" "Update table" \
            "8" "Exit" 3>&1 1>&2 2>&3)

        case $option in
        1)
            echo "Creating Table..."
            if [[ -f "$PROJECT_ROOT/createTb.sh" ]]; then
                . "$PROJECT_ROOT/createTb.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "createTb.sh not found!" 10 40
            fi
            ;;
        2)
            echo "Listing Tables..."
            if [[ -f "$PROJECT_ROOT/listtbs.sh" ]]; then
                . "$PROJECT_ROOT/listtbs.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "listtbs.sh not found!" 10 40
            fi
            ;;
        3)
            echo "Dropping Table..."
            if [[ -f "$PROJECT_ROOT/droptb.sh" ]]; then
                . "$PROJECT_ROOT/droptb.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "droptb.sh not found!" 10 40
            fi
            ;;
        4)
            echo "Inserting Data into Table..."
            if [[ -f "$PROJECT_ROOT/insertData.sh" ]]; then
                . "$PROJECT_ROOT/insertData.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "insertData.sh not found!" 10 40
            fi
            ;;
        5)
            echo "Selecting Data from Table..."
            if [[ -f "$PROJECT_ROOT/selectfromtb.sh" ]]; then
                . "$PROJECT_ROOT/selectfromtb.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "selectfromtb.sh not found!" 10 40
            fi
            ;;
        6)
            echo "Deleting Data from Table..."
            if [[ -f "$PROJECT_ROOT/deletfromtb.sh" ]]; then
                . "$PROJECT_ROOT/deletfromtb.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "deletfromtb.sh not found!" 10 40
            fi
            ;;
        7)
            echo "Updating Table..."
            if [[ -f "$PROJECT_ROOT/updatetb.sh" ]]; then
                . "$PROJECT_ROOT/updatetb.sh" "$dbName"
            else
                whiptail --title "Error" --msgbox "updatetb.sh not found!" 10 40
            fi
            ;;
        8)
            whiptail --title "Exit" --msgbox "Thank you for using DBMS. Goodbye!" 10 40
            exit 0
            ;;
        *)
            whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
            ;;
        esac
    done
}

mainMenu "$1"
