#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
if [[ ! -d "$DB_PATH" ]]; then
    mkdir -p "$DB_PATH"
fi
cd "$DB_PATH" || exit
whiptail --title "DBMS Initialization" --msgbox "DBMS is ready!" 10 40

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
                echo "Create DataBase"
			    dbName=$(whiptail --title "Create DataBase" --inputbox "Enter your database name to creat" 8 45 3>&1 1>&2 2>&3)
			    echo $dbName 
			    source createdb.sh "$dbName"
			    ;;
            2)
                source listdbs.sh 
                ;;
            3)
                source connect-db.sh 
                ;;
            4)
                source drop-db.sh
                ;;
            5)
                source exitScript.sh
                ;;
            *)
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac
    done
}

mainMenu
