#!/bin/bash
# shellcheck disable=SC2126

IFS=$'\n'

currentuser="$(/usr/local/bin/currentuser)"

# Location of the notification center preferences plist for the current user

notifications_plist="/Users/${currentuser}/Library/Preferences/com.apple.ncprefs.plist"

# Get list of all user manipulatable notification center objects

parsed_bundle_identifier=$(defaults read "${notifications_plist}" | grep bundle-id | awk -F \" '{print $4}' | grep -v "_SYSTEM_CENTER_")

# Count of the bundles existing in the plist

applications=$(/usr/libexec/PlistBuddy -c "Print :apps" "${notifications_plist}")
count=$(echo "${applications}" | grep "bundle-id" | wc -l)

# Substracting one to run in a for loop

count=$((count - 1))

change=0

for index in $(seq 0 ${count}); do

  # Getting each bundle id with PlistBuddy

  bundleID=$(/usr/libexec/PlistBuddy -c "Print apps:${index}:bundle-id" "${notifications_plist}")

  # If the name of the current bundle is in our list of bundles to configure

  if [[ "${parsed_bundle_identifier[*]}" == *"${bundleID}"* ]]; then
    flag=$(/usr/libexec/PlistBuddy -c "Print apps:${index}:flags" "${notifications_plist}")
    echo "==> Current flag value for '${bundleID}': ${flag}"
    if [ "${flag}" -lt 4096 ]; then
      echo "Flag is less than 4096. Adding 4096 to disable notifications on lock screen."
      flag=$((flag + 4096))
      change=1
      sudo -u "${currentuser}" /usr/libexec/PlistBuddy -c "Set :apps:${index}:flags ${flag}" "${notifications_plist}"
      flag=$(/usr/libexec/PlistBuddy -c "Print apps:${index}:flags" "${notifications_plist}")
      echo "New flag value for '${bundleID}s': ${flag}"
    fi
  fi

done

if [ $change == 1 ]; then
  echo "Restarting 'usernoted'" && /usr/bin/killall sighup usernoted
  echo "Restarting 'NotificationCenter'" && /usr/bin/killall sighup NotificationCenter
fi
