#!/bin/bash

for user_template in "/System/Library/User Template"/*; do

  mkdir -p "${user_template}/Library/Application Support/Firefox/Profiles/any.default"

  touch "${user_template}/Library/Application Support/Firefox/profiles.ini"

  cat >> "${user_template}/Library/Application Support/Firefox/profiles.ini" <<EOF
[Profile0]
Name=default
IsRelative=1
Path=Profiles/any.default
Default=1

[General]
StartWithLastProfile=1
Version=2
EOF

  touch "${user_template}/Library/Application Support/Firefox/Profiles/any.default/prefs.js"

  cat >> "${user_template}/Library/Application Support/Firefox/Profiles/any.default/prefs.js" <<EOF
user_pref("app.update.auto", false);
user_pref("app.update.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
user_pref("browser.startup.homepage", "https://portal.office.com/");
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
EOF

done





