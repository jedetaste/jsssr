#!/bin/bash
  
  username="${1}"
  realname="${2}"
  password="${3}"
  home="${4}"
  admin="${5}"
  
  jamf="/usr/local/jamf/bin/jamf"
  
  if [ ! -z "$(id -u ${username} 2>/dev/null)" ]; then
  
    echo "User ${username} already exists"
  
  else
    
    echo "User ${username} does not exist"
    
    if [ ! -z "${admin}" ]; then
      
      "${jamf}" createAccount \
        -username "${username}" \
        -realname "${realname}" \
        -password "${password}" \
        -home "/Users/${home}" \
        -suppressSetupAssistant \
        -admin
      
      /usr/bin/dscl . delete /Users/${username} jpegphoto
      /usr/bin/dscl . delete /Users/${username} Picture
      
    elif [ -z "${admin}" ]; then
      
      "${jamf}" createAccount \
        -username "${username}" \
        -realname "${realname}" \
        -password "${password}" \
        -home "/Users/${home}" \
        -suppressSetupAssistant
      
      /usr/bin/dscl . delete /Users/${username} jpegphoto
      /usr/bin/dscl . delete /Users/${username} Picture
      
    fi
  
  fi
