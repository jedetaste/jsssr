#!/bin/bash
	
	currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
	
	echo "Enable ownCloud finder sync extension for user ${currentUser}"
	
	su -l "${currentUser}" -c "pluginkit -e use -i com.owncloud.desktopclient.FinderSyncExt"
	
exit 0