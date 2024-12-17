#! /usr/bin/bash

while true; do
  read -p "Enter database name: " dropDB

  if [ -d "$dropDB" ]; then
    whiptail --title "Drop Databse Message" --msgbox "You deleted $dropName database secessfully" 8 45
    rmdir "$dropDB"
    echo "You deleted the database."
    break
  else
    whiptail --title "Drop Databse Message" --msgbox "Error to delete database $dropName" 8 45
    echo "Directory '$dropDB' does not exist."
    echo "Please enter a different name."
  fi
done
