#!/usr/bin/bash
function mainMenu(){
    dbName=$1
    while true; do
        option=$(whiptail --nocancel --title "Tables Menu" --fb --menu "Select an option" 15 60 8\
                    "1" "Create table"\
                    "2" "List tables"\
                    "3" "Drop table"\
                    "4" "Insert into table"\
                    "5" "Select from table"\
                    "6" "Delete from table"\
                    "7" "Update table"\
                    "8" "Exit" 3>&1 1>&2 2>&3)
        case $option in
        1)
		 echo "Create Table"
		 source createtb.sh "$dbName"
		;;
         2)
                source listtbs.sh "$dbName"
                ;;
         3)
                source droptb.sh "$dbName" 
                ;;
         4)
                source insertData.sh "$dbName" 
                ;;
         5)     
                source selectfromtb.sh "$dbName" 
                ;;
         6)
                source deletfromtb.sh "$dbName" 
                ;;
         7)
                source updatetb.sh "$dbName" 
                ;;
         8)
                source exitScript.sh
                ;;
         *)
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac
    done
}
mainMenu $1
