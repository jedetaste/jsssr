#!/bin/bash

  version="32.0"
  download="https://airdownload.adobe.com/air/mac/download/${version}/AdobeAIR.dmg"
  tmpDir=$(/usr/local/bin/tmpDir)

  install_adobe_air() {

    curl -o "${tmpDir}/AdobeAIR.dmg" -s "${download}"

    mount_point="${tmpDir}/mount_point" && mkdir "${tmpDir}/mount_point"
    dmg="${tmpDir}/AdobeAIR.dmg"
    tmp_mount_point_file=$(mktemp /${tmpDir}/dmg.XXX) &&

    hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mount_point}" "${dmg}" > "${tmp_mount_point_file}" &&

    loc=":system-entities:"
    num=$(/usr/libexec/PlistBuddy -c "Print :system-entities:" ${tmp_mount_point_file} | grep -c Dict 2>/dev/null)

    for i in $(seq 0 $((num-1))) ; do
      loc=":system-entities:${i}:mount-point"
      loc_dev_entry=":system-entities:${i}:dev-entry"
      volume_name="$(/usr/libexec/PlistBuddy -c "Print ${loc}" "${tmp_mount_point_file}" 2>/dev/null)"
      volume_name_dev_entry="$(/usr/libexec/PlistBuddy -c "Print ${loc_dev_entry}" "${tmp_mount_point_file}" 2>/dev/null)"
      if [ -n "${volume_name}" -a -z "$(echo ${volume_name} | grep 'Does Not Exist')" ]; then
        break
      fi
    done

    echo "=> Running installer at '${volume_name}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer'"
    "${volume_name}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer" -silent

    echo "=> Remove Installer"

    if [ ! -z "${volume_name}" ]; then
      echo "=> Eject volume '${volume_name}'"
      diskutil eject "${volume_name}" > /dev/null 2>&1
      until [ ! -d "${volume_name}" ]; do
        echo "=> Remove Dev-Entry for '${volume_name}'"
        diskutil unmount force "${volume_name}" > /dev/null 2>&1
      done
    fi

    if [ ! -z "${volume_name_dev_entry}" ]; then
      echo "=> Eject volume '${volume_name_dev_entry}'"
      diskutil eject "${volume_name_dev_entry}" > /dev/null 2>&1
      until [ ! -d "${volume_name_dev_entry}" ]; do
        echo "=> Remove Dev-Entry for '${volume_name_dev_entry}'"
        diskutil unmount force "${volume_name_dev_entry}" > /dev/null 2>&1
      done
    fi

    rm -rf "${tmpDir}"

  }

  if [ -z $(defaults read "/Applications/Utilities/Adobe AIR Application Installer.app/Contents/Info.plist" CFBundleShortVersionString 2> /dev/null) ]; then
    echo "=> Adobe AIR not installed"
    install_adobe_air
  elif [ ! $(defaults read "/Applications/Utilities/Adobe AIR Application Installer.app/Contents/Info.plist" CFBundleShortVersionString 2> /dev/null) = "${version}" ]; then
    echo "=> Adobe AIR outdated"
    install_adobe_air
  else
    echo "=> Adobe AIR installed and up-to-date (v${version})"
    exit 0
  fi