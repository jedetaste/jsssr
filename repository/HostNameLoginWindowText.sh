#!/bin/bash

	computerName=$(scutil --get ComputerName)
	propertyList="/Library/Preferences/com.apple.loginwindow"
	
	/usr/bin/defaults write "${propertyList}" LoginwindowText "${computerName}"
	
exit 0