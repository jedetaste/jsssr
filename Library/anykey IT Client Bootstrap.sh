#!/bin/bash
  
  # Determine OS version and build version
  
  echo "==> Determine macOS Version"
  
  macos_vers() {
    IFS='.' read -r major minor revision < <(/usr/bin/sw_vers -productVersion)
  }
  
  macos_vers
  
  if [ ${minor} -gt 11 ]; then
    echo "==> macOS ${major}.${minor}.${revision}"
  else
    echo "==> OS X ${major}.${minor}.${revision}"
  fi
  
  # Symlink useful applications
  
  echo "==> Symlink useful applications"
  
  echo "    Symlink 'Directory Utility.app'"
  if [[ ! -e "/Applications/Utilities/Directory Utility.app" ]]; then
    ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
  fi
  
  if [[ -L "/Applications/Utilities/Directory Utility.app" ]]; then
    rm "/Applications/Utilities/Directory Utility.app"
    ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
  fi
  
  echo "    Symlink 'Network Utility.app'"
  if [[ ! -e "/Applications/Utilities/Network Utility.app" ]]; then
    ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
  fi
  
  if [[ -L "/Applications/Utilities/Network Utility.app" ]]; then
    rm "/Applications/Utilities/Network Utility.app"
    ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
  fi
  
  echo "    Symlink 'Screen Sharing.app'"
  if [[ ! -e "/Applications/Utilities/Screen Sharing.app" ]]; then
    ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
  fi
  
  if [[ -L "/Applications/Utilities/Screen Sharing.app" ]]; then
    rm "/Applications/Utilities/Screen Sharing.app"
    ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
  fi
  
  echo "    Symlink 'jamf.log'"
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
  
  dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
  
  # Enable CUPS web interface
  
  echo "==> Enable CUPS web interface"
  
  cupsctl WebInterface=yes
  
  # Make mach_kernel invisible
  
  echo "==> Make '/mach_kernel' invisible"
  
  if [ -e "/mach_kernel" ]; then
    if ! ls -lO /mach_kernel | grep hidden > /dev/null; then
      echo "/mach_kernel not set to be hidden. Re-hiding."
      chflags hidden "/mach_kernel"
    fi
  fi
  
  # Configure time settings
  
  echo "==> Set time server to 'time.euro.apple.com'"
  
  if [ ${minor} -gt 13 ]; then
    systemsetup -setusingnetworktime on 
    sntp -sS "time.euro.apple.com"
  else
    systemsetup -setusingnetworktime on 
    ntpdate -u "time.euro.apple.com"
  fi
  
  # Enable location services
  
  echo "==> Enable location services"
  
  sudo -u _locationd defaults -currentHost write com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool YES
  
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
  
  echo "==> Disable Safari setup assistent in all User Template"
  
  safariversion=$(defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString | /usr/bin/awk '{print $1}')
  
  for USER_TEMPLATE in "/System/Library/User Template"/*; do
    defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastOSVersionSafariWasLaunchedOn -string "${minor}"
    defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastSafariVersionWithWelcomePage -string "${safariversion}"
  done
  
  # Disable Oracle Java Auto Update
  
  echo "==> Disable Oracle Java Auto Update"
  
  defaults write "/Library/Preferences/com.oracle.java.Java-Updater.plist" JavaAutoUpdateEnabled -bool false
  
  # Disable Auto Update Adobe Flash Player

  echo "==> Disable Auto Update Adobe Flash Player"
  
  mkdir -p "/Library/Application Support/Macromedia/" 2>/dev/null
  echo "AutoUpdateDisable=1" > "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  echo "SilentAutoUpdateEnable=0" >> "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  echo "DisableAnalytics=1" >> "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  
  # Disable Auto Update Adobe Acrobat Reader DC
  
  echo "==> Disable Auto Update Adobe Acrobat Reader DC"
  
  if [ -d "/Applications/Adobe Acrobat Reader DC.app/Contents/Plugins/Updater.acroplugin" ]; then
    rm -rf "/Applications/Adobe Acrobat Reader DC.app/Contents/Plugins/Updater.acroplugin"
  fi
  
  # Delete Adobe Reader Plugins
  
  echo "==> Delete Adobe Reader Plugins"
  
  if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin" ]; then
    rm -rf "/Library/Internet Plug-Ins/AdobePDFViewer.plugin"
  fi
  
  if [ -e "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin" ]; then
    rm -rf "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin"
  fi
  
  # Disable Spotify AutoStart if installed
  
  echo "==> Disable Spotify AutoStart if installed"
  
  if [ -e "/Applications/Spotify.app" ]; then
    for usertemplate in "/System/Library/User Template"/*; do
      if [ ! -s "${usertemplate}/Library/Application Support/Spotify/prefs" ]; then
        mkdir -p "${usertemplate}/Library/Application Support/Spotify/"
        echo "app.autostart-configured=false" >> "${usertemplate}/Library/Application Support/Spotify/prefs"
      else
        rm -f "${usertemplate}/Library/Application Support/Spotify/prefs"
        mkdir -p "${usertemplate}/Library/Application Support/Spotify/"
        echo "app.autostart-configured=false" >> "${usertemplate}/Library/Application Support/Spotify/prefs"
      fi
    done
  fi

  # Correct Permissions Adobe Folder
  
  echo "==> Correct Permissions Adobe Folder"
  
  for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
    if [ -d "/Users/${user}/Library/Application Support/Adobe/" ];  then
      chown -R ${user} "/Users/${user}/Library/Application Support/Adobe/"
      chmod -R 700 "/Users/${user}/Library/Application Support/Adobe/"
    fi
  done
  
  # Remove wrongly saved Remove2011.log
  
  echo "==> Remove wrongly saved Remove2011.log"
  
  if [ -s "/Remove2011.log" ]; then
    rm -f "/Remove2011.log"
  fi
