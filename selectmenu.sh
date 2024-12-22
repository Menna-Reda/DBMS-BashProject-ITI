#!/bin/bash

db_Name=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
DB_PATH="$SCRIPT_DIR/DataBases/$db_Name"

tableName=$(whiptail --title "Select Table" --inputbox "Enter Table Name:" 8 45 3>&1 1>&2 2>&3)
tablePath="$DB_PATH/$tableName"
tableMetaPath="$DB_PATH/.$tableName"




function selectmenu() {
    while true; do
        selectMenu=$(whiptail --title "Select Menu" --fb --menu "Select options:" 17 60 7 \
            "1" "Select All Columns" \
            "2" "Select Specific Column" \
            "3" "Select With Where Condition" \
            "4" "Back to Table Menu" \
            "5" "Back to Main Menu"\
            "6" "EXIT" 3>&1 1>&2 2>&3)

        case $selectMenu in
            1)
                    if [[ ! -f "$tablePath" ]]; then
                        whiptail --title "Error" --msgbox "Table does not exist!" 8 45
                    else
                        if [[ ! -s "$tablePath" ]]; then
                            whiptail --title "Error" --msgbox "The table is empty or unreadable!" 8 45
                        else
                            tableData=$(cat "$tablePath")
                             lines=$( cat /tmp/table_data.tmp | wc -l )
                            menu_height=$(($lines*2))
                            echo $menu_height
                            echo "$tableData" > /tmp/table_data.tmp
                            whiptail --title "All Table Data" --scrolltext --textbox /tmp/table_data.tmp 30 60
                        fi
                    fi
                    ;;

            
            2) 
                colNo=$(awk -F: 'END { print NR }' "$tableMetaPath")
                declare -a  columnNames
                for ((i=1;i<=colNo;i++));do
                    colName=$(awk -F: -v i=$i 'NR==1 {print $i}' "$tablePath")
                    columnNames+=("$i" "$colName")
                done
                selectedColumnName=$(whiptail --title "Select Column" --menu "Choose a column to filter by:" 15 40 $colNo "${columnNames[@]}" 3>&1 1>&2 2>&3)
                #selectedColumns=$(echo "$selectedColumns" | tr -d '"' | tr ' ' '|')

                if [[ -z $selectedColumnName ]]; then
                    whiptail --title "No Columns Selected" --msgbox "You must select at a column." 8 45
                else
                    selectedData=$(awk -F: -v cols="$selectedColumnName" ' 
                    {print $cols}
                    ' "$tablePath")
                    whiptail --title "Selected Columns" --scrolltext --msgbox "$selectedData" 10 70
                fi
                ;;

            3) 
                echo "Select with Where Condition"
                source "$SCRIPT_DIR/selectWhere.sh" "$db_Name" "$tableName"
                ;;

            4) 
                echo "Back to Table Menu"
                source "$SCRIPT_DIR/tableMenu.sh"
                break
                ;;

            5)
                echo "Back to Main Menu"
                cd ..
                source main.sh
                break
                ;;

            6)
               source exitScript.sh
               ;;

            
            *) 
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                source selectmenu.sh
                ;;
        esac
    done
}

selectmenu
