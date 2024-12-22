#!/usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
echo "sript from table menu $SCRIPT_DIR"
db_Name=$1
function mainMenu() {
  while true ; do     

        option=$(whiptail --nocancel --title "Tables Menu" --fb --menu "Select an option" 18 60 9 \
            "1" "Create table" \
            "2" "List tables" \
            "3" "Drop table" \
            "4" "Insert into table" \
            "5" "Select from table" \
            "6" "Delete from table" \
            "7" "Update table" \
            "8" "Back to Main Menu" \
            "9" "Exit" 3>&1 1>&2 2>&3)

        case $option in
        1)
               echo "Create Table"
               source createTb.sh $db_Name
              ;;
         2)
                source listtbs.sh $db_Name
                ;;
         3)
                source droptb.sh $db_Name
                ;;
         4)
                source insertData.sh $db_Name
                ;;
         5)     
                source selectmenu.sh $db_Name
                ;;
         6)
                source deletFromTb.sh $db_Name
                ;;
         7)
               source updatetb.sh $db_Name
                ;;
         8)
              source main.sh
              ;;
         9)
                source exitScript.sh
                ;;
         *)
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac 
    done      
}

mainMenu
