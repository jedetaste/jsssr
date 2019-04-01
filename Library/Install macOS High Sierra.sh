#!/bin/bash

  if [ -s "/usr/local/bin/erase-install" ]; then
    /usr/local/bin/erase-install --move --version=10.13.6
  fi

  finder_running() {
    pgrep -q Finder && return 0 || return 1
  }

  current_user=$(scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}')
  user_language=$(su -l "${current_user}" -c "/usr/libexec/PlistBuddy -c 'print AppleLanguages:0' ~/Library/Preferences/.GlobalPreferences.plist")

  jamf_helper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
  jamf_helper_pid=$!

  installer="/Applications/Install macOS High Sierra.app"
  installer_name="High Sierra"

  if [ -s "${installer}" ]; then
    if [ ! -z "${current_user}" ] && finder_running; then
      if [ -s "${installer}" ]; then

        if [[ ${user_language} = en* ]]; then
          "${jamf_helper}" -windowType fs -title "macOS ${installer_name} Upgrade" -alignHeading center -heading "Please wait as we prepare your computer for macOS ${installer_name}" -alignDescription center -description "This process will take approximately 5-10 minutes. Once completed your computer will reboot and begin the upgrade." -icon "${installer}/Contents/Resources/InstallAssistant.icns" &
        elif [[ ${user_language} = de* ]]; then
          "${jamf_helper}" -windowType fs -title "macOS ${installer_name} Upgrade " -alignHeading center -heading "Bitte warten, das Upgrade macOS ${installer_name} wird ausgeführt" -alignDescription center -description "Dieser Prozess benötigt ungefähr 5-10 Minuten. Der Mac startet anschliessend neu und beginnt mit dem Update." -icon "${installer}/Contents/Resources/InstallAssistant.icns" &
        fi

        curl -s -o "/tmp/First_Boot_Recon.pkg" "https://cdn-clients.anykeyit.ch/Static/First_Boot_Recon.pkg" && installer -pkg "/tmp/First_Boot_Recon.pkg" -target /

        "${installer}/Contents/Resources/startosinstall" --agreetolicense --nointeraction --pidtosignal "${jamf_helper_pid}" &

      fi
    else
      echo "User is not logged in since the '${installer}/Contents/Resources/startosinstall' binary requires a user to be logged in." && exit 1
    fi
  else
    echo "Installer '${installer}' not found." && exit 1
  fi
