#!/bin/bash

	if [ "$(/usr/bin/curl -sL -w "%{http_code}" "http://google.com/" -o /dev/null)" == "200" ]; then

		jamfProURL=$(/usr/bin/defaults read /Library/Preferences/com.jamfsoftware.jamf.plist jss_url)
		jamfProLogFile="/var/log/jamf.log"
		jamfProCheckLogFile="/var/log/jamfprocheck.log"

		if [ $(/usr/bin/defaults read "/Library/Preferences/com.jamfsoftware.jamf" do_not_upgrade_jamf) == 1 ]; then
			echo "$(/bin/date) ==> Jamf binary could be outdated, perform update..." >> "${jamfProCheckLogFile}"
			/usr/bin/defaults write "/Library/Preferences/com.jamfsoftware.jamf" do_not_upgrade_jamf -bool false
			/usr/bin/killall jamf && sleep 5 && /usr/local/bin/jamf policy
		else
			echo "$(/bin/date) ==> Jamf binary is up-to-date." >> "${jamfProCheckLogFile}"
		fi

		if [ $(/bin/date -j -v -20M +%s) -gt $(/usr/bin/stat -f "%m%t %Y" $jamfProLogFile) ]; then
			echo "$(/bin/date) ==> It seems, that the jamf binary did not run the last 20 minutes" >> "${jamfProCheckLogFile}"
			/usr/bin/killall jamf && sleep 5 && /usr/local/bin/jamf policy
			exit 0
		else
			echo "$(/bin/date) ==> It seems, that the jamf binary is running properly." >> "${jamfProCheckLogFile}"
			exit 0
		fi

	else

		echo "$(/bin/date) ==> Do not check, computer is offline." >> "${jamfProCheckLogFile}"
		exit 0

	fi