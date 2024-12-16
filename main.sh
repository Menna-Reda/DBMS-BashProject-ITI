#! /usr/bin/bash

DB_PATH=~/iti\ projects/DBMS-BashProject-ITI/DataBases

if [[ ! -d "$DB_PATH" ]]; then
    mkdir -p "$DB_PATH"
fi
cd "$DB_PATH" || exit
echo "DBMS is ready"

select option in createDB ConnectDB DropDB listDB exit
do
case $option in 
"createDB")
	read -p "Please Enter Database name: " dbName
	
;;
"ConnectDB")
	connectDB=$connectDB ./connect-db.sh
;;
"DropDB")
	 if [[ -f ./drop-db.sh ]]; then
                dropDB=$dropDB ./drop-db.sh
            else
                echo "Error: 'drop-db.sh' script not found!"
           fi
;;
	"listDB")
	
;;
"exit")
            echo "Exiting..."
            break
            ;;
*)
            echo "Invalid option. Please try again."
            ;;
esac
done
