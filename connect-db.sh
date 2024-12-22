#! /usr/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
DB_PATH="$SCRIPT_DIR/DataBases"

function connect {
        dbConnect=$(whiptail --title "Connect to DataBase" --inputbox "Enter your database name to connect" 8 45 3>&1 1>&2 2>&3)
        path_DB="$DB_PATH/$dbConnect"
        if [[ -z $dbConnect ]]; then
            whiptail --title "Invalid database name" --msgbox "Cannot connect database with blank name" 10 40
    
        elif [ -d $dbConnect ]; then
             cd $path_DB
             whiptail --title "Connected to $dbConnect" --msgbox "Connected successfully to $dbConnect " 8 45
             
             source tableMenu.sh $dbConnect
        else
                whiptail --title "Error Message" --msgbox "Connection failed" 8 45
	        source main.sh  

fi                                

}

connect