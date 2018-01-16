#!/bin/bash

	# appleLoops
	
	if [ -s "/usr/local/bin/appleLoops" ]; then
		rm -f "/usr/local/bin/appleLoops"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/appleLoops" "https://raw.githubusercontent.com/carlashley/appleLoops/master/appleLoops.py"

	/usr/sbin/chown root:wheel "/usr/local/bin/appleLoops"
	/bin/chmod 775 "/usr/local/bin/appleLoops"
	/bin/chmod +x "/usr/local/bin/appleLoops"

	# dockutil
	
	if [ -s "/usr/local/bin/dockutil" ]; then
		rm -f "/usr/local/bin/dockutil"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/dockutil" "https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil"

	/usr/sbin/chown root:wheel "/usr/local/bin/dockutil"
	/bin/chmod 775 "/usr/local/bin/dockutil"
	/bin/chmod +x "/usr/local/bin/dockutil"