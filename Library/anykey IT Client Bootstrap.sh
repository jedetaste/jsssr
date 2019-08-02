#!/bin/bash

# Determine OS version and build version

echo "==> Determine macOS Version"

macos_vers() {
  IFS='.' read -r major minor revision < <(/usr/bin/sw_vers -productVersion)
}

macos_vers

if [ "${minor}" -gt 11 ]; then
  echo "==> Mac is running macOS ${major}.${minor}.${revision} ($(sw_vers -buildVersion))"
else
  echo "==> Mac is running OS X ${major}.${minor}.${revision} ($(sw_vers -buildVersion))"
fi

# Symlink useful applications

echo "==> Symlink useful applications"

echo "Symlink 'Directory Utility.app'"
if [[ ! -e "/Applications/Utilities/Directory Utility.app" ]]; then
  ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

if [[ -L "/Applications/Utilities/Directory Utility.app" ]]; then
  rm "/Applications/Utilities/Directory Utility.app"
  ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

echo "Symlink 'Network Utility.app'"
if [[ ! -e "/Applications/Utilities/Network Utility.app" ]]; then
  ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

if [[ -L "/Applications/Utilities/Network Utility.app" ]]; then
  rm "/Applications/Utilities/Network Utility.app"
  ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

echo "Symlink 'Screen Sharing.app'"
if [[ ! -e "/Applications/Utilities/Screen Sharing.app" ]]; then
  ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
fi

if [[ -L "/Applications/Utilities/Screen Sharing.app" ]]; then
  rm "/Applications/Utilities/Screen Sharing.app"
  ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
fi

echo "Symlink 'jamf.log'"
if [[ ! -e "/Users/admin/Desktop/jamf.log" ]]; then
  ln -s "/var/log/jamf.log" "/Users/admin/Desktop/jamf.log"
fi

# Enable SSH

echo "==> Enable SSH"

systemsetup -setremotelogin on

# Enable Gatekeeper

echo "==> Enable Gatekeeper"

spctl --master-enable

# Disable printer sharing on all printers

echo "==> Disable printer sharing on all printers"

cupsctl --no-share-printers

for file in /etc/cups/ppd/*; do
  path="${file%.ppd}"
  name="${path##*/}"
  lpadmin -p "${name}" -o printer-is-shared=false
done

# Adds all users to print admin group

echo "==> Add all users to 'lpadmin' group"

security authorizationdb write system.preferences.printing allow
security authorizationdb write system.print.operator allow
dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
dseditgroup -o edit -n /Local/Default -a everyone -t group _lpadmin

# Enable CUPS web interface

echo "==> Enable CUPS web interface"

cupsctl WebInterface=yes

# Make mach_kernel invisible

if [ -e "/mach_kernel" ]; then
  if ! ls -lO /mach_kernel | grep hidden >/dev/null; then
    echo "==> /mach_kernel not set to be hidden. Re-hiding."
    chflags hidden "/mach_kernel"
  fi
fi

# Configure time settings

echo "==> Set time server to 'time.euro.apple.com'"

if [ "${minor}" -gt 13 ]; then
  systemsetup -setusingnetworktime on
  sntp -sS "time.euro.apple.com"
else
  systemsetup -setusingnetworktime on
  ntpdate -u "time.euro.apple.com"
fi

# Enable location services

echo "==> Enable location services"

if [ "${minor}" -gt 13 ]; then
  defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool YES
else
  sudo -u _locationd defaults -currentHost write com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool YES
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
  echo "==> Run localisation to '${langSystem}'"
  languagesetup -langspec "${langSystem}"
fi

# Disable iCloud, Data & Privacy, Diagnostic, Touch ID and Siri pop-up settings

echo "==> Disable iCloud, Data & Privacy, Diagnostic, Touch ID and Siri pop-up settings"

if [ "${minor}" -ge 7 ]; then

  for user_template in "/System/Library/User Template"/*; do
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeCloudSetup -bool true
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" GestureMovieSeen none
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenCloudProductVersion "${major}.${minor}.${revision}"
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenBuddyBuildVersion "$(sw_vers -buildVersion)"
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeePrivacy -bool true
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeetrueTonePrivacy -bool true
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTouchIDSetup -bool true
    defaults write "${user_template}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeSiriSetup -bool true
  done

  for user_home in /Users/*; do
    user_id=$(basename "${user_home}")
    if [ ! "${user_id}" = "Shared" ]; then
      if [ -d "${user_home}"/Library/Preferences ]; then
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeCloudSetup -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" GestureMovieSeen none
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenCloudProductVersion "${major}.${minor}.${revision}"
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" LastSeenBuddyBuildVersion "$(sw_vers -buildVersion)"
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeePrivacy -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeetrueTonePrivacy -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeTouchIDSetup -bool true
        defaults write "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist" DidSeeSiriSetup -bool true
        chown "${user_id}" "${user_home}/Library/Preferences/com.apple.SetupAssistant.plist"
      fi
    fi
  done

fi

# Install filter.anykey.ch SSL Root certificate

echo "==> Install filter.anykey.ch SSL Root certificate"

curl -so "/private/tmp/NetAlerts.cer" "https://filter.anykey.ch/certs/NetAlerts.cer"
security add-trusted-cert -d -r trustRoot -p ssl -p basic -k "/Library/Keychains/System.keychain" "/private/tmp/NetAlerts.cer"
rm -f "/private/tmp/NetAlerts.cer"

# Reset admin user picture

echo "==> Reset admin user picture"

dscl . delete /Users/admin jpegphoto
dscl . delete /Users/admin Pictures

# Disable Safari setup assistent in all User Template

echo "==> Disable Safari setup assistent in all user template"

for user_template in "/System/Library/User Template"/*; do
  defaults write "${user_template}/Library/Preferences/com.apple.Safari.plist" LastOSVersionSafariWasLaunchedOn -string "${minor}"
  defaults write "${user_template}/Library/Preferences/com.apple.Safari.plist" LastSafariVersionWithWelcomePage -string "$(defaults read /Applications/Safari.app/Contents/Info.plist CFBundleShortVersionString)"
done

# Hide management account

echo "==> Hide management account"

casper_added=$(defaults read /Library/Preferences/com.apple.loginwindow.plist HiddenUsersList casper 2>/dev/null)
admin_added=$(defaults read /Library/Preferences/com.apple.loginwindow.plist HiddenUsersList admin 2>/dev/null)

if [ -n "${casper_added}" ]; then
  if [ -n "${admin_added}" ]; then
    defaults delete "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList
    defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add casper
    defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add gucken
    defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add admin
  else
    defaults delete "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList
    defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add casper
    defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add gucken
  fi
else
  defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add casper
  defaults write "/Library/Preferences/com.apple.loginwindow.plist" HiddenUsersList -array-add gucken
fi

# Disable Oracle Java Auto Update

echo "==> Disable Oracle Java Auto Update"

defaults write "/Library/Preferences/com.oracle.java.Java-Updater.plist" JavaAutoUpdateEnabled -bool false

# Enable right click on AppleHIDMouse

echo "==> Enable right click on AppleHIDMouse"

for user_template in "/System/Library/User Template"/*; do
  defaults write "${user_template}/Library/Preferences/com.apple.driver.AppleHIDMouse.plist" Button2 -int 2
done

# Enable right click on AppleBluetoothMultitouch

echo "==> Enable right click on AppleBluetoothMultitouch"

for user_template in "/System/Library/User Template"/*; do
  defaults write "${user_template}/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.mouse.plist" MouseButtonMode -string TwoButton
done

# Enable tap to click on trackpad

echo "==> Enable tap to click on trackpad"

for user_template in "/System/Library/User Template"/*; do
  defaults write "${user_template}/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist" Clicking -bool true
done

# Disable Auto Update Adobe Flash Player

echo "==> Disable Auto Update Adobe Flash Player"

mkdir -p "/Library/Application Support/Macromedia/" 2>/dev/null
echo "AutoUpdateDisable=1" >"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
echo "SilentAutoUpdateEnable=0" >>"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
echo "DisableAnalytics=1" >>"/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null

# Disable Auto Update Adobe Acrobat Reader DC

if [ -d "/Applications/Adobe Acrobat Reader DC.app/Contents/Plugins/Updater.acroplugin" ]; then
  echo "==> Disable Auto Update Adobe Acrobat Reader DC"
  rm -rf "/Applications/Adobe Acrobat Reader DC.app/Contents/Plugins/Updater.acroplugin"
fi

# Delete Adobe Reader Plugins

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin" ]; then
  echo "==> Delete Adobe Reader Plugin 'AdobePDFViewer.plugin'"
  rm -rf "/Library/Internet Plug-Ins/AdobePDFViewer.plugin"
fi

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin" ]; then
  echo "==> Delete Adobe Reader Plugins 'AdobePDFViewerNPAPI'"
  rm -rf "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin"
fi

# Correct Permissions Adobe Folder

for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
  if [ -d "/Users/${user}/Library/Application Support/Adobe/" ]; then
    echo "==> Correct Permissions on Adobe Folder on '/Users/${user}'"
    chown -R "${user}" "/Users/${user}/Library/Application Support/Adobe/"
    chmod -R 700 "/Users/${user}/Library/Application Support/Adobe/"
  fi
done

# Remove wrongly saved Remove2011.log

if [ -s "/Remove2011.log" ]; then
  echo "==> Remove wrongly saved Remove2011.log"
  rm -f "/Remove2011.log"
fi
