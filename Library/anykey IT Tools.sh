#!/bin/bash
	
	if [ ! -d "/usr/local/bin" ]; then
		mkdir -p "/usr/local/bin"
	fi
	
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
	
	# currentuser
	
	if [ -s "/usr/local/bin/currentuser" ]; then
		rm -f "/usr/local/bin/currentuser"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/currentuser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/currentuser"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/currentuser"
	/bin/chmod 775 "/usr/local/bin/currentuser"
	/bin/chmod +x "/usr/local/bin/currentuser"
	
	# csc
	
	if [ -s "/usr/local/bin/csc" ]; then
		rm -f "/usr/local/bin/csc"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/csc" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/csc"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/csc"
	/bin/chmod 775 "/usr/local/bin/csc"
	/bin/chmod +x "/usr/local/bin/csc"
	
	# defaultbrowser
	
	if [ -s "/usr/local/bin/defaultbrowser" ]; then
		rm -f "/usr/local/bin/defaultbrowser"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/defaultbrowser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/defaultbrowser"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/defaultbrowser"
	/bin/chmod 775 "/usr/local/bin/defaultbrowser"
	/bin/chmod +x "/usr/local/bin/defaultbrowser"
	
	# mysides
	
	if [ -s "/usr/local/bin/mysides" ]; then
		rm -f "/usr/local/bin/mysides"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/mysides" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/mysides"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/mysides"
	/bin/chmod 775 "/usr/local/bin/mysides"
	/bin/chmod +x "/usr/local/bin/mysides"
	
	# pkgfixer
	
	if [ -s "/usr/local/bin/pkgfixer" ]; then
		rm -f "/usr/local/bin/pkgfixer"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/pkgfixer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/pkgfixer"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/pkgfixer"
	/bin/chmod 775 "/usr/local/bin/pkgfixer"
	/bin/chmod +x "/usr/local/bin/pkgfixer"
	
	# blueutil
	
	if [ -s "/usr/local/bin/blueutil" ]; then
		rm -f "/usr/local/bin/blueutil"
	fi
	
	/usr/bin/curl -sfko "/usr/local/bin/blueutil" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/blueutil"
	
	/usr/sbin/chown root:wheel "/usr/local/bin/blueutil"
	/bin/chmod 775 "/usr/local/bin/blueutil"
	/bin/chmod +x "/usr/local/bin/blueutil"