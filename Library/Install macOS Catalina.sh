#!/bin/bash

IFS='.' read -r os_major os_minor os_revision < <(sw_vers -productVersion)

current_user=$(scutil <<<"show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }')
user_language=$(su -l "${current_user}" -c "/usr/libexec/PlistBuddy -c 'print AppleLanguages:0' ~/Library/Preferences/.GlobalPreferences.plist")

jamf_helper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

installer_name="Catalina"
installer_version="10.15"

if [ "${os_minor}" -lt 12 ]; then
  echo "Error: Please run upgrade manually, as macOS Upgrade from OS X 10.11 or less is not supported"
  exit 1
fi

if [ "$(sw_vers -productVersion | awk -F. '{print $2}')" -lt 11 ]; then
  if [[ ${user_language} == en* ]]; then
    echo "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS ${installer_name} manually."
    "${jamf_helper}" -windowType "utility" -description "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS ${installer_name} manually." -alignDescription "left" -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns" -button1 "Ok" -defaultButton "0" -cancelButton "1" && exit 1
  elif [[ ${user_language} == de* ]]; then
    echo "This Upgrade cannot be installed on a computer with OS X 10.10 or lower. Please install macOS ${installer_name} manually."
    "${jamf_helper}" -windowType "utility" -description "Diese Installation ist auf einem Computer mit OS X 10.10 oder älter nicht möglich. Das Upgrade auf macOS ${installer_name} muss manuell gemacht werden." -alignDescription "left" -icon "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns" -button1 "Ok" -defaultButton "0" -cancelButton "1" && exit 1
  fi
fi

if [ -s "/usr/local/bin/erase-install" ]; then

  echo "Download and Install 'First_Boot_Recon.pkg'"
  curl -s -o "/tmp/First_Boot_Recon.pkg" "https://cdn-clients.anykeyit.ch/Static/First_Boot_Recon.pkg"

  if [ "${os_minor}" -lt 13 ]; then

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --extras=/tmp/First_Boot_Recon.pkg \
      --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

  else

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --extras=/tmp/First_Boot_Recon.pkg

  fi

else
  echo "Binary 'erase-install' not found." && exit 1
fi
