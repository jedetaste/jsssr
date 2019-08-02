#!/bin/bash

# Remove existing aky binaries

if [ -d "/usr/local/aky/" ]; then
  rm -rf "/usr/local/aky/"
fi

aky_binary=(
  "aky"
  "aria2c@el_capitan"
  "aria2c@high_sierra"
  "aria2c@mojave"
  "aria2c@sierra"
  "download-helper"
  "install-helper"
  "jq"
  "mas-helper"
  "notification-helper"
  "rg"
  "versioning-helper"
)

for ((i = 0; i < "${#aky_binary[@]}"; i++)); do

  [ -L "/usr/local/bin/${aky_binary[$i]}" ] && unlink "/usr/local/bin/${aky_binary[$i]}"

  if [ -s "/usr/local/bin/${aky_binary[$i]}" ]; then
    rm -f "/usr/local/bin/${aky_binary[$i]}"
  fi

done

# Install aky binaries

if [ ! -d "/usr/local/bin" ]; then
  mkdir -p "/usr/local/bin"
fi

aky_binary=(
  "aky"
  "rg"
  "csc"
  "jq"
  "aria2c"
  "tmpDir"
)

for ((i = 0; i < "${#aky_binary[@]}"; i++)); do
  rm -f "/usr/local/bin/${aky_binary[$i]}"
  curl -so "/usr/local/bin/${aky_binary[$i]}" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/aky-src/${aky_binary[$i]}"
  chown root:wheel "/usr/local/bin/${aky_binary[$i]}"
  chmod +x "/usr/local/bin/${aky_binary[$i]}"
done
