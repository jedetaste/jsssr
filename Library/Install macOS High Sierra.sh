#!/bin/bash

  current_user=$(scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}')
  user_language=$(su -l "${current_user}" -c "/usr/libexec/PlistBuddy -c 'print AppleLanguages:0' ~/Library/Preferences/.GlobalPreferences.plist")

  jamf_helper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
  jamf_helper_pid=$!

  installer="/Applications/Install macOS High Sierra.app"
  installer_name="High Sierra"
  installer_version="10.13"
  installer_aky_recipe="installmacoshighsierra"

  if [ $(sw_vers -productVersion | awk -F. '{print $2}') -lt 11 ]; then
    if [[ ${user_language} = en* ]]; then
      echo "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS '${installer_name}' manually."
      "${jamf_helper}" -windowType "utility" -description "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS '${installer_name}' manually." -alignDescription "left" -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns" -button1 "Ok" -defaultButton "0" -cancelButton "1" && exit 1
    elif [[ ${user_language} = de* ]]; then
      echo "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS '${installer_name}' manually."
      "${jamf_helper}" -windowType "utility" -description "Diese Installation ist auf einem Computer mit OS X 10.10 oder älter nicht möglich. Das Upgrade auf macOS '${installer_name}' muss manuell gemacht werden." -alignDescription "left" -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns" -button1 "Ok" -defaultButton "0" -cancelButton "1" && exit 1
    fi
  fi

  if [ -s "/usr/local/bin/erase-install" ]; then
    /usr/local/bin/erase-install --move --os=${installer_version}
  else
    echo "Binary 'erase-install' not found." && exit 1
  fi

  if [ ! -s "${installer}" ]; then
    /usr/local/bin/aky "${installer_aky_recipe}"
  fi

  finder_running() {
    pgrep -q Finder && return 0 || return 1
  }

  if [ -s "${installer}" ]; then
    if [ ! -z "${current_user}" ] && finder_running; then

      if [[ ${user_language} = en* ]]; then
        "${jamf_helper}" -windowType fs -title "macOS ${installer_name} Upgrade" -alignHeading center -heading "Please wait as we prepare your computer for macOS ${installer_name}" -alignDescription center -description "This process will take approximately 5-10 minutes. Once completed your computer will reboot and begin the upgrade." -icon "${installer}/Contents/Resources/InstallAssistant.icns" &
      elif [[ ${user_language} = de* ]]; then
        "${jamf_helper}" -windowType fs -title "macOS ${installer_name} Upgrade " -alignHeading center -heading "Bitte warten, das Upgrade macOS ${installer_name} wird ausgeführt" -alignDescription center -description "Dieser Prozess benötigt ungefähr 5-10 Minuten. Der Mac startet anschliessend neu und beginnt mit dem Update." -icon "${installer}/Contents/Resources/InstallAssistant.icns" &
      fi

      echo "Download and Install 'First_Boot_Recon.pkg'"
      curl -s -o "/tmp/First_Boot_Recon.pkg" "https://cdn-clients.anykeyit.ch/Static/First_Boot_Recon.pkg"

      "${installer}/Contents/Resources/startosinstall" --applicationpath "${installer}" --agreetolicense --nointeraction --installpackage "/tmp/First_Boot_Recon.pkg" --pidtosignal "${jamf_helper_pid}" &

    else

      echo "Download and Install 'First_Boot_Recon.pkg'"
      curl -s -o "/tmp/First_Boot_Recon.pkg" "https://cdn-clients.anykeyit.ch/Static/First_Boot_Recon.pkg"

      "${installer}/Contents/Resources/startosinstall" --applicationpath "${installer}" --agreetolicense --nointeraction --installpackage "/tmp/First_Boot_Recon.pkg"

      echo "User is not logged in since the '${installer}/Contents/Resources/startosinstall' binary requires a user to be logged in." && exit 1

    fi
  else
    echo "Installer '${installer}' not found." && exit 1
  fi
