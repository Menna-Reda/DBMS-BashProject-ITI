#! /usr/bin/bash


if [ ! -d "$database_name" ]; then
                echo "Database not found. Please enter the name again."
                read -p "Enter name of database: " database_name
            else
                cd "$database_name"
                echo "Connected to database: $PWD"
                echo "Choose an option: "
fi                
