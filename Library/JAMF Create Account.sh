#!/bin/bash

username="${1}"
realname="${2}"
password="${3}"
home="${4}"
admin="${5}"

jamf="/usr/local/bin/jamf"

if [ -n "$(id -u "${username}" 2>/dev/null)" ]; then

  echo "User ${username} already exists"

else

  echo "User ${username} does not exist"

  if [ -n "${admin}" ]; then

    "${jamf}" createAccount \
      -username "${username}" \
      -realname "${realname}" \
      -password "${password}" \
      -home "/Users/${home}" \
      -suppressSetupAssistant \
      -admin

    dscl . delete /Users/"${username}" jpegphoto
    dscl . delete /Users/"${username}" Picture

  elif [ -z "${admin}" ]; then

    "${jamf}" createAccount \
      -username "${username}" \
      -realname "${realname}" \
      -password "${password}" \
      -home "/Users/${home}" \
      -suppressSetupAssistant

    dscl . delete /Users/"${username}" jpegphoto
    dscl . delete /Users/"${username}" Picture

  fi

fi
