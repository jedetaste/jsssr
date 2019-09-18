#!/bin/bash

if [ -d "/Applications/Xcode.app" ]; then

  echo "Accept Xcode license agreement"
  /usr/bin/xcodebuild -license accept

  echo "=> Add everyone to group '_developer'"
  /usr/sbin/dseditgroup -o edit -a everyone -t group _developer

  echo "=> Install 'XcodeSystemResources.pkg'"
  /usr/sbin/installer -pkg "/Applications/Xcode.app/Contents/Resources/Packages/XcodeSystemResources.pkg" -target /

  echo "=> Install 'MobileDevice.pkg'"
  /usr/sbin/installer -pkg "/Applications/Xcode.app/Contents/Resources/Packages/MobileDevice.pkg" -target /

  echo "=> Install 'MobileDeviceDevelopment.pkg'"
  /usr/sbin/installer -pkg "/Applications/Xcode.app/Contents/Resources/Packages/MobileDeviceDevelopment.pkg" -target /

  echo "=> Enable Developer mode"
  /usr/sbin/DevToolsSecurity -enable

else

  echo "=> Xcode.app is not installed" && exit 0

fi
