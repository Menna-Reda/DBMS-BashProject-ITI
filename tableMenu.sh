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
			    tbName=$(whiptail --title "Create Table" --inputbox "Enter your table name to creat" 8 45 3>&1 1>&2 2>&3)
			    echo $tbName 
			    source createtb.sh "$dbName" "$tbName"
			    ;;
         2)
                source listtbs.sh "$dbName"
                ;;
         3)
                source droptb.sh "$dbName" "$tbName"
                ;;
         4)
                source insertintotb.sh "$dbName" "$tbName"
                ;;
         5)     
                source selectfromtb.sh "$dbName" "$tbName"
                ;;
         6)
                source deletfromtb.sh "$dbName" "$tbName"
                ;;
         7)
                source updatetb.sh "$dbName" "$tbName"
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