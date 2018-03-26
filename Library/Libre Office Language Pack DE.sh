#!/bin/bash
  
  tmp="/private/tmp/libreoffice" && /bin/mkdir -p "${tmp}"
  
  language="de"
  version="6.0.2"
  url="http://download.documentfoundation.org/libreoffice/stable/${version}/mac/x86_64/LibreOffice_${version}_MacOS_x86-64_langpack_${language}.dmg"
  
  echo "==> Download '${url}'"
  
  /usr/bin/curl \
    --show-error \
    --fail \
    --location \
    --remote-time \
    --output "${tmp}/LibreOffice_${version}_MacOS_x86-64_langpack_${language}.dmg" \
    --silent \
    "${url}" \
    
  if [ -s "${workDir}/${fileName}" ]; then
    echo "==> Download was successful"
  else
    echo "==> Download failed, as no appropriate data was found"
    rm -rf "${tmp}" && exit 1
  fi
  
  echo "==> Prepare DMG '${tmp}/LibreOffice_${version}_MacOS_x86-64_langpack_${language}.dmg'"
  
  mountPoint="${tmp}/mountPoint" && /bin/mkdir "${mountPoint}"
  dmg="${tmp}/LibreOffice_${version}_MacOS_x86-64_langpack_${language}.dmg"
  tmpMountPointFile=$(mktemp /${tmp}/dmg.XXX) &&
  
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
  
  if [ -s "/Applications/LibreOffice.app" ]; then
    echo "==> Install '${volumeName}/LibreOffice Language Pack.app/Contents/tarball.tar.bz2'"
    /usr/bin/tar -C "/Applications/LibreOffice.app/" -xjf "${volumeName}/LibreOffice Language Pack.app/Contents/tarball.tar.bz2"
    /usr/bin/touch "/Applications/LibreOffice.app/Contents/Resources/extensions"
  else
    /usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volumeName}" | awk '{print $1}') -quiet -force
    /bin/rm -rf "${tmp}"
    echo "==> LibreOffice not installed" && exit 0
  fi
  
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
  
  /bin/rm -rf "${tmp}"
