#!/bin/sh

	# Change language if necessary e.g. MicrosoftOffice2011Update_EN.pkg.zip

	# Check if Microsoft Office 2011 is installed
	if [ -e "/Applications/Microsoft Office 2011/Microsoft Word.app" ]; then

		# Get the current available Microsoft Office 2011 version
		latestver=(/usr/bin/curl -s -A "$userAgent" http://cdn-cloud.anykeyit.ch/CasperShare/Packages/MicrosoftOffice2011Update/currentversion.php | /usr/bin/awk '{print $1}')
		/bin/echo "$(date): Latest Version is: $latestver..."

		# Get the version number of the currently-installed Microsoft Office 2011
		currentinstalledver=$(/usr/bin/defaults read "/Applications/Microsoft Office 2011/Microsoft Word.app/Contents/Info" CFBundleShortVersionString | /usr/bin/awk '{print $1}')
		/bin/echo "$(date): Current installed version is: $currentinstalledver"

		if [ ${latestver} = ${currentinstalledver} ]; then

			/bin/echo "$(date): Microsoft Office 2011 is current..."
			/bin/echo "$(date): Exit..."
			exit 0

		else

			/usr/local/jamf/bin/jamf policy -trigger runoffice2011update

		fi

	# If Microsoft Office 2011 is not installed then exit
	else

		/bin/echo "$(date): Microsoft Office 2011 is not installed..." 
		/bin/echo "$(date): Exit..."

	fi

exit 0