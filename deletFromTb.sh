#!/bin/bash
db_Name=$1
SCRIPT_DIR=$(dirname "$(realpath "$0")")  # Get the directory of the current script
echo "from delete from tb $SCRIPT_DIR"
DB_PATH="$SCRIPT_DIR/DataBases/$db_Name"

tableName=$(whiptail --title "Select Table" --inputbox "Enter Table Name:" 8 45 3>&1 1>&2 2>&3)
tablePath="$DB_PATH/$tableName"

if ! [[ -f $tablePath ]]; then
    whiptail --title "Error Message" --msgbox "Table doesn't exist" 8 45
    source "$SCRIPT_DIR/tablemenu.sh"
else
    colname=$(whiptail --title "Table Records" --inputbox "Enter Column Name" 8 45 3>&1 1>&2 2>&3)
    checkcolumnfound=$(awk -F: -v colname="$colname" '
        NR == 1 {
            for (i = 1; i <= NF; i++) {
                if ($i == colname) {
                    print i;
                    exit;
                }
            }
        }
    ' "$tablePath")

    if [[ -z $checkcolumnfound ]]; then
        whiptail --title "Error Message" --msgbox "Column doesn't exist" 8 45
    else
        value=$(whiptail --title "Column Record" --inputbox "Enter Your Value" 8 45 3>&1 1>&2 2>&3)
        recordNo=$(awk -F: -v col="$checkcolumnfound" -v val="$value" '
            $col == val {
                print NR;
            }
        ' "$tablePath")

        if [[ $recordNo == 1 ]]; then
            whiptail --title "Error Message" --msgbox "This record can't be deleted (header row)." 8 45
        elif [[ -z $recordNo ]]; then
            whiptail --title "Error Message" --msgbox "Record doesn't exist" 8 45
        else
           # Debugging: Confirm what `recordNo` holds
            echo "Deleting record at line: $recordNo"
            sed -i "${recordNo}d" "$tablePath"

            # Check if deletion was successful
            if [[ $? -eq 0 ]]; then
                whiptail --title "Success" --msgbox "Record deleted successfully" 8 45
            else
                whiptail --title "Error Message" --msgbox "Failed to delete record" 8 45
            fi
        fi
    fi

    source "$SCRIPT_DIR/tablemenu.sh"
fi
