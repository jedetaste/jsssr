#!/bin/bash

  if [ ! -d "/usr/local/aky" ]; then
    /bin/mkdir -p "/usr/local/aky"
  fi
  
  if [ ! -d "/usr/local/bin" ]; then
    /bin/mkdir -p "/usr/local/bin"
  fi
  
  akyBinary=(
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
  
  for ((i = 0; i < "${#akyBinary[@]}"; i++)); do
    /bin/rm -f "/usr/local/bin/${akyBinary[$i]}"
    /bin/rm -f "/usr/local/aky/${akyBinary[$i]}"
    /usr/bin/curl -so "/usr/local/aky/${akyBinary[$i]}" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/${akyBinary[$i]}"
    /usr/sbin/chown root:wheel "/usr/local/aky/${akyBinary[$i]}"
    /bin/chmod +x "/usr/local/aky/${akyBinary[$i]}"
    /bin/ln -s "/usr/local/aky/${akyBinary[$i]}" "/usr/local/bin/${akyBinary[$i]}"
  done
