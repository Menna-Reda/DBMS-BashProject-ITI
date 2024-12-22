#!/bin/bash

db_Name=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
DB_PATH="$SCRIPT_DIR/DataBases/$db_Name"

tableName=$2
tbPath="$DB_PATH/$tableName"

if ! [[ -f $tbPath ]]; then
    whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
    source "$SCRIPT_DIR/selectmenu.sh"
else
    colname=$(whiptail --title "Table Records" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
    checkcolumnfound=$(awk -F: -v colname="$colname" '
        NR==1 {
            for (i=1; i<=NF; i++) {
                if ($i == colname) {
                    print i;
                    exit;
                }
            }
        }
    ' "$tbPath")

    if [[ -z $checkcolumnfound ]]; then
        whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
    else
        value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
        record=$(awk -F: -v col="$checkcolumnfound" -v val="$value" '
            $col == val {
                print $0;
            }
        ' "$tbPath")

        if [[ -z $record ]]; then
            whiptail --title "Error Message" --msgbox "Record not found" 8 45
        else
            whiptail --title "Record" --msgbox "$record" 15 45
        fi
    fi

    source "$SCRIPT_DIR/selectmenu.sh"
fi
