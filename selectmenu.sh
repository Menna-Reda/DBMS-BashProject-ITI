#!/bin/bash

function selectmenu () {
    PROJECT_ROOT=$2
    SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
    tableName=$(whiptail --title "Select Table" --inputbox "Enter Table Name:" 8 45 3>&1 1>&2 2>&3)
    tablePath="$SCRIPT_DIR/$tableName"

    if [[ ! -f $tablePath ]]; then
        whiptail --title "Error" --msgbox "Table '$tableName' does not exist." 8 45
        return
    fi

    while true; do
        selectMenu=$(whiptail --title "Select Menu" --fb --menu "Select options:" 17 60 0 \
            "1" "Select All Columns" \
            "2" "Select Specific Row" \
            "3" "Select Specific Column" \
            "4" "Select With Where Condition" \
            "5" "Back to Table Menu" \
            "6" "Back to Main Menu" 3>&1 1>&2 2>&3)

        case $selectMenu in
            1) # Select All Table Data
                tableData=$(cat "$tablePath")
                echo "$tableData" > /tmp/table_data.tmp
                whiptail --title "All Table Data" --scrolltext --textbox /tmp/table_data.tmp 30 60
                rm -f /tmp/table_data.tmp

                ;;

            2) # Select Specific Row
                columnName=$(awk -F: 'NR==1 {print $0}' "$tablePath" | tr ':' '\n' | \
                    whiptail --title "Select Column" --menu "Choose a column to filter by:" 20 60 15 \
                    $(awk -F: 'NR==1 {for (i=1; i<=NF; i++) print i, $i}' "$tablePath") 3>&1 1>&2 2>&3)
                
                filterValue=$(whiptail --title "Filter Value" --inputbox "Enter value for '$columnName':" 8 45 3>&1 1>&2 2>&3)
                filteredRow=$(awk -F: -v col="$columnName" -v val="$filterValue" \
                    'NR==1 {for (i=1; i<=NF; i++) if ($i==col) colIndex=i} NR>1 && $colIndex==val {print $0}' "$tablePath")

                if [[ -z $filteredRow ]]; then
                    whiptail --title "No Data" --msgbox "No matching row found for $columnName='$filterValue'." 8 45
                else
                    whiptail --title "Filtered Row" --scrolltext --msgbox "$filteredRow" 20 60
                fi
                ;;

            3) # Select Specific Column(s)
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

            4) # Select with Where Condition
                echo "Select with Where Condition"
                . "$SCRIPT_DIR/selectwhere.sh"
                ;;

            5) # Back to Table Menu
                echo "Back to Table Menu"
                . "$SCRIPT_DIR/tablemenu.sh" "$PROJECT_ROOT"
                break
                ;;

            6) # Back to Main Menu
                echo "Back to Main Menu"
                cd ..
                . "$PROJECT_ROOT/main.sh" "$PROJECT_ROOT"
                break
                ;;

            *) # Invalid Option
                whiptail --title "Invalid Option" --msgbox "Please select a valid option!" 10 40
                ;;
        esac
    done
}

selectmenu "$@"
