#!/bin/bash
  
  versionInstaller="28.0"
  downloadInstaller="https://airdownload.adobe.com/air/mac/download/${versionInstaller}/AdobeAIR.dmg"
  
  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(/usr/bin/openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && /bin/mkdir -p "${tmpDir}"
  
  echo "Temporary Folder is '${tmpDir}'"
  
  cd "${tmpDir}" && /usr/bin/curl -# -O -J -L "${downloadInstaller}"
  
  filePath=$(/usr/bin/find "${tmpDir}" -name "*.dmg")
  
  fileName=$(/usr/bin/basename "${filePath}")
  extension="${fileName##*.}"
  id="${fileName%.*}"
  
  echo "Installer downloaded to '${filePath}'"
  
  /usr/bin/hdiutil convert -quiet "${filePath}" -format UDTO -o "${filePath}.cdr" && sleep 2
  
  installerVolume=$(/usr/bin/hdiutil attach -noautoopen -noverify -nobrowse "${filePath}.cdr" | egrep "Volumes" | grep -o "/Volumes/.*")
  
  echo "Running installer at '${installerVolume}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer'"
  
  "${installerVolume}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer" -silent
  
  /usr/sbin/diskutil quiet eject "${installerVolume}" && sleep 2
  
  rm -rf "${tmpDir}"