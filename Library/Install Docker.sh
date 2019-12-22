#!/bin/bash

	/usr/local/bin/aky docker
#	/Applications/Docker.app/Contents/MacOS/Docker --quit-after-install --unattended
#	nohup /Applications/Docker.app/Contents/MacOS/Docker --unattended &
#    defaults write /Applications/Docker.app/Contents/Info.plist SUEnableAutomaticChecks "1"
#    defaults write /Applications/Docker.app/Contents/Info.plist SUAllowsAutomaticUpdates "1"
	/bin/cp "/Applications/Docker.app/Contents/Library/LaunchServices/com.docker.vmnetd" "/Library/PrivilegedHelperTools/"
	/bin/cp "/Applications/Docker.app/Contents/Resources/com.docker.vmnetd.plist" "/Library/LaunchDaemons/"
	/bin/chmod 544 "/Library/PrivilegedHelperTools/com.docker.vmnetd"
	/bin/chmod 644 "/Library/LaunchDaemons/com.docker.vmnetd.plist"
	/bin/launchctl load "/Library/LaunchDaemons/com.docker.vmnetd.plist"
exit 0