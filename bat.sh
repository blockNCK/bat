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

echo "----------------------------------------------------------------------------------------------------"
echo "                                  Read yaml file                                                    "
echo "----------------------------------------------------------------------------------------------------"


chmod +x yamlParser.sh
eval $(./yamlParser.sh config.yaml )

echo "----------------------------------------------------------------------------------------------------"
echo "                                  Setup database                                                    "
echo "----------------------------------------------------------------------------------------------------"

if $database="mongodb"
  if [[ ! $(which mongo) ]]
  then
  display_msg "Install mongodb\n"
  sudo apt update
  sudo apt install -y mongodb
  fi
fi

if $database="mysql"
  if [[ ! $(which mysql) ]]
  then
  display_msg "Install mysql\n"
  sudo apt update
  sudo apt install mysql-client-core-5.7
  fi
fi

echo "----------------------------------------------------------------------------------------------------"
echo "                       Query blockchain and save files to the database                              "
echo "----------------------------------------------------------------------------------------------------"


node batRun.js

echo "----------------------------------------------------------------------------------------------------"
echo "                       Create the model using the data acquired                                     "
echo "----------------------------------------------------------------------------------------------------"

if $analysis_type="tensorflow"
  if [[ ! $(which pip) ]]
  then
  display_msg "Install pip\n"
  sudo apt update
  sudo apt install python-pip
  fi
fi

python demandforecast.py



