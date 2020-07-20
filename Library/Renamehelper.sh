#!/bin/bash

######################################################################################################
# Crated by Claudio Gardini | anykeyIT
# Use this Script with JAMF Pro to Rename Computers
# There are three ways of using it
#
# 1. Create a CSV containing Serialnumber and Devicename and save it as /private/tmp/computernames.csv on all Machine you would like to rename.
# Run the Script using "/usr/local/bin/jsssr "Renamehelper.sh"" and it will set the Devicename using the corresponding Serial
#
# 2. Host the CSV File online and enter the URL as the first Argument. eg. /usr/local/bin/jsssr "Renamehelper.sh" "https://ewolke.ch/index.php/s/asyjZ78Zt01jyyB/download"
#
# 3. Use "/usr/local/bin/jsssr "Renamehelper.sh" "serialnumber" to set the Serial Number as Device Name. You can optionally enter Prefix or Suffix
# eg. usr/local/bin/jsssr "Renamehelper.sh" "serialnumber" "Mac_" "_anykey" gives the Devicename "Mac_C02RQ1BFFVH7_anykey"
######################################################################################################

readonly csvURL="${1}"
readonly prefix="${2}"
readonly suffix="${3}"

csvPath="/private/tmp/computernames.csv"

# If first argument is "serialnumber" we are assigning the Serial as Computername

if [ "${1}" == "serialnumber" ]; then
  echo "==> Use serialnumber as name..."
  jamf setComputerName -useSerialNumber -prefix "${prefix}" -suffix "${suffix}"
else

  # Check if CSV file exists and try to download

  if [ -f "${csvPath}" ]; then
    echo "==> CSV File found, continuing with local copy..."
  else
    echo "==> No local CSV File found, downloading from URL..."
    curl -L -o "${csvPath}" "${csvURL}"
  fi

  # Rename computers

  jamf setComputerName -fromFile "${csvPath}"

  # Delete the computernames.csv File

  rm -f "${csvPath}"

fi

# Update computer inventory

/usr/local/bin/jamf recon
