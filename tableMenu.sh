#!/usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
PROJECT_ROOT=$1        # Go up two levels to the project root
echo "SCRIPT_DIR: $SCRIPT_DIR"           
echo "from tablemenu: $PROJECT_ROOT"      

function mainMenu() {
  while True ; do     
    dbName=$2
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
               echo "Create Table"
               . "$PROJECT_ROOT/createTb.sh" "$PROJECT_ROOT" "$dbName" 
              ;;
         2)
                . "$PROJECT_ROOT/listtbs.sh" "$dbName"
                ;;
         3)
                . "$PROJECT_ROOT/droptb.sh" "$dbName" 
                ;;
         4)
                . "$PROJECT_ROOT/insertData.sh" "$dbName" 
                ;;
         5)     
                . "$PROJECT_ROOT/selectmenu.sh" "$PROJECT_ROOT" "$dbName" 
                ;;
         6)
                . "$PROJECT_ROOT/deletfromtb.sh" "$dbName" 
                ;;
         7)
                . "$PROJECT_ROOT/updatetb.sh""$dbName" 
                ;;
         8)
                . "$PROJECT_ROOT/exitScript.sh"
                ;;
         *)
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac
    done
  done   
}

mainMenu $@
