#!/bin/bash

/usr/local/bin/aky "docker"

cp "/Applications/Docker.app/Contents/Library/LaunchServices/com.docker.vmnetd" "/Library/PrivilegedHelperTools/"
cp "/Applications/Docker.app/Contents/Resources/com.docker.vmnetd.plist" "/Library/LaunchDaemons/"

chmod 544 "/Library/PrivilegedHelperTools/com.docker.vmnetd"
chmod 644 "/Library/LaunchDaemons/com.docker.vmnetd.plist"

launchctl load "/Library/LaunchDaemons/com.docker.vmnetd.plist"
