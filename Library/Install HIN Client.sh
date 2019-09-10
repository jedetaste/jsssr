#!/bin/bash

version="1.5.6-80"
version_purged=${version//./_}

echo "=> Download 'https://download.hin.ch/download/distribution/install/${version}/HINClient_macos_${version_purged}.dmg'"

curl -s -o "/tmp/HINClient_macos_${version_purged}.dmg" \
  "https://download.hin.ch/download/distribution/install/${version}/HINClient_macos_${version_purged}.dmg"

if [ -s "/tmp/HINClient_macos_${version_purged}.dmg" ]; then

  mount_point="/tmp/mount_point"
  mkdir "${mount_point}"

  dmg="/tmp/HINClient_macos_${version_purged}.dmg"

  tmp_mount_point_file=$(mktemp /tmp/dmg.XXX) &&
    hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mount_point}" "${dmg}" >"${tmp_mount_point_file}" &&
    loc=":system-entities:"

  num=$(/usr/libexec/PlistBuddy -c "Print :system-entities:" "${tmp_mount_point_file}" | grep -c Dict)

  for i in $(seq 0 $((num - 1))); do
    loc=":system-entities:${i}:mount-point"
    loc_dev_entry=":system-entities:${i}:dev-entry"
    volume_name=$(/usr/libexec/PlistBuddy -c "Print ${loc}" "${tmp_mount_point_file}" 2>/dev/null)
    volume_name_dev_entry=$(/usr/libexec/PlistBuddy -c "Print ${loc_dev_entry}" "${tmp_mount_point_file}" 2>/dev/null)
    if [ -n "${volume_name}" ] && [ -d "${volume_name}" ]; then
      break
    fi
  done

  echo "=> Run install script at '${volume_name}/Install HIN Client.app/Contents/Resources/install.sh'"
  bash "${volume_name}/Install HIN Client.app/Contents/Resources/install.sh"

  if [ -n "${volume_name}" ]; then
    diskutil eject "${volume_name}" >/dev/null 2>&1
    until [ ! -d "${volume_name}" ]; do
      diskutil unmount force "${volume_name}" >/dev/null 2>&1
    done
  fi

  if [ -n "${volume_name_dev_entry}" ]; then
    diskutil eject "${volume_name_dev_entry}" >/dev/null 2>&1
    until [ ! -d "${volume_name_dev_entry}" ]; do
      diskutil unmount force "${volume_name_dev_entry}" >/dev/null 2>&1
    done
  fi

  if [ -d "${mount_point}" ]; then
    rm -rf "${mount_point}"
  fi

  if [ -s "${tmp_mount_point_file}" ]; then
    rm -rf "${tmp_mount_point_file}"
  fi

  echo "=> Remove installer at '${dmg}'"
  rm -f "${dmg}"

fi