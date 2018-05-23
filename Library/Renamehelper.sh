#!/bin/bash

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
    			echo "CSV File found. Continuing...."
  			else
    			echo "CSV File no found. Downloading"
    			curl -L -o $csvPath $csvURL
  			fi
  				# Renaming Computer
				jamf setComputerName -fromFile "$csvPath"
				#delete the computernames.csv
				rm "$csvPath"
				
  		fi	

		#update Jamf Pro inventory
		jamf recon
		
exit 0 