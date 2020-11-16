#!/bin/bash
# shellcheck disable=SC2071,SC2034

# Determine OS version and build version

echo "=> Determine macOS Version"
echo "=> Mac is running Darwin $(sw_vers -buildVersion)"

# Symlink useful applications

echo "=> Symlink useful applications"

symlink_applications=(
  "/Applications/Utilities/Directory Utility.app"
  "/Applications/Utilities/Network Utility.app"
  "/Applications/Utilities/Screen Sharing.app"
  "/System/Library/CoreServices/Applications/Directory Utility.app"
  "/System/Library/CoreServices/Applications/Network Utility.app"
  "/System/Library/CoreServices/Applications/Screen Sharing.app"
)

for application in "${symlink_applications[@]}"; do
  if [ -d "${application}" ]; then

    if [ -L "/Applications/Utilities/$(basename "${application}")" ]; then
      echo "Unlink '/Applications/Utilities/$(basename "${application}")'"
      unlink "/Applications/Utilities/$(basename "${application}")"
    fi

    if [ ! -e "/Applications/Utilities/$(basename "${application}")" ]; then
      echo "Link '${application}' to '/Applications/Utilities/'"
      ln -s "${application}" "/Applications/Utilities/"
    fi
  fi
done

symlink_applications=(
  "/System/Library/CoreServices/Applications/DVD Player.app"
)

for application in "${symlink_applications[@]}"; do
  if [ -d "${application}" ]; then

    if [ -L "/Applications/Utilities/$(basename "${application}")" ]; then
      echo "Unlink '/Applications/Utilities/$(basename "${application}")'"
      unlink "/Applications/Utilities/$(basename "${application}")"
    fi

    if [ ! -e "/Applications/$(basename "${application}")" ]; then
      echo "Link '${application}' to '/Applications/'"
      ln -s "${application}" "/Applications/"
    fi
  fi
done

echo "Symlink 'jamf.log'"

if [[ ! -e "/Users/admin/Desktop/jamf.log" ]]; then
  ln -s "/var/log/jamf.log" "/Users/admin/Desktop/jamf.log"
fi

# Enable SSH

echo "=> Enable SSH"

systemsetup -setremotelogin on

# Enable Gatekeeper

echo "=> Enable Gatekeeper"

spctl --master-enable

# Disable printer sharing on all printers

echo "=> Disable printer sharing on all printers"

cupsctl --no-share-printers

for file in /etc/cups/ppd/*; do
  path="${file%.ppd}"
  name="${path##*/}"
  lpadmin -p "${name}" -o printer-is-shared=false
done

# Adds all users to print admin group

echo "=> Add all users to 'lpadmin' group"

security authorizationdb write system.preferences.printing allow
security authorizationdb write system.print.operator allow
dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
dseditgroup -o edit -n /Local/Default -a everyone -t group _lpadmin

# Enable CUPS web interface

echo "=> Enable CUPS web interface"

cupsctl WebInterface=yes

# Enable location services

echo "=> Enable location services"

if [[ "$(sw_vers -buildVersion)" > "16" ]]; then
  defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool true
  launchctl kickstart -k system/com.apple.locationd
else
  sudo -u _locationd defaults -currentHost write com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool true
fi

# Localisation

if [ "${1}" == "Swiss German" ] || [ -z "${1}" ]; then
  langSystem="German"
  localisation="true"
elif [ "${1}" == "Swiss French" ]; then
  langSystem="French"
  localisation="true"
elif [ "${1}" == "English" ]; then
  langSystem="English"
  localisation="true"
elif [ "${1}" == "British" ]; then
  langSystem="English"
  localisation="true"
elif [ "${1}" == "No Localisation" ]; then
  localisation="false"
fi

if [ "${localisation}" == "true" ]; then
  echo "=> Run localisation to '${langSystem}'"
  languagesetup -langspec "${langSystem}"
fi

# Disable iCloud, Data & Privacy, Diagnostic, Touch ID and Siri pop-up settings

if [[ "$(sw_vers -buildVersion)" > "10" ]]; then

  echo "=> Disable iCloud, Data & Privacy, Diagnostic, Touch ID and Siri pop-up settings"

  IFS='.' read -r major minor revision < <(sw_vers -productVersion)

  for user_template in "/System/Library/User Template"/*; do
    if [ -d "${user_template}" ]; then
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeCloudSetup -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" GestureMovieSeen none
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenCloudProductVersion "${major}.${minor}"
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenBuddyBuildVersion "$(sw_vers -buildVersion)"
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeePrivacy -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTrueTonePrivacy -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTouchIDSetup -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeSiriSetup -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeActivationLock -bool true
      defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeScreenTime -bool true
    fi
  done

  for user_home in /Users/*; do
    user_id=$(basename "${user_home}")
    if [ ! "${user_id}" = "Shared" ]; then
      if [ -d "${user_home}"/Library/Preferences ]; then
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeCloudSetup -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" GestureMovieSeen none
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenCloudProductVersion "${major}.${minor}"
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenBuddyBuildVersion "$(sw_vers -buildVersion)"
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeePrivacy -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTrueTonePrivacy -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTouchIDSetup -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeSiriSetup -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeActivationLock -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeScreenTime -bool true
        chown "${user_id}" "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist"
      fi
    fi
  done

fi

# Install filter.anykey.ch SSL Root certificate

echo "=> Install filter.anykey.ch SSL Root certificate"

curl -so "/private/tmp/NetAlerts.cer" "https://filter.anykey.ch/certs/NetAlerts.cer"
security add-trusted-cert -d -r trustRoot -p ssl -p basic -k "/Library/Keychains/System.keychain" "/private/tmp/NetAlerts.cer"
rm -f "/private/tmp/NetAlerts.cer"

# Reset admin user picture

echo "=> Reset admin user picture"

dscl . delete /Users/admin jpegphoto
dscl . delete /Users/admin Pictures

# Disable Safari setup assistent in all User Template

echo "=> Disable Safari setup assistent in all user template"

for user_template in "/System/Library/User Template"/*; do
  if [ -d "${user_template}" ]; then
    defaults write "${user_template}/Library/Preferences/com.apple.Safari.plist" LastOSVersionSafariWasLaunchedOn -string "${minor}"
    defaults write "${user_template}/Library/Preferences/com.apple.Safari.plist" LastSafariVersionWithWelcomePage -string "$(defaults read /Applications/Safari.app/Contents/Info.plist CFBundleShortVersionString)"
  fi
done

# Microsoft Office Bootstrap

defaults write "/Library/Preferences/com.microsoft.autoupdate2.plist" AcknowledgedDataCollectionPolicy -string RequiredAndOptionalData
defaults write "/Library/Preferences/com.microsoft.autoupdate2.plist" HowToCheck -string AutomaticDownload

defaults write "/Library/Preferences/com.microsoft.office.plist" OfficeAutoSignIn -bool true
defaults write "/Library/Preferences/com.microsoft.office.plist" ShowWhatsNewOnLaunch -bool false
defaults write "/Library/Preferences/com.microsoft.office.plist" kCUIThemePreferencesThemeKeyPath -bool false

# Disable Oracle Java Auto Update

echo "=> Disable Oracle Java Auto Update"

defaults write "/Library/Preferences/com.oracle.java.Java-Updater.plist" JavaAutoUpdateEnabled -bool false

# Enable right click on AppleHIDMouse

echo "=> Enable right click on AppleHIDMouse"

for user_template in "/System/Library/User Template"/*; do
  if [ -d "${user_template}" ]; then
    defaults write "${user_template}/Library/Preferences/com.apple.driver.AppleHIDMouse.plist" Button2 -int 2
  fi
done

# Enable right click on AppleBluetoothMultitouch

echo "=> Enable right click on AppleBluetoothMultitouch"

for user_template in "/System/Library/User Template"/*; do
  if [ -d "${user_template}" ]; then
    defaults write "${user_template}/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse.plist" MouseButtonMode -string TwoButton
  fi
done

# Enable tap to click on trackpad

echo "=> Enable tap to click on trackpad"

for user_template in "/System/Library/User Template"/*; do
  if [ -d "${user_template}" ]; then
    defaults write "${user_template}/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist" Clicking -bool true
  fi
done

# Disable Auto Update Adobe Acrobat Reader

echo "=> Disable Auto Update Adobe Acrobat Reader"

defaults write "/Library/Preferences/com.adobe.Reader.plist" DC -dict-add "FeatureLockdown" "<dict><key>bUpdater</key><false/></dict>"

# Disable Auto Update Adobe Flash Player

echo "=> Disable Auto Update Adobe Flash Player"

mkdir -p "/Library/Application Support/Macromedia/" 2>/dev/null
echo "AutoUpdateDisable=1" >"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
echo "SilentAutoUpdateEnable=0" >>"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
echo "DisableAnalytics=1" >>"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null

# Extend threshold for minimal disk space

echo "=> Extend threshold for minimal disk space"

launchctl stop "com.apple.diskspaced"
defaults write "com.apple.diskspaced" minFreeSpace 20
launchctl start "com.apple.diskspaced"

# Delete Adobe Reader Plugins

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin" ]; then
  echo "=> Delete Adobe Reader Plugin 'AdobePDFViewer.plugin'"
  rm -rf "/Library/Internet Plug-Ins/AdobePDFViewer.plugin"
fi

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin" ]; then
  echo "=> Delete Adobe Reader Plugins 'AdobePDFViewerNPAPI'"
  rm -rf "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin"
fi

# Remove wrongly saved Remove2011.log

if [ -s "/Remove2011.log" ]; then
  echo "=> Remove wrongly saved Remove2011.log"
  rm -f "/Remove2011.log"
fi

# Allow enable TimeMachine for standard users

echo "=> Allow enable TimeMachine for standard users"

security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.timemachine allow
