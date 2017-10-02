 #!/bin/bash
 
  echo "Download Silverlight ..."
	randstring=$(openssl rand -hex 5)
  tmp="/private/tmp/${randstring}"
  mkdir -p "${tmp}"
  cd "${tmp}"; curl -# -O -J -L "http://download.microsoft.com/download/0/3/E/03EB1393-4F4E-4191-8364-C641FAB20344/50901.00/Silverlight.dmg"; cd
  
  echo "Mount downloaded DMG ..."
  /usr/bin/hdiutil attach "${tmp}/Silverlight.dmg" -nobrowse -quiet
		
  echo "Install Silverlight ..." 
  installer -pkg "/Volumes/Silverlight/silverlight.pkg" -target /
		
  echo "Unmount DMG ..."
  hdiutil detach $(/bin/df | /usr/bin/grep "Silverlight" | awk '{print $1}') -quiet -force
				
  echo "Remove temporary folder ..."
  rm -rf "${tmp}"

exit 0
