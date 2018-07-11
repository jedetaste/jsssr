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

    # If first Argument is "serialnumber" use Serial to set Computername. 
    if [ "${1}" == "serialnumber" ]; then
      echo "using serialnumber"
      jamf setComputerName -useSerialNumber -prefix $prefix -suffix $suffix
    else
      # Check if CSV File exists and try to Download if necessary. 
       if [ -f "$csvPath" ]; then
            echo "CSV File found. Continuing with local copy."
        else
            echo "CSV File no found. Downloading"
            curl -L -o $csvPath $csvURL
        fi
          # Renaming Computer
        jamf setComputerName -fromFile "$csvPath"
        # Delete the computernames.csv
        rm "$csvPath"    
      fi  

    #update Jamf Pro inventory
    /usr/local/bin/jamf recon
