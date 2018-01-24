#!/bin/bash

	# AdobeAIR EULA Acception
	
	for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
		
		if [ ! -s "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then
			
			mkdir -p "/Users/${user}/Library/Application Support/Adobe/AIR/"
			touch "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			echo "3" >> "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			chown ${user} "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			chmod 700 "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			
		else
			
			rm -f "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			touch "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			echo "3" >> "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			chown ${user} "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			chmod 700 "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
			
		fi
		
	done
	
	for usertemplate in "/System/Library/User Template"/*; do
		
		if [ ! -s "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then
		
			mkdir -p "${usertemplate}/Library/Application Support/Adobe/AIR/"
			touch "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted"
			echo "3" >> "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted"
			
		else
			
			rm -f "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted"
			mkdir -p "${usertemplate}/Library/Application Support/Adobe/AIR/"
			touch "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted"
			echo "3" >> "${usertemplate}/Library/Application Support/Adobe/AIR/eulaAccepted"
			
		fi
		
	done
	
exit 0