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

# Configure time settings

echo "==> Set time server to 'time.euro.apple.com'"

if [ "${minor}" -gt 13 ]; then
  systemsetup -setusingnetworktime on
  sntp -sS "time.euro.apple.com"
else
  systemsetup -setusingnetworktime on
  ntpdate -u "time.euro.apple.com"
fi
