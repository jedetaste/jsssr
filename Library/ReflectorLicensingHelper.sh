#!/bin/bash

######################################################################################################
# Created by Claudio Gardini | anykeyIT | Nov 2018
# Use this Script to deploy Reflector licences. 
# Enter the desired Reflector Version as Variable 1. Possible Options are "Reflector-2", "Reflector-3", "Reflector-Teacher"
# Enter the Serial as Variable 2
######################################################################################################

  readonly reflectorVersion="${1}"
  readonly Licence="${2}"
 
 	if [ "${reflectorVersion}" == "Reflector-2" ] || [ "${reflectorVersion}" == "Reflector-3" ] || [ "${reflectorVersion}" == "Reflector-Teacher" ]; then
	
		currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
		sudo -u "${currentUser}" /usr/bin/defaults write com.squirrels."${reflectorVersion}" LicenseKey "${Licence}"
	else
		echo "Wrong Variable 1 used. Possible Options are Reflector-2, Reflector-3 or Reflector-Teacher"
		exit 1
	fi
		
	
