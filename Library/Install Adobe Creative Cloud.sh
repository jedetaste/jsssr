#!/bin/bash
	
	download="https://ccmdls.adobe.com/AdobeProducts/KCCC/1/osx10/CreativeCloudInstaller.dmg"
	dmg="CreativeCloudInstaller.dmg"
	
	/usr/bin/curl -# -o "/private/tmp/${dmg}" "${download}"
	
	/usr/bin/hdiutil attach -noautoopen -noverify -nobrowse "/private/tmp/${dmg}"
	
	"/Volumes/Creative Cloud Installer/Creative Cloud Installer.app/Contents/MacOS/Install"
	
	hdiutil detach $(/bin/df | /usr/bin/grep "Creative Cloud Installer" | awk '{print $1}') -quiet -force
	
	rm -f "/private/tmp/${dmg}"