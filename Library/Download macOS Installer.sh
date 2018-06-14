#!/bin/bash
  
  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR)
  randString=$(/usr/bin/openssl rand -hex 5)
  workDir="${tmpFolder}${randString}"
  /bin/mkdir -p "${workDir}"
  
  if [ -s "/usr/local/bin/installinstallmacos" ]; then
    rm -f "/usr/local/bin/installinstallmacos"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/installinstallmacos" "https://raw.githubusercontent.com/munki/macadmin-scripts/master/installinstallmacos.py"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/installinstallmacos"
  /bin/chmod 775 "/usr/local/bin/installinstallmacos"
  /bin/chmod +x "/usr/local/bin/installinstallmacos"
  
  echo "Download latest macOS Installer"
  /usr/bin/yes 3 | python /usr/local/bin/installinstallmacos --workdir "${workDir}"
  
  macOSSparseImage=$(/usr/bin/find ${workDir}/Install_macOS*.sparseimage)
  if [ ! -s "${macOSSparseImage}" ]; then
    echo "Download failed" && exit 1
  elif [ -s "${macOSSparseImage}" ]; then
    echo "Download successful at '${macOSSparseImage}'"
  fi
  
  echo "Mount '${macOSSparseImage}'"
  
  mountPoint="${workDir}/mountPoint" && /bin/mkdir "${mountPoint}"
  dmg="${macOSSparseImage}"
  tmpMountPointFile=$(mktemp ${workDir}/dmg.XXX) &&
  
  /usr/bin/hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mountPoint}" "${macOSSparseImage}" > "${tmpMountPointFile}" &&
  
  loc=":system-entities:"
  num=$(/usr/libexec/PlistBuddy -c "Print :system-entities:" ${tmpMountPointFile} | /usr/bin/grep -c Dict 2>/dev/null)
  
  for i in $(seq 0 $((num-1))) ; do
    loc=":system-entities:${i}:mount-point"
    locDevEntry=":system-entities:${i}:dev-entry"
    volumeName="$(/usr/libexec/PlistBuddy -c "Print ${loc}" "${tmpMountPointFile}" 2>/dev/null)"
    volumeNameDevEntry="$(/usr/libexec/PlistBuddy -c "Print ${locDevEntry}" "${tmpMountPointFile}" 2>/dev/null)"
    if [ -n "${volumeName}" -a -z "$(echo ${volumeName} | grep 'Does Not Exist')" ]; then
      break
    fi
  done
  
  echo "Prepare a list for BOM file at '${workDir}/macOSInstaller.list'"
  cd "${volumeName}" && /usr/bin/find . > "${workDir}/macOSInstaller.list"
  
  echo "Create a BOM file at '${workDir}/macOSInstaller.bom'"
  /usr/bin/mkbom -s -i "${workDir}/macOSInstaller.list" "${workDir}/macOSInstaller.bom"
  
  echo "Extract volume with ditto based on the BOM file to '${workDir}/extractDownloadFile'"
  mkdir -p "${workDir}/extractDownloadFile"
  /usr/bin/ditto --bom "${workDir}/macOSInstaller.bom" "${volumeName}" "${workDir}/extractDownloadFile"
  
  echo "Search for macOS Installer in '${workDir}/extractDownloadFile'"
  installmacOSApp=$(/usr/bin/find ${workDir}/extractDownloadFile/Applications/Install*.app -d -maxdepth 0)
  installmacOSAppBasename=$(/usr/bin/basename "${installmacOSApp}")
  
  echo "Move macOS Installer to '/Applications/${installmacOSAppBasename}'"
  /bin/mv "${installmacOSApp}" "/Applications/${installmacOSAppBasename}" && /usr/bin/chflags hidden "/Applications/${installmacOSAppBasename}"
  
  if [ ! -z "${volumeName}" ]; then
    echo "Eject volume '${volumeName}'"
    /usr/sbin/diskutil eject "${volumeName}" > /dev/null 2>&1
    until [ ! -d "${volumeName}" ]; do
      echo "Remove Dev-Entry for '${volumeName}'"
      /usr/sbin/diskutil unmount force "${volumeName}" > /dev/null 2>&1
    done
  fi
    
  if [ ! -z "${volumeNameDevEntry}" ]; then
    echo "Eject volume '${volumeNameDevEntry}'"
    /usr/sbin/diskutil eject "${volumeNameDevEntry}" > /dev/null 2>&1
    until [ ! -d "${volumeNameDevEntry}" ]; do
      echo "Remove Dev-Entry for '${volumeNameDevEntry}'"
      /usr/sbin/diskutil unmount force "${volumeNameDevEntry}" > /dev/null 2>&1
    done
  fi
  
  rm -rf "${workDir}"
