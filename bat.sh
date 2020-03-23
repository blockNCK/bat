#!/bin/bash
#

readiness_probe(){
  sleep 3
}

echo "----------------------------------------------------------------------------------------------------"
echo "                                  Invoke wallet services                                            "
echo "----------------------------------------------------------------------------------------------------"

echo "----------------------------------------------------------------------------------------------------"
echo "                                  Query blockchain using block index                                "
echo "----------------------------------------------------------------------------------------------------"

results=$(node query.js)
echo $results

readiness_probe


chmod +x yamlParser.sh
eval $(./yamlParser.sh config.yaml )

if $database = "mongodb"
  if [[ ! $(which mongo) ]]
  then
  display_msg "Install mongodb\n"
  sudo apt update
  sudo apt install -y mongodb
  fi


fi
