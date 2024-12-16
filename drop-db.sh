#! /usr/bin/bash

while true; do
  read -p "Enter database name: " dropDB

  if [ -d "$dropDB" ]; then
    rmdir "$name2"
    echo "You deleted the database."
    break
  else
    echo "Directory '$dropDB' does not exist."
    echo "Please enter a different name."
  fi
done
