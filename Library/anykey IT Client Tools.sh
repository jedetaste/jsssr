#!/bin/bash

# Determine macOS Version

macos_vers() {
  IFS='.' read -r major minor revision < <(sw_vers -productVersion)
}

macos_vers

if [ "${minor}" -gt 11 ]; then
  echo "=> macOS version is '${major}.${minor}.${revision}'"
else
  echo "=> OS X version is '${major}.${minor}.${revision}'"
fi

# appleLoops

echo "=> Install 'appleLoops'"

version="3.1.4"

curl -s -L -o "/tmp/appleloops-${version}.pkg" "https://github.com/carlashley/appleloops/releases/download/v${version}/appleloops-${version}.pkg"

installer -pkg "/tmp/appleloops-${version}.pkg" -target / >/dev/null 2>&1

rm -rf "/tmp/appleloops-${version}.pkg"

# dockutil

echo "=> Install 'dockutil'"

if [ -s "/usr/local/bin/dockutil" ]; then
  rm -f "/usr/local/bin/dockutil"
fi

curl -so "/usr/local/bin/dockutil" "https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil"

chown root:wheel "/usr/local/bin/dockutil"
chmod 775 "/usr/local/bin/dockutil"
chmod +x "/usr/local/bin/dockutil"

# docklib

echo "=> Install 'docklib'"

version="1.0.5"

curl -s -L -o "/tmp/docklib-${version}.pkg" "https://github.com/homebysix/docklib/releases/download/v${version}/docklib-${version}.pkg"

installer -pkg "/tmp/docklib-${version}.pkg" -target / >/dev/null 2>&1

rm -rf "/tmp/docklib-${version}.pkg"

# currentuser

echo "=> Install 'currentuser'"

if [ -s "/usr/local/bin/currentuser" ]; then
  rm -f "/usr/local/bin/currentuser"
fi

curl -so "/usr/local/bin/currentuser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/currentuser"

chown root:wheel "/usr/local/bin/currentuser"
chmod 775 "/usr/local/bin/currentuser"
chmod +x "/usr/local/bin/currentuser"

# tmpDir

echo "=> Install 'tmpDir'"

if [ -s "/usr/local/bin/tmpDir" ]; then
  rm -f "/usr/local/bin/tmpDir"
fi

curl -so "/usr/local/bin/tmpDir" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/tmpDir"

chown root:wheel "/usr/local/bin/tmpDir"
chmod 775 "/usr/local/bin/tmpDir"
chmod +x "/usr/local/bin/tmpDir"

# csc

echo "=> Install 'csc'"

if [ -s "/usr/local/bin/csc" ]; then
  rm -f "/usr/local/bin/csc"
fi

curl -so "/usr/local/bin/csc" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/csc"

chown root:wheel "/usr/local/bin/csc"
chmod 775 "/usr/local/bin/csc"
chmod +x "/usr/local/bin/csc"

# rg

echo "=> Install 'rg'"

if [ -s "/usr/local/bin/rg" ]; then
  rm -f "/usr/local/bin/rg"
fi

curl -so "/usr/local/bin/rg" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/rg"

chown root:wheel "/usr/local/bin/rg"
chmod 775 "/usr/local/bin/rg"
chmod +x "/usr/local/bin/rg"

# defaultbrowser

echo "=> Install 'defaultbrowser'"

if [ -s "/usr/local/bin/defaultbrowser" ]; then
  rm -f "/usr/local/bin/defaultbrowser"
fi

curl -so "/usr/local/bin/defaultbrowser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/defaultbrowser"

chown root:wheel "/usr/local/bin/defaultbrowser"
chmod 775 "/usr/local/bin/defaultbrowser"
chmod +x "/usr/local/bin/defaultbrowser"

# urlgenerator

echo "=> Install 'urlgenerator'"

if [ -s "/usr/local/bin/urlgenerator" ]; then
  rm -f "/usr/local/bin/urlgenerator"
fi

curl -so "/usr/local/bin/urlgenerator" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/urlgenerator"

chown root:wheel "/usr/local/bin/urlgenerator"
chmod 775 "/usr/local/bin/urlgenerator"
chmod +x "/usr/local/bin/urlgenerator"

# lang-change

echo "=> Install 'lang-change'"

if [ -s "/usr/local/bin/lang-change" ]; then
  rm -f "/usr/local/bin/lang-change"
fi

curl -so "/usr/local/bin/lang-change" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/lang-change"

chown root:wheel "/usr/local/bin/lang-change"
chmod 775 "/usr/local/bin/lang-change"
chmod +x "/usr/local/bin/lang-change"

# mysides

echo "=> Install 'mysides'"

version="1.0.1"

curl -s -L -o "/tmp/mysides-${version}.pkg" "https://github.com/mosen/mysides/releases/download/v${version}/mysides-${version}.pkg"

installer -pkg "/tmp/mysides-${version}.pkg" -target / >/dev/null 2>&1

rm -rf "/tmp/mysides-${version}.pkg"

# desktoppr

echo "=> Install 'desktoppr'"

version="0.2"

curl -s -L -o "/tmp/desktoppr-${version}.pkg" "https://github.com/scriptingosx/desktoppr/releases/download/v${version}/desktoppr-${version}.pkg"

installer -pkg "/tmp/desktoppr-${version}.pkg" -target / >/dev/null 2>&1

rm -rf "/tmp/desktoppr-${version}.pkg"

# pkgfixer

echo "=> Install 'pkgfixer'"

if [ -s "/usr/local/bin/pkgfixer" ]; then
  rm -f "/usr/local/bin/pkgfixer"
fi

curl -so "/usr/local/bin/pkgfixer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/pkgfixer"

chown root:wheel "/usr/local/bin/pkgfixer"
chmod 775 "/usr/local/bin/pkgfixer"
chmod +x "/usr/local/bin/pkgfixer"

# pkgfixer

echo "=> Install 'dmg-extractor'"

if [ -s "/usr/local/bin/dmg-extractor" ]; then
  rm -f "/usr/local/bin/dmg-extractor"
fi

curl -so "/usr/local/bin/dmg-extractor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/dmg-extractor"

chown root:wheel "/usr/local/bin/dmg-extractor"
chmod 775 "/usr/local/bin/dmg-extractor"
chmod +x "/usr/local/bin/dmg-extractor"

# blueutil

echo "=> Install 'blueutil'"

if [ -s "/usr/local/bin/blueutil" ]; then
  rm -f "/usr/local/bin/blueutil"
fi

curl -so "/usr/local/bin/blueutil" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/blueutil"

chown root:wheel "/usr/local/bin/blueutil"
chmod 775 "/usr/local/bin/blueutil"
chmod +x "/usr/local/bin/blueutil"

# Install aky

echo "=> Install 'aky'"

if [ -s "/usr/local/bin/aky" ]; then
  rm -f "/usr/local/bin/aky"
fi

curl -so "/usr/local/bin/aky" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/aky"

chown root:wheel "/usr/local/bin/aky"
chmod 775 "/usr/local/bin/aky"
chmod +x "/usr/local/bin/aky"

# jq

echo "=> Install 'jq'"

if [ -s "/usr/local/bin/jq" ]; then
  rm -f "/usr/local/bin/jq"
fi

release="1.6"

curl -s -L -o "/usr/local/bin/jq" "https://github.com/stedolan/jq/releases/download/jq-${release}/jq-osx-amd64"

chmod +x "/usr/local/bin/jq"

# aria2c

if [ -d "/usr/local/aria2" ]; then

  echo "=> Remove 'aria2'"

  rm -rf "/usr/local/aria2"
  rm -f "/etc/manpaths.d/aria2"
  rm -f "/etc/paths.d/aria2c"

fi

# tmpDir

echo "=> Install 'tmpDir'"

if [ -s "/usr/local/bin/tmpDir" ]; then
  rm -f "/usr/local/bin/tmpDir"
fi

curl -so "/usr/local/bin/tmpDir" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/tmpDir"

chown root:wheel "/usr/local/bin/tmpDir"
chmod 775 "/usr/local/bin/tmpDir"
chmod +x "/usr/local/bin/tmpDir"

# Remove2011

echo "=> Install 'Remove2011'"

if [ -s "/usr/local/bin/Remove2011" ]; then
  rm -f "/usr/local/bin/Remove2011"
fi

curl -so "/usr/local/bin/Remove2011" "https://raw.githubusercontent.com/pbowden-msft/Remove2011/master/Remove2011"

chown root:wheel "/usr/local/bin/Remove2011"
chmod 775 "/usr/local/bin/Remove2011"
chmod +x "/usr/local/bin/Remove2011"

# AppStoreXtractor

echo "=> Install 'AppStoreXtractor'"

if [ -s "/usr/local/bin/AppStoreXtractor" ]; then
  rm -f "/usr/local/bin/AppStoreXtractor"
fi

curl -so "/usr/local/bin/AppStoreXtractor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/AppStoreXtractor"

chown root:wheel "/usr/local/bin/AppStoreXtractor"
chmod 775 "/usr/local/bin/AppStoreXtractor"
chmod +x "/usr/local/bin/AppStoreXtractor"

# outset

echo "=> Install 'outset'"

version="2.0.6"

curl -s -L -o "/tmp/outset-${version}.pkg" "https://github.com/chilcote/outset/releases/download/v${version}/outset-${version}.pkg"

installer -pkg "/tmp/outset-${version}.pkg" -target / >/dev/null 2>&1

rm -rf "/tmp/outset-${version}.pkg"

# offset

if [ -d "/usr/local/offset" ]; then

  echo "=> Remove 'offset'"

  rm -rf "/usr/local/offset"

  rm -f "/Library/LaunchAgents/com.github.offset.logout.plist"

fi

# SafariBookmarkEditor

echo "=> Install 'SafariBookmarkEditor'"

if [ -s "/usr/local/bin/SafariBookmarkEditor" ]; then
  rm -f "/usr/local/bin/SafariBookmarkEditor"
fi

curl -so "/usr/local/bin/SafariBookmarkEditor" "https://raw.githubusercontent.com/robperc/SafariBookmarkEditor/master/SafariBookmarkEditor.py"

chown root:wheel "/usr/local/bin/SafariBookmarkEditor"
chmod 775 "/usr/local/bin/SafariBookmarkEditor"
chmod +x "/usr/local/bin/SafariBookmarkEditor"

# FinderSidebarEditor

echo "=> Install 'FinderSidebarEditor'"

if [ -s "/usr/local/bin/FinderSidebarEditor" ]; then
  rm -f "/usr/local/bin/FinderSidebarEditor"
fi

curl -so "/usr/local/bin/FinderSidebarEditor" "https://raw.githubusercontent.com/robperc/FinderSidebarEditor/master/FinderSidebarEditor.py"

chown root:wheel "/usr/local/bin/FinderSidebarEditor"
chmod 775 "/usr/local/bin/FinderSidebarEditor"
chmod +x "/usr/local/bin/FinderSidebarEditor"

# duti

echo "=> Install 'duti'"

if [ -s "/usr/local/bin/duti" ]; then
  rm -f "/usr/local/bin/duti"
fi

curl -so "/usr/local/bin/duti" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/duti"

chown root:wheel "/usr/local/bin/duti"
chmod 775 "/usr/local/bin/duti"
chmod +x "/usr/local/bin/duti"

# ncdu

echo "=> Install 'ncdu'"

if [ -s "/usr/local/bin/ncdu" ]; then
  rm -f "/usr/local/bin/ncdu"
fi

curl -so "/usr/local/bin/ncdu" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/ncdu"

chown root:wheel "/usr/local/bin/ncdu"
chmod 775 "/usr/local/bin/ncdu"
chmod +x "/usr/local/bin/ncdu"

# mas

if [ "${minor}" -ge 13 ]; then

  echo "=> Install 'mas'"

  version="1.6.3"

  curl -s -L -o "/tmp/mas-${version}.pkg" "https://github.com/mas-cli/mas/releases/download/v${version}/mas.pkg"

  installer -pkg "/tmp/mas.pkg" -target / >/dev/null 2>&1

  rm -rf "/tmp/mas.pkg"

fi

# xmlstarlet

echo "=> Install 'xmlstarlet'"

if [ -s "/usr/local/bin/xmlstarlet" ]; then
  rm -f "/usr/local/bin/xmlstarlet"
fi

curl -so "/usr/local/bin/xmlstarlet" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/xmlstarlet"

chown root:wheel "/usr/local/bin/xmlstarlet"
chmod 775 "/usr/local/bin/xmlstarlet"
chmod +x "/usr/local/bin/xmlstarlet"

# reattach-to-user-namespace

if [ -s "/usr/local/bin/reattach-to-user-namespace" ]; then
  echo "=> Remove 'reattach-to-user-namespace'"
  rm -f "/usr/local/bin/reattach-to-user-namespace"
fi

# RegMAU

if [ -s "/usr/local/bin/RegMAU" ]; then
  echo "=> Remove 'RegMAU'"
  rm -f "/usr/local/bin/RegMAU"
fi

# MSUpdateHelper

if [ -s "/usr/local/bin/MSUpdateHelper" ]; then
  echo "=> Remove 'MSUpdateHelper'"
  rm -f "/usr/local/bin/MSUpdateHelper"
fi

if [ -s "/usr/local/bin/MSUpdateHelper2019" ]; then
  echo "=> Remove 'MSUpdateHelper2019'"
  rm -f "/usr/local/bin/MSUpdateHelper2019"
fi

# alerter

echo "=> Install 'alerter'"

if [ -s "/usr/local/bin/alerter" ]; then
  rm -f "/usr/local/bin/alerter"
fi

curl -so "/usr/local/bin/alerter" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/alerter"

chown root:wheel "/usr/local/bin/alerter"
chmod 775 "/usr/local/bin/alerter"
chmod +x "/usr/local/bin/alerter"

# PrinterMapper

if [ -s "/usr/local/bin/PrinterMapper" ]; then
  echo "=> Remove 'PrinterMapper'"
  rm -f "/usr/local/bin/PrinterMapper"
fi

# lohelper

echo "=> Install 'lohelper'"

if [ -s "/usr/local/bin/lohelper" ]; then
  rm -f "/usr/local/bin/lohelper"
fi

curl -so "/usr/local/bin/lohelper" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/lohelper"

chown root:wheel "/usr/local/bin/lohelper"
chmod 775 "/usr/local/bin/lohelper"
chmod +x "/usr/local/bin/lohelper"

# jamf-enroll-manual

echo "=> Install 'jamf-enroll-manual'"

if [ -s "/usr/local/bin/jamf-enroll-manual" ]; then
  rm -f "/usr/local/bin/jamf-enroll-manual"
fi

curl -so "/usr/local/bin/jamf-enroll-manual" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/jamf-enroll-manual"

chown root:wheel "/usr/local/bin/jamf-enroll-manual"
chmod 775 "/usr/local/bin/jamf-enroll-manual"
chmod +x "/usr/local/bin/jamf-enroll-manual"

# randomizer

echo "=> Install 'randomizer'"

if [ -s "/usr/local/bin/randomizer" ]; then
  rm -f "/usr/local/bin/randomizer"
fi

curl -so "/usr/local/bin/randomizer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/randomizer"

chown root:wheel "/usr/local/bin/randomizer"
chmod 775 "/usr/local/bin/randomizer"
chmod +x "/usr/local/bin/randomizer"

# assimilateownership

echo "=> Install 'assimilateownership'"

if [ -s "/usr/local/bin/assimilateownership" ]; then
  rm -f "/usr/local/bin/assimilateownership"
fi

curl -so "/usr/local/bin/assimilateownership" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/assimilateownership"

chown root:wheel "/usr/local/bin/assimilateownership"
chmod 775 "/usr/local/bin/assimilateownership"
chmod +x "/usr/local/bin/assimilateownership"

# osversion

echo "=> Install 'osversion'"

if [ -s "/usr/local/bin/osversion" ]; then
  rm -f "/usr/local/bin/osversion"
fi

curl -so "/usr/local/bin/osversion" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/osversion"

chown root:wheel "/usr/local/bin/osversion"
chmod 775 "/usr/local/bin/osversion"
chmod +x "/usr/local/bin/osversion"

# macosvpn

echo "=> Install 'macosvpn'"

if [ -s "/usr/local/bin/macosvpn" ]; then
  rm -f "/usr/local/bin/macosvpn"
elif [ -L "/usr/local/bin/macosvpn" ]; then
  unlink "/usr/local/bin/macosvpn"
fi

version="1.0.2"

curl -s -L -o "/usr/local/bin/macosvpn" "https://github.com/halo/macosvpn/releases/download/${version}/macosvpn"

chown root:wheel "/usr/local/bin/macosvpn"
chmod 775 "/usr/local/bin/macosvpn"
chmod +x "/usr/local/bin/macosvpn"


# erase-install

echo "=> Install 'erase-install'"

if [ -s "/usr/local/bin/erase-install" ]; then
  rm -f "/usr/local/bin/erase-install"
elif [ -L "/usr/local/bin/erase-install" ]; then
  unlink "/usr/local/bin/erase-install"
fi

version="0.12.1"

curl -s -L -o "/tmp/erase-install-${version}.zip" "https://github.com/grahampugh/erase-install/releases/download/v${version}/erase-install-${version}.zip"

ditto -x -k "/tmp/erase-install-${version}.zip" "/tmp/"
mv "/tmp/erase-install-${version}/erase-install.sh" "/usr/local/bin/erase-install" && chmod +x "/usr/local/bin/erase-install"

rm -rf "/tmp/erase-install-${version}"
rm -f "/tmp/erase-install-${version}.zip"

# fileicon

echo "=> Install 'fileicon'"

if [ -s "/usr/local/bin/fileicon" ]; then
  rm -f "/usr/local/bin/fileicon"
fi

curl -so "/usr/local/bin/fileicon" "https://raw.githubusercontent.com/mklement0/fileicon/stable/bin/fileicon"

chown root:wheel "/usr/local/bin/fileicon"
chmod 775 "/usr/local/bin/fileicon"
chmod +x "/usr/local/bin/fileicon"

# sketchup_serializer

echo "=> Install 'sketchup_serializer'"

if [ -s "/usr/local/bin/sketchup_serializer" ]; then
  rm -f "/usr/local/bin/sketchup_serializer"
fi

curl -so "/usr/local/bin/sketchup_serializer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/sketchup_serializer"

chown root:wheel "/usr/local/bin/sketchup_serializer"
chmod 775 "/usr/local/bin/sketchup_serializer"
chmod +x "/usr/local/bin/sketchup_serializer"

# jpscheck

[ -s "/Library/LaunchDaemons/com.jamfsoftware.task.jpscheck.plist" ] && echo "=> Remove 'jpscheck'" && rm -f "/Library/LaunchDaemons/com.jamfsoftware.task.jpscheck.plist"
[ -s "/usr/local/bin/jpscheck" ] && echo "=> Remove 'jpscheck'" && rm -f "/usr/local/bin/jpscheck"

# urlgenerator

echo "=> Install 'kcpassword'"

if [ -s "/usr/local/bin/kcpassword" ]; then
  rm -f "/usr/local/bin/kcpassword"
fi

curl -so "/usr/local/bin/kcpassword" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/kcpassword"

chown root:wheel "/usr/local/bin/kcpassword"
chmod 775 "/usr/local/bin/kcpassword"
chmod +x "/usr/local/bin/kcpassword"
