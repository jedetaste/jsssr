#!/bin/bash
	
	latestversion=$(curl -sf "http://www.microsoft.com/getsilverlight/locale/en-us/html/Microsoft%20Silverlight%20Release%20History.htm" 2>/dev/null | grep -m1 "Silverlight 5 Build" | awk -F'[>|<]' '{print $2}' | tr ' ' '\n' | awk '/Build/ {getline; print}')
	echo "Latest available version is: ${latestversion}"
	
	if [ -e "/Library/Internet Plug-Ins/Silverlight.plugin" ]; then
		
		currentversion=$(/usr/bin/defaults read "/Library/Internet Plug-Ins/Silverlight.plugin/Contents/Info" CFBundleVersion)
		echo "Current installed version is: ${currentversion}"
		
		if [ ${latestversion} == ${currentversion} ]; then
			
			echo "Silverlight plugin is current"
			echo "Exit"
			
			exit 0
			
		fi
		
	else
		
		installed="false"
		echo "Silverlight is not installed"
		
	fi
	
	if [ "${currentversion}" != "${latestversion}" ] || [ "${installed}" == "false" ]; then
		
		echo "Download Silverlight ..."
		randstring=$(openssl rand -hex 5)
		tmp="/private/tmp/${randstring}"
		mkdir -p "${tmp}"
		cd "${tmp}"; curl -# -O -J -L "http://download.microsoft.com/download/0/3/E/03EB1393-4F4E-4191-8364-C641FAB20344/50901.00/Silverlight.dmg"; cd
		
		echo "Mount downloaded DMG ..."
		/usr/bin/hdiutil attach "${tmp}/Silverlight.dmg" -nobrowse -quiet
		sleep 1
		
		echo "Install Silverlight ..." 
		installer -pkg "/Volumes/Silverlight/silverlight.pkg" -target /
		
		echo "Unmount DMG ..."
		hdiutil detach $(/bin/df | /usr/bin/grep "Silverlight" | awk '{print $1}') -quiet -force
				
		echo "Remove temporary folder ..."
		rm -rf "${tmp}"
		
	fi

exit 0