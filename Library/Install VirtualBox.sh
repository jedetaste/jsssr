#!/bin/bash

  /usr/local/bin/aky virtualbox
  
  SET_UID_BINARIES="VBoxNetAdpCtl"
  SET_UID_BINARIES="${SET_UID_BINARIES} VBoxHeadless VirtualBoxVM VBoxNetDHCP VBoxNetNAT"
  for bin in ${SET_UID_BINARIES}; do
    echo "==> Adjust permissions for '/Applications/VirtualBox.app/Contents/MacOS/${bin}'"
    chmod u+s "/Applications/VirtualBox.app/Contents/MacOS/${bin}"
  done
