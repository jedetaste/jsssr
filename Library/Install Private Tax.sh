#!/bin/bash

version="19"

version_name="2019"

curl -s -o "/tmp/ptmx${version}.dmg" \
  "https://www.zh.ch/content/dam/zhweb/bilder-dokumente/themen/steuern-finanzen/steuern/natuerlichepersonen/release_installer/ptmx${version}.dmg"

if [ -s "/tmp/ptmx${version}.dmg" ]; then

  mount_point="/tmp/mount_point"
  mkdir "${mount_point}"

  dmg="/tmp/ptmx${version}.dmg"

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

  "${volume_name}/Private Tax ${version_name} installieren.app/Contents/MacOS/JavaApplicationStub" -q

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

  rm -f "/tmp/ptmx${version}.dmg"

fi
