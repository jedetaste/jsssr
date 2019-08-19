#!/bin/bash

# AdobeAIR EULA Acception for existing users

for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
  if [ ! -s "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then
    mkdir -p "/Users/${user}/Library/Application Support/Adobe/AIR/"
    touch "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
    chown -R "${user}" "/Users/${user}/Library/Application Support/Adobe/"
    chmod -R 700 "/Users/${user}/Library/Application Support/Adobe/"
  else
    rm -f "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
    touch "/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"/Users/${user}/Library/Application Support/Adobe/AIR/eulaAccepted"
    chown -R "${user}" "/Users/${user}/Library/Application Support/Adobe/"
    chmod -R 700 "/Users/${user}/Library/Application Support/Adobe/"
  fi
done

# AdobeAIR EULA Acception for user template

for user_template in "/System/Library/User Template"/*; do
  if [ ! -s "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then
    mkdir -p "${user_template}/Library/Application Support/Adobe/AIR/"
    touch "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
  else
    rm -f "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    mkdir -p "${user_template}/Library/Application Support/Adobe/AIR/"
    touch "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
  fi
done
