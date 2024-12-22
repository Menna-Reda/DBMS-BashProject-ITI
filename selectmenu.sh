#!/bin/bash

db_Name=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
DB_PATH="$SCRIPT_DIR/DataBases/$db_Name"
echo "from select $DB_PATH"
tableName=$(whiptail --title "Select Table" --inputbox "Enter Table Name:" 8 45 3>&1 1>&2 2>&3)
tablePath="$DB_PATH/$tableName"
echo "from select table path $tablePath"
echo "from select --> i am at $SCRIPT_DIR"


function selectmenu() {
    while true; do
        selectMenu=$(whiptail --title "Select Menu" --fb --menu "Select options:" 17 60 7 \
            "1" "Select All Columns" \
            "2" "Select Specific Row" \
            "3" "Select Specific Column" \
            "4" "Select With Where Condition" \
            "5" "Back to Table Menu" \
            "6" "Back to Main Menu"\
            "7" "EXIT" 3>&1 1>&2 2>&3)

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
                    if [[ ! -f "$tablePath" ]]; then
                        whiptail --title "Error" --msgbox "Table does not exist!" 8 45
                    else
                        columnName=$(awk -F: 'NR==1 {print $0}' "$tablePath" | tr ':' '\n' | \
                            whiptail --title "Select Column" --menu "Choose a column to filter by:" 20 60 15 \
                            $(awk -F: 'NR==1 {for (i=1; i<=NF; i++) print i, $i}' "$tablePath") 3>&1 1>&2 2>&3)

                        if [[ -z "$columnName" ]]; then
                            whiptail --title "Error" --msgbox "You must select a column!" 8 45
                        else
                            filterValue=$(whiptail --title "Filter Value" --inputbox "Enter value for '$columnName':" 8 45 3>&1 1>&2 2>&3)

                            if [[ -z "$filterValue" ]]; then
                                whiptail --title "Error" --msgbox "You must enter a filter value!" 8 45
                            else
                                filteredRow=$(awk -F: -v col="$columnName" -v val="$filterValue" \
                                    'NR==1 {for (i=1; i<=NF; i++) if ($i==col) colIndex=i} NR>1 && $colIndex==val {print $0}' "$tablePath")

                                if [[ -z $filteredRow ]]; then
                                    whiptail --title "No Data" --msgbox "No matching row found for $columnName='$filterValue'." 8 45
                                else
                                    whiptail --title "Filtered Row" --scrolltext --msgbox "$filteredRow" 20 60
                                fi
                            fi
                        fi
                    fi
                    ;;


            3) 
                selectedColumns=$(awk -F: 'NR==1 {print $0}' "$tablePath" | tr ':' '\n' | \
                    whiptail --title "Select Columns" --checklist "Choose columns to display:" 20 60 15 \
                    $(awk -F: 'NR==1 {for (i=1; i<=NF; i++) print $i " " $i " off"}' "$tablePath") 3>&1 1>&2 2>&3)
                
                selectedColumns=$(echo "$selectedColumns" | tr -d '"' | tr ' ' '|')

                if [[ -z $selectedColumns ]]; then
                    whiptail --title "No Columns Selected" --msgbox "You must select at least one column." 8 45
                else
                    selectedData=$(awk -F: -v cols="$selectedColumns" \
                        'NR==1 {split(cols, colArr, "|"); for (i in colArr) {for (j=1; j<=NF; j++) if ($j==colArr[i]) indexes[i]=j}} \
                         NR>1 {row=""; for (i in indexes) row=row $indexes[i] ":"; print substr(row, 1, length(row)-1)}' "$tablePath")
                    whiptail --title "Selected Columns" --scrolltext --msgbox "$selectedData" 35 70
                fi
                ;;

            4) 
                echo "Select with Where Condition"
                source "$SCRIPT_DIR/selectwhere.sh"
                ;;

            5) 
                echo "Back to Table Menu"
                source tablemenu.sh
                break
                ;;

            6)
                echo "Back to Main Menu"
                cd ..
                source main.sh
                break
                ;;

            7)
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
