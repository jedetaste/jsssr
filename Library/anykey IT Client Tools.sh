#!/bin/bash

  # Determine macOS Version

  macos_vers() {
    IFS='.' read -r major minor revision < <(sw_vers -productVersion)
  }

  macos_vers

  if [ ${minor} -gt 11 ]; then
    echo "==> macOS version is '${major}.${minor}.${revision}'"
  else
    echo "==> OS X version is '${major}.${minor}.${revision}'"
  fi

  # appleLoops

  echo "==> Install 'appleLoops'"

  if [ -s "/usr/local/bin/appleLoops" ]; then
    rm -f "/usr/local/bin/appleLoops"
  fi

  curl -so "/usr/local/bin/appleLoops" "https://raw.githubusercontent.com/carlashley/appleLoops/master/appleLoops.py"

  chown root:wheel "/usr/local/bin/appleLoops"
  chmod 775 "/usr/local/bin/appleLoops"
  chmod +x "/usr/local/bin/appleLoops"

  # dockutil

  echo "==> Install 'dockutil'"

  if [ -s "/usr/local/bin/dockutil" ]; then
    rm -f "/usr/local/bin/dockutil"
  fi

  curl -so "/usr/local/bin/dockutil" "https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil"

  chown root:wheel "/usr/local/bin/dockutil"
  chmod 775 "/usr/local/bin/dockutil"
  chmod +x "/usr/local/bin/dockutil"

  # currentuser

  echo "==> Install 'currentuser'"

  if [ -s "/usr/local/bin/currentuser" ]; then
    rm -f "/usr/local/bin/currentuser"
  fi

  curl -so "/usr/local/bin/currentuser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/currentuser"

  chown root:wheel "/usr/local/bin/currentuser"
  chmod 775 "/usr/local/bin/currentuser"
  chmod +x "/usr/local/bin/currentuser"

  # tmpDir

  echo "==> Install 'tmpDir'"

  if [ -s "/usr/local/bin/tmpDir" ]; then
    rm -f "/usr/local/bin/tmpDir"
  fi

  curl -so "/usr/local/bin/tmpDir" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/tmpDir"

  chown root:wheel "/usr/local/bin/tmpDir"
  chmod 775 "/usr/local/bin/tmpDir"
  chmod +x "/usr/local/bin/tmpDir"

  # csc

  echo "==> Install 'csc'"

  if [ -s "/usr/local/bin/csc" ]; then
    rm -f "/usr/local/bin/csc"
  fi

  curl -so "/usr/local/bin/csc" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/csc"

  chown root:wheel "/usr/local/bin/csc"
  chmod 775 "/usr/local/bin/csc"
  chmod +x "/usr/local/bin/csc"

  # defaultbrowser

  echo "==> Install 'defaultbrowser'"

  if [ -s "/usr/local/bin/defaultbrowser" ]; then
    rm -f "/usr/local/bin/defaultbrowser"
  fi

  curl -so "/usr/local/bin/defaultbrowser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/defaultbrowser"

  chown root:wheel "/usr/local/bin/defaultbrowser"
  chmod 775 "/usr/local/bin/defaultbrowser"
  chmod +x "/usr/local/bin/defaultbrowser"

  # mysides

  echo "==> Install 'mysides'"

  mysidesVersion="1.0.1"

  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && mkdir -p "${tmpDir}"

  cd "${tmpDir}" && curl -s -O -J -L "https://github.com/mosen/mysides/releases/download/v${mysidesVersion}/mysides-${mysidesVersion}.pkg"

  installer -pkg "${tmpDir}/mysides-${mysidesVersion}.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"

  # desktoppr

  echo "==> Install 'desktoppr'"

  desktopprVersion="0.1"

  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && mkdir -p "${tmpDir}"

  cd "${tmpDir}" && curl -s -O -J -L "https://github.com/scriptingosx/desktoppr/releases/download/v${desktopprVersion}/desktoppr-${desktopprVersion}.pkg"

  installer -pkg "${tmpDir}/desktoppr-${desktopprVersion}.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"

  # pkgfixer

  echo "==> Install 'pkgfixer'"

  if [ -s "/usr/local/bin/pkgfixer" ]; then
    rm -f "/usr/local/bin/pkgfixer"
  fi

  curl -so "/usr/local/bin/pkgfixer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/pkgfixer"

  chown root:wheel "/usr/local/bin/pkgfixer"
  chmod 775 "/usr/local/bin/pkgfixer"
  chmod +x "/usr/local/bin/pkgfixer"

  # blueutil

  echo "==> Install 'blueutil'"

  if [ -s "/usr/local/bin/blueutil" ]; then
    rm -f "/usr/local/bin/blueutil"
  fi

  curl -so "/usr/local/bin/blueutil" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/blueutil"

  chown root:wheel "/usr/local/bin/blueutil"
  chmod 775 "/usr/local/bin/blueutil"
  chmod +x "/usr/local/bin/blueutil"

  # Purge legacy aky

  echo "==> Purge legacy 'aky'"

  if [ -d "/usr/local/aky/" ]; then
    rm -rf "/usr/local/aky/"
  fi

  aky_binary=(
    "aky"
    "aria2c@el_capitan"
    "aria2c@high_sierra"
    "aria2c@mojave"
    "aria2c@sierra"
    "download-helper"
    "install-helper"
    "jq"
    "mas-helper"
    "notification-helper"
    "rg"
    "versioning-helper"
  )

  for ((i = 0; i < "${#aky_binary[@]}"; i++)); do

    [ -L "/usr/local/bin/${aky_binary[$i]}" ] && unlink "/usr/local/bin/${aky_binary[$i]}"

    if [ -s "/usr/local/bin/${aky_binary[$i]}" ]; then
      rm -f "/usr/local/bin/${aky_binary[$i]}"
    fi

  done

  # Install aky

  echo "==> Install 'aky'"

  if [ ! -d "/usr/local/bin" ]; then
    mkdir -p "/usr/local/bin"
  fi

  aky_binary=(
    "aky"
    "rg"
    "csc"
    "jq"
    "aria2c"
    "tmpDir"
  )

  for ((i = 0; i < "${#aky_binary[@]}"; i++)); do
    /bin/rm -f "/usr/local/bin/${aky_binary[$i]}"
    curl -so "/usr/local/bin/${aky_binary[$i]}" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/aky-src/${aky_binary[$i]}"
    chown root:wheel "/usr/local/bin/${aky_binary[$i]}"
    chmod +x "/usr/local/bin/${aky_binary[$i]}"
  done

  # Remove2011

  echo "==> Install 'Remove2011'"

  if [ -s "/usr/local/bin/Remove2011" ]; then
    rm -f "/usr/local/bin/Remove2011"
  fi

  curl -so "/usr/local/bin/Remove2011" "https://raw.githubusercontent.com/pbowden-msft/Remove2011/master/Remove2011"

  chown root:wheel "/usr/local/bin/Remove2011"
  chmod 775 "/usr/local/bin/Remove2011"
  chmod +x "/usr/local/bin/Remove2011"

  # adobe_prtk

  echo "==> Install 'adobe_prtk'"

  if [ -s "/usr/local/bin/adobe_prtk" ]; then
    rm -f "/usr/local/bin/adobe_prtk"
  fi

  curl -so "/usr/local/bin/adobe_prtk" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/adobe_prtk"

  chown root:wheel "/usr/local/bin/adobe_prtk"
  chmod 775 "/usr/local/bin/adobe_prtk"
  chmod +x "/usr/local/bin/adobe_prtk"

  # AppStoreXtractor

  echo "==> Install 'AppStoreXtractor'"

  if [ -s "/usr/local/bin/AppStoreXtractor" ]; then
    rm -f "/usr/local/bin/AppStoreXtractor"
  fi

  curl -so "/usr/local/bin/AppStoreXtractor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/AppStoreXtractor"

  chown root:wheel "/usr/local/bin/AppStoreXtractor"
  chmod 775 "/usr/local/bin/AppStoreXtractor"
  chmod +x "/usr/local/bin/AppStoreXtractor"

  # outset

  echo "==> Install 'outset'"

  outsetVersion="2.0.6"

  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && mkdir -p "${tmpDir}"

  cd "${tmpDir}" && curl -s -O -J -L "https://github.com/chilcote/outset/releases/download/v${outsetVersion}/outset-${outsetVersion}.pkg"

  installer -pkg "${tmpDir}/outset-${outsetVersion}.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"

  # offset

  echo "==> Install 'offset'"

  offsetVersion="1.4.2"

  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && mkdir -p "${tmpDir}"

  cd "${tmpDir}" && curl -s -O -J -L "https://github.com/aysiu/offset/releases/download/${offsetVersion}/Offset.pkg"

  installer -pkg "${tmpDir}/Offset.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"

  # SafariBookmarkEditor

  echo "==> Install 'SafariBookmarkEditor'"

  if [ -s "/usr/local/bin/SafariBookmarkEditor" ]; then
    rm -f "/usr/local/bin/SafariBookmarkEditor"
  fi

  curl -so "/usr/local/bin/SafariBookmarkEditor" "https://raw.githubusercontent.com/robperc/SafariBookmarkEditor/master/SafariBookmarkEditor.py"

  chown root:wheel "/usr/local/bin/SafariBookmarkEditor"
  chmod 775 "/usr/local/bin/SafariBookmarkEditor"
  chmod +x "/usr/local/bin/SafariBookmarkEditor"

  # FinderSidebarEditor

  echo "==> Install 'FinderSidebarEditor'"

  if [ -s "/usr/local/bin/FinderSidebarEditor" ]; then
    rm -f "/usr/local/bin/FinderSidebarEditor"
  fi

  curl -so "/usr/local/bin/FinderSidebarEditor" "https://raw.githubusercontent.com/robperc/FinderSidebarEditor/master/FinderSidebarEditor.py"

  chown root:wheel "/usr/local/bin/FinderSidebarEditor"
  chmod 775 "/usr/local/bin/FinderSidebarEditor"
  chmod +x "/usr/local/bin/FinderSidebarEditor"

  # duti

  echo "==> Install 'duti'"

  if [ -s "/usr/local/bin/duti" ]; then
    rm -f "/usr/local/bin/duti"
  fi

  curl -so "/usr/local/bin/duti" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/duti"

  chown root:wheel "/usr/local/bin/duti"
  chmod 775 "/usr/local/bin/duti"
  chmod +x "/usr/local/bin/duti"

  # ncdu

  echo "==> Install 'ncdu'"

  if [ -s "/usr/local/bin/ncdu" ]; then
    rm -f "/usr/local/bin/ncdu"
  fi

  curl -so "/usr/local/bin/ncdu" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/ncdu"

  chown root:wheel "/usr/local/bin/ncdu"
  chmod 775 "/usr/local/bin/ncdu"
  chmod +x "/usr/local/bin/ncdu"

  # mas

  if [ ${minor} -ge 13 ]; then

    echo "==> Install 'mas'"

    masVersion="1.6.3"

    tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && mkdir -p "${tmpDir}"

    cd "${tmpDir}" && curl -s -O -J -L "https://github.com/mas-cli/mas/releases/download/v1.6.3/mas.pkg"

    installer -pkg "${tmpDir}/mas.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"

  fi

  # xmlstarlet

  echo "==> Install 'xmlstarlet'"

  if [ -s "/usr/local/bin/xmlstarlet" ]; then
    rm -f "/usr/local/bin/xmlstarlet"
  fi

  curl -so "/usr/local/bin/xmlstarlet" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/xmlstarlet"

  chown root:wheel "/usr/local/bin/xmlstarlet"
  chmod 775 "/usr/local/bin/xmlstarlet"
  chmod +x "/usr/local/bin/xmlstarlet"

  # reattach-to-user-namespace

  echo "==> Install 'reattach-to-user-namespace'"

  if [ -s "/usr/local/bin/reattach-to-user-namespace" ]; then
    rm -f "/usr/local/bin/reattach-to-user-namespace"
  fi

  curl -so "/usr/local/bin/reattach-to-user-namespace" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/reattach-to-user-namespace"

  chown root:wheel "/usr/local/bin/reattach-to-user-namespace"
  chmod 775 "/usr/local/bin/reattach-to-user-namespace"
  chmod +x "/usr/local/bin/reattach-to-user-namespace"

  # RegMAU

  echo "==> Install 'RegMAU'"

  if [ -s "/usr/local/bin/RegMAU" ]; then
    rm -f "/usr/local/bin/RegMAU"
  fi

  curl -so "/usr/local/bin/RegMAU" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/RegMAU"

  chown root:wheel "/usr/local/bin/RegMAU"
  chmod 775 "/usr/local/bin/RegMAU"
  chmod +x "/usr/local/bin/RegMAU"

  # MSUpdateHelper

  if [ -s "/usr/local/bin/MSUpdateHelper2019" ]; then
    rm -f "/usr/local/bin/MSUpdateHelper2019"
  fi

  echo "==> Install 'MSUpdateHelper'"

  if [ -s "/usr/local/bin/MSUpdateHelper" ]; then
    rm -f "/usr/local/bin/MSUpdateHelper"
  fi

  curl -so "/usr/local/bin/MSUpdateHelper" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/MSUpdateHelper"

  chown root:wheel "/usr/local/bin/MSUpdateHelper"
  chmod 775 "/usr/local/bin/MSUpdateHelper"
  chmod +x "/usr/local/bin/MSUpdateHelper"

  # alerter

  echo "==> Install 'alerter'"

  if [ -s "/usr/local/bin/alerter" ]; then
    rm -f "/usr/local/bin/alerter"
  fi

  curl -so "/usr/local/bin/alerter" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/alerter"

  chown root:wheel "/usr/local/bin/alerter"
  chmod 775 "/usr/local/bin/alerter"
  chmod +x "/usr/local/bin/alerter"

  # PrinterMapper

  echo "==> Install 'PrinterMapper'"

  if [ -s "/usr/local/bin/PrinterMapper" ]; then
    rm -f "/usr/local/bin/PrinterMapper"
  fi

  curl -so "/usr/local/bin/PrinterMapper" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/PrinterMapper"

  chown root:wheel "/usr/local/bin/PrinterMapper"
  chmod 775 "/usr/local/bin/PrinterMapper"
  chmod +x "/usr/local/bin/PrinterMapper"

  # lohelper

  echo "==> Install 'lohelper'"

  if [ -s "/usr/local/bin/lohelper" ]; then
    rm -f "/usr/local/bin/lohelper"
  fi

  curl -so "/usr/local/bin/lohelper" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/lohelper"

  chown root:wheel "/usr/local/bin/lohelper"
  chmod 775 "/usr/local/bin/lohelper"
  chmod +x "/usr/local/bin/lohelper"

  # randomizer

  echo "==> Install 'randomizer'"

  if [ -s "/usr/local/bin/randomizer" ]; then
    rm -f "/usr/local/bin/randomizer"
  fi

  curl -so "/usr/local/bin/randomizer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/randomizer"

  chown root:wheel "/usr/local/bin/randomizer"
  chmod 775 "/usr/local/bin/randomizer"
  chmod +x "/usr/local/bin/randomizer"

  # installinstallmacos

  if [ -s "/usr/local/bin/installinstallmacos" ]; then
    echo "==> Uninstall 'installinstallmacos'"
    rm -f "/usr/local/bin/installinstallmacos"
  fi

  # assimilateownership

  echo "==> Install 'assimilateownership'"

  if [ -s "/usr/local/bin/assimilateownership" ]; then
    rm -f "/usr/local/bin/assimilateownership"
  fi

  curl -so "/usr/local/bin/assimilateownership" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/assimilateownership"

  chown root:wheel "/usr/local/bin/assimilateownership"
  chmod 775 "/usr/local/bin/assimilateownership"
  chmod +x "/usr/local/bin/assimilateownership"

  # erase-install

  echo "==> Install 'erase-install'"

  if [ -s "/usr/local/bin/erase-install" ]; then
    rm -f "/usr/local/bin/erase-install"
  fi

  curl -so "/usr/local/bin/erase-install" "https://raw.githubusercontent.com/grahampugh/erase-install/master/erase-install.sh"

  chown root:wheel "/usr/local/bin/erase-install"
  chmod 775 "/usr/local/bin/erase-install"
  chmod +x "/usr/local/bin/erase-install"

  # jpscheck

  echo "==> Install 'jpscheck'"

  if [ -s "/Library/LaunchDaemons/ch.anykey.jpscheck.plist" ]; then
    launchctl unload -w "/Library/LaunchDaemons/ch.anykey.jpscheck.plist"
    rm -rf "/Library/LaunchDaemons/ch.anykey.jpscheck.plist"
  fi

  /usr/local/bin/jamf scheduledTask \
    -command "/usr/local/bin/jpscheck" \
    -name "jpscheck" \
    -user "root" \
    -runAtLoad "true" \
    -minute "*/30/"

  curl -so "/usr/local/bin/jpscheck" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/jpscheck"

  chown root:wheel "/usr/local/bin/jpscheck"
  chmod 775 "/usr/local/bin/jpscheck"
  chmod +x "/usr/local/bin/jpscheck"
