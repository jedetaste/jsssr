#!/bin/bash

  /usr/local/bin/aky virtualbox

  SET_UID_BINARIES="VBoxNetAdpCtl"
  SET_UID_BINARIES="${SET_UID_BINARIES} VBoxHeadless VirtualBoxVM VBoxNetDHCP VBoxNetNAT"
  for bin in ${SET_UID_BINARIES}; do
    echo "==> Adjust permissions for '/Applications/VirtualBox.app/Contents/MacOS/${bin}'"
    chmod u+s "/Applications/VirtualBox.app/Contents/MacOS/${bin}"
  done

  version=$( curl --silent --insecure "https://download.virtualbox.org/virtualbox/LATEST.TXT" )
  echo "==> Install 'VirtualBox ${version} Oracle VM VirtualBox Extension Pack'"

  curl \
    --silent \
    --output "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack" \
    "https://download.virtualbox.org/virtualbox/${version}/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"

  echo "y" | /usr/local/bin/VBoxManage extpack install --replace "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"

  if [ -s "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack" ]; then
    rm -rf "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
  fi