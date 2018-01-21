#!/bin/bash
  
  versionInstaller="458.0.1"
  downloadInstaller="https://scratch.mit.edu/scratchr2/static/sa/Scratch-${versionInstaller}.dmg"
  
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
  
  echo "Running installer at '${installerVolume}/Install Scratch 2.app/Contents/MacOS/Install Scratch 2'"
  
  "${installerVolume}/Install Scratch 2.app/Contents/MacOS/Install Scratch 2" -silent
  
  /usr/sbin/diskutil quiet eject "${installerVolume}" && sleep 2
  
  #rm -rf "${tmpFolder}"