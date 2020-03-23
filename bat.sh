#!/bin/bash
#

readiness_probe(){
  sleep 3
}

echo "----------------------------------------------------------------------------------------------------"
echo "                                  Invoke wallet services                                            "
echo "----------------------------------------------------------------------------------------------------"

yamlParser config.yaml

if database = "mongo"
  if [[ ! $(which mongo) ]]
  then
  display_msg "Install mongodb\n"
  sudo apt update
  sudo apt install -y mongodb
  fi
fi
