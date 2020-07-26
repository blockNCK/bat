#!/bin/bash
#

echo "  ____  _            _                           _       _   _            _______          _  "
echo " |  _ \| |          | |        /\               | |     | | (_)          |__   __|        | | "
echo " | |_) | | ___   ___| | __    /  \   _ __   __ _| |_   _| |_ _  ___ ___     | | ___   ___ | | "
echo " |  _ <| |/ _ \ / __| |/ /   / /\ \ |  _ \ / _  | | | | | __| |/ __/ __|    | |/ _ \ / _ \| | "
echo " | |_) | | (_) | (__|   <   / ____ \| | | | (_| | | |_| | |_| | (__\__ \    | | (_) | (_) | | "
echo " |____/|_|\___/ \___|_|\_\ /_/    \_\_| |_|\__,_|_|\__, |\__|_|\___|___/    |_|\___/ \___/|_| "
echo "                                                    __/ |                                     "
echo "                                                   |___/                                      "

readiness_probe(){
  sleep 3
}

#---------------------------------------------------------------------------------------------------
#                                 Read yaml file                                                    
#---------------------------------------------------------------------------------------------------

echo "Read yaml file"
chmod +x yamlParser.sh
eval $(./yamlParser.sh config.yaml )
readiness_probe
#---------------------------------------------------------------------------------------------------
#                                 Setup database                                                    
#---------------------------------------------------------------------------------------------------

echo "Setup database"
echo "Choosing the BDC as mysql"
echo "Mapping the data requested to match with the block index"
echo "Generate the necessary rules"
echo "Query the block index and acquire data"
echo "Process the data using the BAT processor"
echo "Load the data to the BDC"
echo "Retrieve data from the BDC "
if [ "$database" = "mongodb" ]
  then
  if [[ !$(which mongo) ]]
    then
    display_msg "Install mongodb\n"
    sudo apt update
    sudo apt install -y mongodb
    readiness_probe
  fi
fi

if [ "$database" = "mysql" ]
  then
  if [[ !$(which mysql) ]]
    then
    display_msg "Install mysql\n"
    sudo apt update
    sudo apt install mysql-client-core-5.7
  fi
fi

#----------------------------------------------------------------------------------------------------
#                       Query blockchain and save files to the database                              
#----------------------------------------------------------------------------------------------------

echo "Query blockchain and save files to the database"
node batRun.js 1>&3
readiness_probe
#---------------------------------------------------------------------------------------------------
#                      Create the model using the data acquired                                     
#---------------------------------------------------------------------------------------------------

echo "Create the model using the data acquired"
if [ $analysis_type = "tensorflow" ]
  then
  if [[ ! $(which pip) ]]
    then
    display_msg "Install pip\n"
    sudo apt update
    sudo apt install python-pip
    readiness_probe
  fi
fi
readiness_probe
python demandforecast.py



