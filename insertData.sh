#!/usr/bin/bash
SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"
function insertData(){
    dbName=$1
    tbName=$(whiptail --title "Select table" --inputbox "Enter your table name" 8 45 3>&1 1>&2 2>&3)
    if [[ -f "$DB_PATH/$dbName/$tbName" ]]; then
        colNo=$(awk -F: 'END { print NR }' "$DB_PATH/$dbName/.$tbName")
        echo $colNo "columns"
        dataRow=""
        inserted=$((0))
        for ((i=1;i<=$colNo;i++))
        do 
            colName=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $1 }' $DB_PATH/$dbName/.$tbName`
            echo "$colName name"
            colDataType=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $2 }' $DB_PATH/$dbName/.$tbName`
            echo "$colDataType datatype"
            pkConstrain=`awk 'BEGIN {FS=":"}{if ( NR=='$i' ) print $3 }' $DB_PATH/$dbName/.$tbName`
            echo "$pkConstrain pkConstrain"
            data=$(whiptail --title "Insert Data" --inputbox "Enter your data for $colName" 8 45 3>&1 1>&2 2>&3)
            while [[ -z $data && $pkConstrain == "PK" ]]; do
                whiptail --title "Error Message" --msgbox "Empty data not accepted for $colName, enter your data again" 10 40
                data=$(whiptail --title "Insert Data" --inputbox "Enter your data for $colName" 8 45 3>&1 1>&2 2>&3)
            done

            if [[ $colDataType == "int" ]]; then
                if ! [[ $data =~ ^[0-9]+$ ]]; then
                 
                    whiptail --title "Error Message" --msgbox "Wrong datatype, $colName accpets integer only" 10 40
                    inserted=$((0))
                    break
                fi  
            fi
            if [[ $pkConstrain == "PK" ]]; then
                exists=$((0))
                exists=$(awk -v data="$data" -v col="$i" -F: '
                            {
                                if ($col == data)  
                                {   exists=1 
                                    exit    
                                }  
                            }
                            END { print exists }
                            ' "$DB_PATH/$dbName/$tbName")
                if (( exists == 1 )); then
                    whiptail --title "Error Message" --msgbox "Primary key already exists in column" 10 40
                    inserted=$((0))
                    break
                
                fi
            fi
            if (( $i == 1));then
                dataRow+=$data
            else
                dataRow+=:$data
            fi
            inserted=$((1))
            
        done
        echo -e $dataRow >> $DB_PATH/$dbName/$tbName
        if (( inserted== 1)); then
            whiptail --title "Success Message" --msgbox "Your record inserted successfully" 10 45
        fi

    else
        whiptail --title "Error Message" --msgbox "No such table in $dbName database!" 10 40
    fi
}
insertData $1 