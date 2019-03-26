#!/bin/bash

  tmpFolder=$(getconf DARWIN_USER_TEMP_DIR)
  randString=$(/usr/bin/openssl rand -hex 5)
  workDir="${tmpFolder}${randString}" && /bin/mkdir -p "${workDir}"

  version="2018-09-26_154056"
  url="https://download.hin.ch/video/mac/HIN-Video-Installer_${version}.dmg"

  echo "==> Download '${url}'"

  /usr/bin/curl \
    --show-error \
    --fail \
    --location \
    --remote-time \
    --output "${workDir}/HIN-Video-Installer_${version}.dmg" \
    --silent \
    "${url}" \

  if [ -s "${workDir}/${fileName}" ]; then
    echo "==> Download was successful"
  else
    echo "==> Download failed, as no appropriate data was found"
    rm -rf "${workDir}" && exit 1
  fi

  echo "==> Prepare DMG '${workDir}/HIN-Video-Installer_${version}.dmg'"

  mountPoint="${workDir}/mountPoint" && /bin/mkdir "${mountPoint}"
  dmg="${workDir}/HIN-Video-Installer_${version}.dmg"
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

  echo "==> Run Installer '${volumeName}/Install HIN Video.app/Contents/Resources/install.sh'"

  "${volumeName}/Install HIN Video.app/Contents/Resources/install.sh"

  echo "==> Reset ownership and permissions on bundle '/Applications/HIN Video.app'"
  /bin/chmod -RN "/Applications/HIN Video.app"

  echo "==> Remove flags and locking on bundle '/Applications/HIN Video.app'"
  /usr/bin/chflags -R nouchg "/Applications/HIN Video.app"

  echo "==> Remove bundle '/Applications/HIN Video.app' from gatekeeper quarantine"
  /usr/bin/xattr -r -d -s com.apple.quarantine "/Applications/HIN Video.app"

  echo "==> Whitelist bundle '/Applications/HIN Video.app' for execution in the security assessment policy subsystem"
  /usr/sbin/spctl --add "/Applications/HIN Video.app"

  echo "==> Set ownership on bundle '/Applications/HIN Video.app'"
  /usr/sbin/chown -R root:wheel "/Applications/HIN Video.app"

  echo "==> Set permissions on bundle '/Applications/HIN Video.app'"
  /bin/chmod -R 755 "/Applications/HIN Video.app"

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