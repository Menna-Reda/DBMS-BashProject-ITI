#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function updateTable(){
    dbName=$1
    tbName=$(whiptail --title "Select table" --inputbox "Enter your table name to update" 8 45 3>&1 1>&2 2>&3)
    valToUpdate=""
    if ! [[ -f "$DB_PATH/$dbName/$tbName" ]]; then
        whiptail --title "Error Message" --msgbox "No such table in $dbName database!" 10 40
    else
        colNo=$(awk -F: 'END { print NR }' "$DB_PATH/$dbName/.$tbName")
        declare -a  columnNames
        for ((i=1;i<=colNo;i++));do
            colName=$(awk -F: -v i=$i 'NR==1 {print $i}' "$DB_PATH/$dbName/$tbName")
            columnNames+=("$i" "$colName")
        done
        selectedColumnName=$(whiptail --title "Select Column" --menu "Choose a column to filter by:" 15 40 $colNo "${columnNames[@]}" 3>&1 1>&2 2>&3)
       
        if [[ -z "$selectedColumnName" ]]; then
            whiptail --title "Error Message" --msgbox "No column to filter by selected!" 10 40
        else
          valToUpdate=$(whiptail --title "Selected Column" --inputbox "Enter value you want to filter by for column: ${columnNames[$selectedColumnName]}" 10 40 3>&1 1>&2 2>&3)
          echo "Selected Column: $selectedColumnName"
        echo "Value to filter: $valToUpdate"
        #   checkValToUpdate=$(awk -v f="$selectedColumnName" -v valToUpdate="$valToUpdate" '
        #                                                                                         BEGIN { FS=":" }
        #                                                                                         $f == $valToUpdate { print $valToUpdate; exit }
        #                                                                                     ' "$DB_PATH/$dbName/$tbName")
           if [[ -z "$valToUpdate" ]]; then
            whiptail --title "Error Message" --msgbox "No value to filter by is entered!" 10 40
            # elif [[ -z $checkValToUpdate ]];then
            #     whiptail --title "Error Message" --msgbox "No value $valToUpdate in ${columns[$selectedColumnName]}!" 10 40
            #     . "$SCRIPT_DIR/tableMenu.sh"
    
            
           else
                columnToChange=$(whiptail --title "Select Column" --menu "Choose a column you want to update:" 15 40 $colNo "${columnNames[@]}" 3>&1 1>&2 2>&3)
                echo $columnToChange
                declare -a  columns
                for ((i=1;i<=colNo;i++));do
                    colName=$(awk -F: -v i=$i 'NR==1 {print $i}' "$DB_PATH/$dbName/$tbName")
                    columns[i]=$colName
                done
                PK=$(awk -F: -v name="${columns[$columnToChange]}" '{ if ($1 == name) print $3 }' "$DB_PATH/$dbName/.$tbName")
                echo $PK
                dataType=$(awk -F: -v name="${columns[$columnToChange]}" '{ if ($1 == name) print $2 }' "$DB_PATH/$dbName/.$tbName")
                echo $dataType

                if [[ "$PK" == "PK" ]];then
                        whiptail --title "Error Message" --msgbox "Can't modify a primary key!" 10 40
                        . "$SCRIPT_DIR/tableMenu.sh"
                fi
                echo ${columns[@]}
                if [[ -z "$columnToChange" ]]; then
                    whiptail --title "Error Message" --msgbox "No column to change is selected!" 10 40
                else
                    newVal=$(whiptail --title "Selected Column" --inputbox "Enter new value you want to update for ${columns[$columnToChange]} :" 10 40 3>&1 1>&2 2>&3)
                    
                    if [[ -z $valToUpdate ]]; then
                        whiptail --title "Error Message" --msgbox "No value is entered!" 10 40

                    else
                        done=1
                         if [[ $dataType == "int" ]]; then
                            if ! [[ $newVal =~ ^[0-9]+$ ]]; then
                            
                                whiptail --title "Error Message" --msgbox "Wrong datatype, ${columns[$columnToChange]}  accpets integer only" 10 40
                                done=0

                            fi  
                        fi
                        if(($done==1));then
                            awk -v newVal="$newVal" -v selectedColumnName="$selectedColumnName" -v valToUpdate="$valToUpdate" -v columnToChange="$columnToChange" '
                            BEGIN { FS=":"; OFS=":" }
                            {
                                if ($selectedColumnName == valToUpdate)
                                    $columnToChange = newVal;
                                print $0
                            }' "$DB_PATH/$dbName/$tbName" > temp.txt && mv temp.txt "$DB_PATH/$dbName/$tbName"

                            whiptail --title "Success Message" --msgbox " ${columns[$columnToChange]} is updated to $newVal where ${columns[$selectedColumnName]}= $valToUpdate !" 10 55
                        fi
                    fi
                    
                fi
            fi

        fi
    fi
}
updateTable $1