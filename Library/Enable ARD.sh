#!/bin/bash
	
	# enableARD
	# Activates AppleRemoteDesktop for User admin and if exists also for User "gucken"
	# 20170512 - 15:58 - tobiaslinder
	
	# Re-Configure ARD and activate for User admin and gucken 
	
	kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
	
	if [ ! -z "$(id -u gucken)" ]; then
		echo "User id gucken exists"
		"${kickstart}" -activate -configure -allowAccessFor -specifiedUsers
		"${kickstart}" -configure -users admin,gucken -access -on -privs -all
		/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add gucken
	else
		echo "User id gucken does not exist"
		"${kickstart}" -activate -configure -allowAccessFor -specifiedUsers
		"${kickstart}" -configure -users admin -access -on -privs -all
	fi
	
	# Deactivate Screen Sharing Request Login
	
	/usr/bin/defaults write /Library/Preferences/com.apple.RemoteManagement ScreenSharingReqPermEnabled -bool NO
	
exit 0