#!/bin/bash

  tmpDir=$(/usr/local/bin/tmpDir)

  version="4_7_0_400"
  url="http://ccmdl.adobe.com/AdobeProducts/KCCC/1/osx10/ACCCx${version}.dmg"
  download_output="ACCCx${version}.dmg"

  echo "==> Download '${url}'"

  curl --output "${tmpDir}/${download_output}" --silent "${url}"

  if [ -s "${tmpDir}/${download_output}" ]; then
    echo "==> Download was successful"
  else
    echo "==> Download failed, as no appropriate data was found"
    rm -rf "${tmpDir}" && exit 1
  fi

  echo "==> Prepare DMG '${tmpDir}/${download_output}'"

  mount_point="${tmpDir}/mount_point" && /bin/mkdir "${mount_point}"
  dmg="${tmpDir}/${download_output}"
  tmp_mount_point_file=$(/usr/bin/mktemp /${tmpDir}/dmg.XXX) &&

  hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mount_point}" "${dmg}" > "${tmp_mount_point_file}" &&

  loc=":system-entities:"
  num=$(/usr/libexec/PlistBuddy -c "Print :system-entities:" ${tmp_mount_point_file} | /usr/bin/grep -c Dict)

  for i in $(seq 0 $((num-1))) ; do
    loc=":system-entities:${i}:mount-point"
    loc_dev_entry=":system-entities:${i}:dev-entry"
    volume_name="$(/usr/libexec/PlistBuddy -c "Print ${loc}" "${tmp_mount_point_file}")"
    volume_name_dev_entry="$(/usr/libexec/PlistBuddy -c "Print ${loc_dev_entry}" "${tmp_mount_point_file}")"
    if [ -n "${volume_name}" -a -z "$(echo ${volume_name} | grep 'Does Not Exist')" ]; then
      break
    fi
  done

  echo "==> Running installer at '${volume_name}/Install.app/Contents/MacOS/Install'"
  "${volume_name}/Install.app/Contents/MacOS/Install" --mode=silent

  echo "==> Remove Installer"

  if [ ! -z "${volume_name}" ]; then
    echo "==> Eject volume '${volume_name}'"
    diskutil eject "${volume_name}" > /dev/null 2>&1
    until [ ! -d "${volume_name}" ]; do
      echo "==> Remove Dev-Entry for '${volume_name}'"
      diskutil unmount force "${volume_name}" > /dev/null 2>&1
    done
  fi

  if [ ! -z "${volume_name_dev_entry}" ]; then
    echo "==> Eject volume '${volume_name_dev_entry}'"
    diskutil eject "${volume_name_dev_entry}" > /dev/null 2>&1
    until [ ! -d "${volume_name_dev_entry}" ]; do
      echo "==> Remove Dev-Entry for '${volume_name_dev_entry}'"
      diskutil unmount force "${volume_name_dev_entry}" > /dev/null 2>&1
    done
  fi

  rm -rf "${tmpDir}"
