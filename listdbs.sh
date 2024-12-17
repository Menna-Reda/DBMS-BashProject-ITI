#!/usr/bin/bash

function listDBs() {
 
    DatabasesNo=$( ls -d Databases/* |wc -l )
    DatabasesList=$( ls -d Databases/* )
     whiptail --title "List of DataBases" --msgbox "Number of databases: $DatabasesNo\n $databaselist" 10 40
}
listDBs