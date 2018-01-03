#!/bin/bash
	
	# Get device interface for WiFi
	
	WiFiID=$(/usr/sbin/networksetup -listallhardwareports | grep -A1 Wi-Fi | grep Device | awk '{print $2}')
	
	# WiFi must be powered on to determine current location
	
	/usr/sbin/networksetup -setairportpower "${WiFiID}" on
	
	# Pause to enable location services to load properly
	
	sleep 7
	
	# Enable location services
	
	UUID=$(/usr/sbin/system_profiler SPHardwareDataType | grep "Hardware UUID" | cut -c22-57)
	
	/usr/sbin/systemsetup -setusingnetworktime off
	/usr/sbin/systemsetup -setnetworktimeserver "time.euro.apple.com"
	
	/usr/bin/defaults write "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${UUID}" LocationServicesEnabled -int 1
	/usr/sbin/chown -R _locationd:_locationd "/var/db/locationd"
	
	# Configure time settings
	
	/usr/bin/defaults write "/Library/Preferences/com.apple.timezone.auto" Active -bool true
	/usr/sbin/systemsetup -setusingnetworktime on 
	/usr/sbin/systemsetup -getnetworktimeserver
	/usr/sbin/systemsetup -gettimezone
	/usr/sbin/ntpdate -u "time.euro.apple.com"
	
exit 0
