#!/bin/bash

# Determine OS version and build version
# as part of the following actions to disable
# the iCloud and Diagnostic pop-up windows

osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
sw_vers=$(sw_vers -productVersion)
sw_build=$(sw_vers -buildVersion)

# Make a symbolic link from /System/Library/CoreServices/Applications/Directory Utility.app 
# to /Applications/Utilities so that Directory Utility.app is easier to access.

if [[ ! -e "/Applications/Utilities/Directory Utility.app" ]]; then
  /bin/ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

if [[ -L "/Applications/Utilities/Directory Utility.app" ]]; then
  /bin/rm "/Applications/Utilities/Directory Utility.app"
  /bin/ln -s "/System/Library/CoreServices/Applications/Directory Utility.app" "/Applications/Utilities/Directory Utility.app"
fi

# Make a symbolic link from /System/Library/CoreServices/Applications/Network Utility.app 
# to /Applications/Utilities so that Network Utility.app is easier to access.

if [[ ! -e "/Applications/Utilities/Network Utility.app" ]]; then
  /bin/ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

if [[ -L "/Applications/Utilities/Network Utility.app" ]]; then
  /bin/rm "/Applications/Utilities/Network Utility.app"
  /bin/ln -s "/System/Library/CoreServices/Applications/Network Utility.app" "/Applications/Utilities/Network Utility.app"
fi

# Make a symbolic link from /System/Library/CoreServices/Screen Sharing.app 
# to /Applications/Utilities so that Screen Sharing.app is easier to access.

if [[ ! -e "/Applications/Utilities/Screen Sharing.app" ]]; then
  /bin/ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
fi

if [[ -L "/Applications/Utilities/Screen Sharing.app" ]]; then
  /bin/rm "/Applications/Utilities/Screen Sharing.app"
  /bin/ln -s "/System/Library/CoreServices/Applications/Screen Sharing.app" "/Applications/Utilities/Screen Sharing.app"
fi

# Make a symbolic link from /var/log/jamf.log to /Users/admin/Desktop/jamf.log

if [[ ! -e "/Users/admin/Desktop/jamf.log" ]]; then
  /bin/ln -s "/var/log/jamf.log" "/Users/admin/Desktop/jamf.log"
fi

# Sets the "Show scroll bars" setting (in System Preferences: General)
# to "Always" in your Mac's default user template and for all existing users.
# Code adapted from DeployStudio's rc130 ds_finalize script, where it's 
# disabling the iCloud and gestures demos

# Checks the system default user template for the presence of 
# the Library/Preferences directory. If the directory is not found, 
# it is created and then the "Show scroll bars" setting (in System 
# Preferences: General) is set to "Always".

for USER_TEMPLATE in "/System/Library/User Template"/*; do
    if [ ! -d "${USER_TEMPLATE}"/Library/Preferences ]; then
      /bin/mkdir -p "${USER_TEMPLATE}"/Library/Preferences
    fi
    if [ ! -d "${USER_TEMPLATE}"/Library/Preferences/ByHost ]; then
      /bin/mkdir -p "${USER_TEMPLATE}"/Library/Preferences/ByHost
    fi
    if [ -d "${USER_TEMPLATE}"/Library/Preferences/ByHost ]; then
      /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/.GlobalPreferences AppleShowScrollBars -string Always
    fi
  done
  
# Checks the existing user folders in /Users for the presence of
# the Library/Preferences directory. If the directory is not found, 
# it is created and then the "Show scroll bars" setting (in System 
# Preferences: General) is set to "Always".

for USER_HOME in /Users/*; do
    USER_UID=$(basename "${USER_HOME}")
    if [ ! "${USER_UID}" = "Shared" ]; then 
      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ ! -d "${USER_HOME}"/Library/Preferences/ByHost ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences/ByHost
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/ByHost
      fi
      if [ -d "${USER_HOME}"/Library/Preferences/ByHost ]; then
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/.GlobalPreferences AppleShowScrollBars -string Always
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/.GlobalPreferences.*
      fi
    fi
  done
  
# Checks first to see if the Mac is running 10.7.0 or higher. 
# If so, the script checks the system default user template
# for the presence of the Library/Preferences directory. Once
# found, the iCloud, Diagnostic and Siri pop-up settings are set 
# to be disabled.

if [[ ${osvers} -ge 7 ]]; then

 for USER_TEMPLATE in "/System/Library/User Template"/*; do
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool true
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
    /usr/bin/defaults write "${USER_TEMPLATE}"/Library/Preferences/com.apple.SetupAssistant DidSeeSiriSetup -bool TRUE 
  done

 # Checks first to see if the Mac is running 10.7.0 or higher.
 # If so, the script checks the existing user folders in /Users
 # for the presence of the Library/Preferences directory.
 #
 # If the directory is not found, it is created and then the
 # iCloud, Diagnostic and Siri pop-up settings are set to be disabled.

 for USER_HOME in /Users/*; do
    USER_UID=$(basename "${USER_HOME}")
    if [ ! "${USER_UID}" = "Shared" ]; then 
      if [ ! -d "${USER_HOME}"/Library/Preferences ]; then
        /bin/mkdir -p "${USER_HOME}"/Library/Preferences
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences
      fi
      if [ -d "${USER_HOME}"/Library/Preferences ]; then
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool true
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "${sw_vers}"
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant LastSeenBuddyBuildVersion "${sw_build}"
        /usr/bin/defaults write "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant DidSeeSiriSetup -bool TRUE
        /usr/sbin/chown "${USER_UID}" "${USER_HOME}"/Library/Preferences/com.apple.SetupAssistant.plist
      fi
    fi
  done
  
fi

# Set whether you want to send diagnostic info back to
# Apple and/or third party app developers.

SUBMIT_DIAGNOSTIC_DATA_TO_APPLE=FALSE
SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS=FALSE

# Set the appropriate number value for AutoSubmitVersion
# and ThirdPartyDataSubmitVersion by the OS version. 
# For 10.10.x, the value will be 4. 
# For 10.11.x, the value will be 5.
# For 10.12.x, the value will be 5.

if [[ ${osvers} -eq 10 ]]; then
  VERSIONNUMBER=4
elif [[ ${osvers} -ge 11 ]]; then
  VERSIONNUMBER=5
fi

# Checks first to see if the Mac is running 10.10.0 or higher. 
# If so, the desired diagnostic submission settings are applied.

if [[ ${osvers} -ge 10 ]]; then

  CRASHREPORTER_SUPPORT="/Library/Application Support/CrashReporter"

  if [ ! -d "${CRASHREPORTER_SUPPORT}" ]; then
    /bin/mkdir "${CRASHREPORTER_SUPPORT}"
    /bin/chmod 775 "${CRASHREPORTER_SUPPORT}"
    /usr/sbin/chown root:admin "${CRASHREPORTER_SUPPORT}"
  fi

  /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APPLE}
  /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory AutoSubmitVersion -int ${VERSIONNUMBER}
  /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmit -boolean ${SUBMIT_DIAGNOSTIC_DATA_TO_APP_DEVELOPERS}
  /usr/bin/defaults write "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory ThirdPartyDataSubmitVersion -int ${VERSIONNUMBER}
  /bin/chmod a+r "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist
  /usr/sbin/chown root:admin "$CRASHREPORTER_SUPPORT"/DiagnosticMessagesHistory.plist

fi

# Disable Time Machine's pop-up message whenever an external drive is plugged in

/usr/bin/defaults write "/Library/Preferences/com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool true

# Set the ability to  view additional system info at the Login window
# The following will be reported when you click on the time display 
# (click on the time again to proceed to the next item):
#
# Computer name
# Version of OS X installed
# IP address
# This will remain visible for 60 seconds.

/usr/bin/defaults write "/Library/Preferences/com.apple.loginwindow" AdminHostInfo HostName

# Turn SSH on

/usr/sbin/systemsetup -setremotelogin on

# Disable automatic Apple Software Updates

/usr/sbin/softwareupdate --schedule off

# Enable Gatekeeper

/usr/sbin/spctl --master-enable
    
# Disable printer sharing on all printer.

/usr/sbin/cupsctl --no-share-printers

# Searches for locally installed printers and deactivates printer sharing for each of them

for file in /etc/cups/ppd/*; do
  path=${file%.ppd}
  name=${path##*/}
  lpadmin -p "${name}" -o printer-is-shared=false
done

# Adds all users to print admin group

/usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin

# Disable Microsofto Office 2016 first run

submit_diagnostic_data_to_microsoft=false

DisableOffice2016FirstRun() {
  
  /usr/bin/defaults write /Library/Preferences/com.microsoft."$app" kSubUIAppCompletedFirstRunSetup1507 -bool true
  /usr/bin/defaults write /Library/Preferences/com.microsoft."$app" SendAllTelemetryEnabled -bool "$submit_diagnostic_data_to_microsoft"
  
  if [[ $app == "Outlook" ]] || [[ $app == "onenote.mac" ]]; then
    /usr/bin/defaults write /Library/Preferences/com.microsoft."$app" FirstRunExperienceCompletedO15 -bool true
  fi
  
}

if [[ -e "/Applications/Microsoft Excel.app" ]]; then
  app=Excel
  DisableOffice2016FirstRun
fi

if [[ -e "/Applications/Microsoft OneNote.app" ]]; then
  app=onenote.mac
  DisableOffice2016FirstRun
fi

if [[ -e "/Applications/Microsoft Outlook.app" ]]; then
  app=Outlook
  DisableOffice2016FirstRun
fi

if [[ -e "/Applications/Microsoft PowerPoint.app" ]]; then
  app=Powerpoint
  DisableOffice2016FirstRun
fi

if [[ -e "/Applications/Microsoft Word.app" ]]; then
  app=Word
  DisableOffice2016FirstRun
fi

# Set the Open and Save options in Office 2016 apps to default to "On My Mac" instead of "Online Locations".
# This setting will apply to all users on this Mac.

/usr/bin/defaults write "/Library/Preferences/com.microsoft.office" DefaultsToLocalOpenSave -bool true

# Enabling automatic download and installation of Microsoft Office 2016 updates

/usr/bin/defaults write "/Library/Preferences/com.microsoft.autoupdate2" HowToCheck AutomaticDownload
/usr/bin/defaults write "/Library/Preferences/com.microsoft.autoupdate2" UpdateCheckFrequency -int 1440
/usr/bin/defaults write "/Library/Preferences/com.microsoft.autoupdate2" StartDaemonOnAppLaunch -bool true

# Define gatekeeper properties for 'Microsoft AU Daemon.app'

dir="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS"
bundle="Microsoft AU Daemon.app"

/bin/chmod -RN "${dir}/${bundle}"
/usr/bin/chflags -R nouchg "${dir}/${bundle}"
/usr/bin/xattr -r -d -s com.apple.quarantine "${dir}/${bundle}"
/usr/sbin/spctl --add "${dir}/${bundle}"

# This script checks to see if the /mach_kernel file is visible or hidden.
# The /mach_kernel file should not be visible when viewed from the Finder, 
# so the script will use /usr/bin/chflags to set the /mach_kernel file to be hidden.
#
# Original script by Tim Sutton.
# Link: http://macops.ca/security-updates-leaving-mach_kernel-visible/
#
# For information on how to hide the /mach_kernel
# file, please see this Apple KBase article:
#
# https://support.apple.com/HT203829

if [ -e /mach_kernel ]; then
  if ! /bin/ls -lO /mach_kernel | grep hidden > /dev/null; then
    echo "/mach_kernel not set to be hidden. Re-hiding."
    /usr/bin/chflags hidden /mach_kernel
  fi
fi
  
# Set keyboard layout
# Set computer language
# Set the region

KEYBOARDNAME="Swiss German"
KEYBOARDCODE="19"
LANG="de"
REGION="de_CH"
PLBUDDY="/usr/libexec/PlistBuddy"

update_system_language() {
  /usr/sbin/languagesetup -langspec German
}

update_kdb_layout() {
  ${PLBUDDY} -c "Delete :AppleCurrentKeyboardLayoutInputSourceID" "${1}" &>/dev/null
  if [ ${?} -eq 0 ]; then
    ${PLBUDDY} -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.${KEYBOARDNAME}" "${1}"
  fi

  for SOURCE in AppleDefaultAsciiInputSource AppleCurrentAsciiInputSource AppleCurrentInputSource AppleEnabledInputSources AppleSelectedInputSources; do
    ${PLBUDDY} -c "Delete :${SOURCE}" "${1}" &>/dev/null
    if [ ${?} -eq 0 ]; then
      ${PLBUDDY} -c "Add :${SOURCE} array" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0 dict" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:InputSourceKind string 'Keyboard Layout'" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ ID integer ${KEYBOARDCODE}" "${1}"
      ${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ Name string '${KEYBOARDNAME}'" "${1}"
    fi
  done
}

update_language() {
  ${PLBUDDY} -c "Delete :AppleLanguages" "${1}" &>/dev/null
  if [ ${?} -eq 0 ]; then
    ${PLBUDDY} -c "Add :AppleLanguages array" "${1}"
    ${PLBUDDY} -c "Add :AppleLanguages:0 string '${LANG}'" "${1}"
  fi
}

update_region() {
  ${PLBUDDY} -c "Delete :AppleLocale" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :AppleLocale string ${REGION}" "${1}" &>/dev/null
  ${PLBUDDY} -c "Delete :Country" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :Country string ${REGION:3:2}" "${1}" &>/dev/null
}

update_system_language

update_kdb_layout "/Library/Preferences/com.apple.HIToolbox.plist" "${KEYBOARDNAME}" "${KEYBOARDCODE}"

for HOME in /Users/*; do
    if [ -d "${HOME}"/Library/Preferences ]; then
      cd "${HOME}"/Library/Preferences
      HITOOLBOX_FILES=`find . -name "com.apple.HIToolbox.*plist"`
      for HITOOLBOX_FILE in ${HITOOLBOX_FILES}; do
        update_kdb_layout "${HITOOLBOX_FILE}" "${KEYBOARDNAME}" "${KEYBOARDCODE}"
      done
    fi
done

update_language "/Library/Preferences/.GlobalPreferences.plist" "${LANG}"

for HOME in /Users/*; do
    if [ -d "${HOME}"/Library/Preferences ]; then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}; do
        update_language "${GLOBALPREFERENCES_FILE}" "${LANG}"
      done
    fi
done

update_region "/Library/Preferences/.GlobalPreferences.plist" "${REGION}"

for HOME in /Users/*; do
    if [ -d "${HOME}"/Library/Preferences ]; then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}; do
        update_region "${GLOBALPREFERENCES_FILE}" "${REGION}"
      done
    fi
done

# Enable location services

rm -f "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd"*

if [ "${osvers}" -gt 11 ]; then

  /usr/libexec/PlistBuddy -c "Add :LocationServicesEnabled integer 1" "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.plist"
  /usr/libexec/PlistBuddy -c "Add :LocationServicesEnabled integer 1" "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.notbackedup.plist"

elif [ "${osvers}" -lt 12 ] && [ "${osvers}" -gt 9 ]; then

  UUID=$(system_profiler -detailLevel full SPHardwareDataType | grep "Hardware UUID" | cut -f2 -d : | sed 's/^ *//g')

  /usr/libexec/PlistBuddy -c "Add :LocationServicesEnabled integer 1" "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.${UUID}.plist"
  /usr/libexec/PlistBuddy -c "Add :LocationServicesEnabled integer 1" "/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.notbackedup.${UUID}.plist"

fi

/usr/sbin/chown -R _locationd:_locationd "/var/db/locationd/"

/usr/bin/defaults write "/Library/Preferences/com.apple.timezone.auto.plist" Active -bool true

/usr/bin/python << END
from Foundation import NSBundle
TZPP = NSBundle.bundleWithPath_("/System/Library/PreferencePanes/DateAndTime.prefPane/Contents/Resources/TimeZone.prefPane")
TimeZonePref          = TZPP.classNamed_('TimeZonePref')
ATZAdminPrefererences = TZPP.classNamed_('ATZAdminPrefererences')

atzap  = ATZAdminPrefererences.defaultPreferences()
pref   = TimeZonePref.alloc().init()
atzap.addObserver_forKeyPath_options_context_(pref, "enabled", 0, 0)
result = pref._startAutoTimeZoneDaemon_(0x1)
END

# Configure time settings

/usr/sbin/systemsetup -setusingnetworktime on 
/usr/sbin/ntpdate -u "time.euro.apple.com"

# Reset admin user picture

/usr/bin/dscl . delete /Users/admin jpegphoto
/usr/bin/dscl . delete /Users/admin Picture

# Set "Reopen windows when logging back in" option

/usr/bin/defaults write "/Library/Preferences/com.apple.loginwindow" TALLogoutSavesState -bool false

# Deactivate Connect Dialog for Network Connections (macOS 10.12 or higher)

defaults write "/Library/Preferences/com.apple.NetworkAuthorization" AllowUnknownServers -bool YES

# Disable screensaver in login window

/usr/bin/defaults write "/Library/Preferences/com.apple.screensaver" loginWindowIdleTime -integer 0

# Set do_not_upgrade_jamf to false for Jamf Binary

/usr/bin/defaults write "/Library/Preferences/com.jamfsoftware.jamf" do_not_upgrade_jamf -bool false

# Disable automatic spelling in all User Template

for USER_TEMPLATE in "/System/Library/User Template"/*; do
  /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" WebAutomaticSpellingCorrectionEnabled -bool false
done

# Disable Safari setup assistent in all User Template

safariversion=$(/usr/bin/defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString | /usr/bin/awk '{print $1}')
  
for USER_TEMPLATE in "/System/Library/User Template"/*; do
  /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastOSVersionSafariWasLaunchedOn -string "${osvers}"
  /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastSafariVersionWithWelcomePage -string "${safariversion}"
done
  
# Disable inline attachment viewing in Mail in all User Template

for USER_TEMPLATE in "/System/Library/User Template"/*; do
  /usr/bin/defaults write "${USER_TEMPLATE}/Library/Preferences/com.apple.mail" DisableInlineAttachmentViewing -bool yes
done
  
# Delete Adobe Reader PlugIns

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewer.plugin" ]; then
  /bin/rm -rf "/Library/Internet Plug-Ins/AdobePDFViewer.plugin"
fi

if [ -e "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin" ]; then
  /bin/rm -rf "/Library/Internet Plug-Ins/AdobePDFViewerNPAPI.plugin"
fi