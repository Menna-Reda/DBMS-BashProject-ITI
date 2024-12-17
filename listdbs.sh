#!/usr/bin/bash

function listDBs() {
 
    DatabasesNo=$( ls -d DataBases/* |wc -l )
    DatabasesList=$( ls -d DataBases/* | cut -d/ -f2)
     whiptail --title "List of DataBases" --msgbox "Number of databases: $DatabasesNo\n$DatabasesList" 10 40
}
listDBs