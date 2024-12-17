#!/usr/bin/bash
function exitScript() {
    whiptail --title "Exit" --yesno "Are you sure you want to exit?" 10 40
    if [[ $? -eq 0 ]]; then
        whiptail --title "Goodbye" --msgbox "Thank you for using our DBMS!" 10 40
        exit 0
    fi
}
exitScript