#!/bin/bash

	currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

	if [ -z "${currentuser}" ]; then
		
		sudo -u "${currentUser}" /usr/local/bin/mysides remove "All My Files"
		sudo -u "${currentUser}" /usr/local/bin/mysides remove "Alle meine Dateien"
		
	fi

exit 0