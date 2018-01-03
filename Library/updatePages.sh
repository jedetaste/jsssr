#!/bin/bash

	cdnPort=$(nc -z cdn.anykeyit.ch 8080; echo $?)
	cdnIP=$(host cdn.anykeyit.ch|awk '{print $NF}')

	if [ "${cdnPort}" != "1" ] || [ "$cdnIP" == "217.150.247.87" ]; then
		echo "No local CDN detected. Exiting Script."
		exit 1
	else
		echo "cdn.anykeyit.ch resolves to a local IP. Continuing...."
	fi
	
	# Get the current time at the start of the script run
	startTime=$(date +"%s")

	# Determine OS version
	osvers=$(sw_vers -productVersion | awk -F. '{print $2}')

	# Install or Upgrades all iWorks and iLife Apps to the latest Version for the current OS Version

	if [[ ${osvers} -eq 9 ]]; then
		echo "Upgrading Pages for Mavericks"
		/usr/local/bin/aky pages1009
	fi

	if [[ ${osvers} -eq 10 ]]; then
		echo "Upgrading Pages for Yosemite"
		/usr/local/bin/aky pages1010
	fi

	if [[ ${osvers} -eq 11 ]]; then
		echo "Upgrading Pages for El Capitain"
		/usr/local/bin/aky pages1011
	fi

	if [[ ${osvers} -eq 12 ]]; then
		echo "Upgrading Pages for Sierra"
		/usr/local/bin/aky pages1012
	fi

	if [[ ${osvers} -eq 13 ]]; then
		echo "Upgrading Pages for High Sierra"
		/usr/local/bin/aky pages1013
	fi
	
	# Get the current time at the end of the script run
	endTime=$(date +"%s")
	echo "Run time: $((endTime-startTime)) seconds..."

exit 0