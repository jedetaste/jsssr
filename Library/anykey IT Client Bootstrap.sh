#!/bin/bash
  
  # Determine OS version and build version
  
  echo "==> Determine macOS Version"
  OSVers=$(/usr/bin/sw_vers -productVersion)
  OSVersMajor=$(echo ${OSVers} | cut -d. -f1)
  OSVersMinor=$(echo ${OSVers} | cut -d. -f2)
  OSVersRevision=$(echo ${OSVers} | cut -d. -f3)
  
  echo "    macOS version: ${OSVers}"
  echo "    macOS version Major: ${OSVersMajor}"
  echo "    macOS version Minor: ${OSVersMinor}"
  echo "    macOS version Revision: ${OSVersRevision}"
  
  # Symlink useful applications
  
  echo "==> Symlink useful applications"
  echo "    Symlink 'Directory Utility.app'"
  if [[ ! -e "/Applications/Utilities/Directory Utility.app" ]]; then
    /bin/ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
  fi
  
  if [[ -L "/Applications/Utilities/Directory Utility.app" ]]; then
    /bin/rm "/Applications/Utilities/Directory Utility.app"
    /bin/ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
  fi
  
  echo "    Symlink 'Network Utility.app'"
  if [[ ! -e "/Applications/Utilities/Network Utility.app" ]]; then
    /bin/ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
  fi
  
  if [[ -L "/Applications/Utilities/Network Utility.app" ]]; then
    /bin/rm "/Applications/Utilities/Network Utility.app"
    /bin/ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
  fi
  
  echo "    Symlink 'Screen Sharing.app'"
  if [[ ! -e "/Applications/Utilities/Screen Sharing.app" ]]; then
    /bin/ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
  fi
  
  if [[ -L "/Applications/Utilities/Screen Sharing.app" ]]; then
    /bin/rm "/Applications/Utilities/Screen Sharing.app"
    /bin/ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
  fi
  
  echo "    Symlink 'jamf.log'"
  if [[ ! -e "/Users/admin/Desktop/jamf.log" ]]; then
    /bin/ln -s "/var/log/jamf.log" "/Users/admin/Desktop/jamf.log"
  fi
  
  # Enable SSH
  
  echo "==> Enable SSH"
  /usr/sbin/systemsetup -setremotelogin on
  
  # Enable Gatekeeper
  
  echo "==> Enable Gatekeeper"
  /usr/sbin/spctl --master-enable
  
  # Disable printer sharing on all printer.
  
  echo "==> Disable printer sharing on all printer"
  /usr/sbin/cupsctl --no-share-printers
  
  for file in /etc/cups/ppd/*; do
    path="${file%.ppd}"
    name="${path##*/}"
    lpadmin -p "${name}" -o printer-is-shared=false
  done
  
  # Adds all users to print admin group
  
  echo "==> Add all users to 'lpadmin' group"
  /usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin
  
  # Enable CUPS web interface
  
  echo "==> Enable CUPS web interface"
  /usr/sbin/cupsctl WebInterface=yes
  
  # Make mach_kernel invisible
  
  echo "==> Make '/mach_kernel' invisible"
  if [ -e /mach_kernel ]; then
    if ! /bin/ls -lO /mach_kernel | grep hidden > /dev/null; then
      echo "/mach_kernel not set to be hidden. Re-hiding."
      /usr/bin/chflags hidden /mach_kernel
    fi
  fi
  
  # Configure time settings
  
  echo "==> Set time server to 'time.euro.apple.com'"
  /usr/sbin/systemsetup -setusingnetworktime on 
  /usr/sbin/ntpdate -u "time.euro.apple.com"
  
  # Enable location services
  
  echo "==> Enable location services"
  sudo -u _locationd /usr/bin/defaults -currentHost write com.apple.locationd LocationServicesEnabled -int 1
  /usr/bin/defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool YES
  
  # Reset admin user picture
  
  echo "==> Reset admin user picture"
  /usr/bin/dscl . delete /Users/admin jpegphoto
  /usr/bin/dscl . delete /Users/admin Pictures
  
  # Set do_not_upgrade_jamf to false for Jamf Binary
  
  echo "==> Set do_not_upgrade_jamf to false for Jamf Binary"
  /usr/bin/defaults write "/Library/Preferences/com.jamfsoftware.jamf" do_not_upgrade_jamf -bool false
  
  # Disable Safari setup assistent in all User Template
  
  echo "==> Disable Safari setup assistent in all User Template"
  safariversion=$(/usr/bin/defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString | /usr/bin/awk '{print $1}')
  
  for USER_TEMPLATE in "/System/Library/User Template"/*; do
    /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastOSVersionSafariWasLaunchedOn -string "${osvers}"
    /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastSafariVersionWithWelcomePage -string "${safariversion}"
  done
  
  # Disable Oracle Java Auto Update
  
  echo "==> Disable Oracle Java Auto Update"
  /usr/bin/defaults write "/Library/Preferences/com.oracle.java.Java-Updater.plist" JavaAutoUpdateEnabled -bool false
  
  # Disable Auto Update Adobe Flash Player

  echo "==> Disable Auto Update Adobe Flash Player"
  /bin/mkdir -p "/Library/Application Support/Macromedia/" 2>/dev/null
  echo "AutoUpdateDisable=1" > "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  echo "SilentAutoUpdateEnable=0" >> "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  echo "DisableAnalytics=1" >> "/Library/Application Support/Macromedia/mms.cfg" 2>/dev/null
  
  # Delete Adobe Reader Plugins
  
  echo "==> Delete Adobe Reader Plugins"
  if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin" ]; then
    /bin/rm -rf "/Library/Internet Plug-Ins/AdobePDFViewer.plugin"
  fi
  
  if [ -e "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin" ]; then
    /bin/rm -rf "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin"
  fi
