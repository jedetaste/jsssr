#!/bin/bash

# Determine OS version and build version

echo "=> Determine macOS Version"
echo "=> Mac is running Darwin $(sw_vers -buildVersion)"

# Configure time settings

echo "==> Set time server to 'time.euro.apple.com'"

if [[ "$(sw_vers -buildVersion)" > "17" ]]; then
  systemsetup -setusingnetworktime on
  sntp -sS "time.euro.apple.com"
else
  systemsetup -setusingnetworktime on
  ntpdate -u "time.euro.apple.com"
fi
