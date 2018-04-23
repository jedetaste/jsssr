#!/bin/bash

  mkdir -p "/System/Library/User Template/Non_localized/Library/Application Support/Firefox/"
  profiles="/System/Library/User Template/Non_localized/Library/Application Support/Firefox/profiles.ini"
  
  function profileCreator() {
    
    echo "[General]" >> "${profiles}"
    echo "StartWithLastProfile=1" >> "${profiles}"
    echo "[Profile0]" >> "${profiles}"
    echo "Name=default" >> "${profiles}"
    echo "IsRelative=1" >> "${profiles}"
    echo "Path=Profiles/any.default" >> "${profiles}"
    echo "Default=1" >> "${profiles}"
    
  }
  
  if [ -e "${profiles}" ]; then
    rm -rf "${profiles}"
    touch "${profiles}"
    profileCreator
  else
    touch "${profiles}"
    profileCreator
  fi
  
  mkdir -p "/System/Library/User Template/Non_localized/Library/Application Support/Firefox/Profiles/any.default"
  prefs="/System/Library/User Template/Non_localized/Library/Application Support/Firefox/Profiles/any.default/prefs.js"
  
  function prefCreator() {
    
    firefoxVersion=$(defaults read "/Applications/Firefox.app/Contents/Info.plist" CFBundleShortVersionString)
    
    echo 'user_pref("app.update.auto", false);' >> "${prefs}"
    echo 'user_pref("app.update.enabled", false);' >> "${prefs}"
    echo 'user_pref("browser.shell.checkDefaultBrowser", false);' >> "${prefs}"
    echo 'user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);' >> "${prefs}"
    echo 'user_pref("browser.startup.homepage", "https://google.ch");' >> "${prefs}"
    echo 'user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);' >> "${prefs}"
    echo 'user_pref("browser.bookmarks.restore_default_bookmarks", false);' >> "${prefs}"
    echo "user_pref(\"browser.startup.homepage_override.mstone\", \"${firefoxVersion}\");" >> "${prefs}"
    
  }
  
  if [ -e "${prefs}" ]; then
    rm -rf "${prefs}"
    touch "${prefs}"
    prefCreator
  else
    touch "${prefs}"
    prefCreator
  fi
