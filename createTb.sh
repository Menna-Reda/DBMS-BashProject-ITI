#!/usr/bin/bash

dbName=$1
echo "Database Name: $dbName"

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases/$dbName"

# Ensure database directory exists
if [[ ! -d "$DB_PATH" ]]; then
    echo "Database $dbName does not exist. Please create it first."
    exit 1
fi

tbName=$(whiptail --title "Create Table" --inputbox "Enter your table name to create:" 8 45 3>&1 1>&2 2>&3)

if [[ -f "$DB_PATH/$tbName" ]]; then
    whiptail --title "Create Table Message" --msgbox "The table $tbName already exists!" 8 45
else
    colNumber=$(whiptail --title "Column Number" --inputbox "Enter the number of columns:" 8 45 3>&1 1>&2 2>&3)

    if ! [[ $colNumber =~ ^[0-9]+$ ]] || [[ $colNumber -le 0 ]]; then
        whiptail --title "Error Message" --msgbox "Enter a valid positive number for columns!" 8 45
        exit 1
    fi

    touch "$DB_PATH/$tbName"
    touch "$DB_PATH/.$tbName"
    echo "Successfully created the table files."

    i=1
    flag=0
    fasel=":"
    while [[ $i -le $colNumber ]]; do
        colName=$(whiptail --title "Column Name" --inputbox "Enter Column $i Name:" 8 45 3>&1 1>&2 2>&3)

        datatypeMenu=$(whiptail --title "Data Type Menu" --fb --menu "Select Data Type:" 15 60 4 \
            "1" "int" \
            "2" "string" 3>&1 1>&2 2>&3)

        case $datatypeMenu in
            1) datatype="int" ;;
            2) datatype="string" ;;
        esac

        isPrimary=""
        if [[ $flag -eq 0 ]]; then
            primarykeyMenu=$(whiptail --title "Primary Key Menu" --fb --menu "Is this column a primary key?" 15 60 4 \
                "1" "Yes" \
                "2" "No" 3>&1 1>&2 2>&3)

            case $primarykeyMenu in
                1)
                    isPrimary="PK"
                    flag=1
                    ;;
                2) isPrimary="" ;;
            esac
        fi

        # Write to files
        if [[ $i -eq $colNumber ]]; then
            if [[ $isPrimary == "PK" ]]; then 
                echo -n "$colName" >> "$DB_PATH/$tbName"
                echo "$colName$fasel$datatype$fasel$isPrimary" >> "$DB_PATH/.$tbName"
            else 
                echo -n "$colName" >> "$DB_PATH/$tbName"
                echo "$colName$fasel$datatype" >> "$DB_PATH/.$tbName"
            fi	
        else
            if [[ $isPrimary == "PK" ]]; then 
                echo -n "$colName$fasel" >> "$DB_PATH/$tbName"
                echo "$colName$fasel$datatype$fasel$isPrimary$fasel" >> "$DB_PATH/.$tbName"
            else 
                echo -n "$colName$fasel" >> "$DB_PATH/$tbName"
                echo "$colName$fasel$datatype$fasel" >> "$DB_PATH/.$tbName"
            fi
        fi

        ((i++))
    done

    whiptail --title "Create Table Message" --msgbox "You created the table $tbName successfully!" 8 45
fi

if [[ -f "$SCRIPT_DIR/tableMenu.sh" ]]; then
    source "$SCRIPT_DIR/tableMenu.sh"
else
    echo "Error: tableMenu.sh not found!"
    exit 1
fi