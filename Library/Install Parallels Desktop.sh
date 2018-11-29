#!/bin/bash
  
  tmpFolder=$(getconf DARWIN_USER_TEMP_DIR)
  randString=$(/usr/bin/openssl rand -hex 5)
  workDir="${tmpFolder}${randString}" && /bin/mkdir -p "${workDir}"
  
  version="14.1.0"
  build="45387"
  versionMajor=$(echo ${version} | cut -d. -f1)
  versionMinor=$(echo ${version} | cut -d. -f2)
  versionRevision=$(echo ${version} | cut -d. -f3)
  url="https://download.parallels.com/desktop/v${versionMajor}/${version}-${build}/ParallelsDesktop-${version}-${build}.dmg"
  
  echo "==> Download '${url}'"
  
  /usr/bin/curl \
    --show-error \
    --fail \
    --location \
    --remote-time \
    --output "${workDir}/ParallelsDesktop-${version}-${build}.dmg" \
    --silent \
    "${url}" \
  
  if [ -s "${workDir}/${fileName}" ]; then
    echo "==> Download was successful"
  else
    echo "==> Download failed, as no appropriate data was found"
    rm -rf "${workDir}" && exit 1
  fi
  
  echo "==> Prepare DMG '${workDir}/ParallelsDesktop-${version}-${build}.dmg'"
  
  mountPoint="${workDir}/mountPoint" && /bin/mkdir "${mountPoint}"
  dmg="${workDir}/ParallelsDesktop-${version}-${build}.dmg"
  tmpMountPointFile=$(mktemp /${workDir}/dmg.XXX) &&
  
  /usr/bin/hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mountPoint}" "${dmg}" > "${tmpMountPointFile}" &&
  
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
  
  echo "==> Prepare a list for BOM file at '${workDir}/parallels.list'"
  cd "${volumeName}" && /usr/bin/find . > "${workDir}/parallels.list"
  
  echo "==> Create a BOM file at '${workDir}/parallels.bom'"
  /usr/bin/mkbom -s -i "${workDir}/parallels.list" "${workDir}/parallels.bom"
  
  echo "==> Extract volume with ditto, based on the BOM file to '${workDir}/extractDownloadFile'"
  /usr/bin/ditto --bom "${workDir}/parallels.bom" "${volumeName}" "${workDir}/extractDownloadFile"
  
  echo "==> Search for bundle in '${workDir}/extractDownloadFile'"
  extractedBundle=$(/usr/bin/find "${workDir}/extractDownloadFile" -name "Parallels Desktop.app" | sed -n 1p)
  
  if [ ! -s "${extractedBundle}" ]; then
    echo "==> Error: Bundle 'Parallels Desktop.app' could not be found"
  else
    echo "==> Found bundle at '${extractedBundle}'"
  fi
  
  if [ -s "/Applications/Parallels Desktop.app" ]; then
    echo "==> Remove bundle '/Applications/Parallels Desktop.app'"
    rm -rf "/Applications/Parallels Desktop.app" && sleep 2
  fi
  
  echo "==> Move extracted bundle from '${extractedBundle}' to '/Applications/Parallels Desktop.app'"
  /bin/mv "${extractedBundle}" "/Applications/Parallels Desktop.app"
  
  echo "==> Reset ownership and permissions on bundle '/Applications/Parallels Desktop.app'"
  /bin/chmod -RN "/Applications/Parallels Desktop.app"
  
  echo "==> Remove flags and locking on bundle '/Applications/Parallels Desktop.app'"
  /usr/bin/chflags -R nouchg "/Applications/Parallels Desktop.app"
  
  echo "==> Unhide application '/Applications/Parallels Desktop.app'"
  /usr/bin/chflags -R nohidden "/Applications/Parallels Desktop.app"
  
  echo "==> Remove bundle '/Applications/Parallels Desktop.app' from gatekeeper quarantine"
  /usr/bin/xattr -r -d -s com.apple.quarantine "/Applications/Parallels Desktop.app"
  
  echo "==> Whitelist bundle '/Applications/Parallels Desktop.app' for execution in the security assessment policy subsystem"
  /usr/sbin/spctl --add "/Applications/Parallels Desktop.app"
  
  echo "==> Set ownership on bundle '/Applications/Parallels Desktop.app'"
  /usr/sbin/chown -R root:wheel "/Applications/Parallels Desktop.app"
  
  echo "==> Set permissions on bundle '/Applications/Parallels Desktop.app'"
  /bin/chmod -R 755 "/Applications/Parallels Desktop.app"
  
  echo "==> Run the initialization script at '${volumeName}/Parallels Desktop.app/Contents/MacOS/inittool'"
  "${volumeName}/Parallels Desktop.app/Contents/MacOS/inittool" init -b "/Applications/Parallels Desktop.app"
  
  echo "==> Remove Installer"
  
  if [ ! -z "${volumeName}" ]; then
    echo "==> Eject volume '${volumeName}'"
    /usr/sbin/diskutil eject "${volumeName}" > /dev/null 2>&1
    until [ ! -d "${volumeName}" ]; do
      echo "==> Remove Dev-Entry for '${volumeName}'"
      /usr/sbin/diskutil unmount force "${volumeName}" > /dev/null 2>&1
    done
  fi
  
  if [ ! -z "${volumeNameDevEntry}" ]; then
    echo "==> Eject volume '${volumeNameDevEntry}'"
    /usr/sbin/diskutil eject "${volumeNameDevEntry}" > /dev/null 2>&1
    until [ ! -d "${volumeNameDevEntry}" ]; do
      echo "==> Remove Dev-Entry for '${volumeNameDevEntry}'"
      /usr/sbin/diskutil unmount force "${volumeNameDevEntry}" > /dev/null 2>&1
    done
  fi
  
  /bin/rm -rf "${workDir}"