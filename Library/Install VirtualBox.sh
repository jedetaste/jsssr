#!/bin/bash

/usr/local/bin/aky virtualbox

chown -R root:admin "/Applications/VirtualBox.app"

SET_UID_BINARIES="MacOS/VBoxNetAdpCtl"
SET_UID_BINARIES="${SET_UID_BINARIES} MacOS/VBoxHeadless MacOS/VBoxNetDHCP MacOS/VBoxNetNAT Resources/VirtualBoxVM.app/Contents/MacOS/VirtualBoxVM"
for bin in ${SET_UID_BINARIES}; do
  echo "==> Adjust permissions for '/Applications/VirtualBox.app/Contents/MacOS/${bin}'"
  chmod u+s "/Applications/VirtualBox.app/Contents/${bin}"
done

version=$(curl --silent --insecure "https://download.virtualbox.org/virtualbox/LATEST.TXT")
echo "==> Install 'VirtualBox ${version} Oracle VM VirtualBox Extension Pack'"

curl \
  --silent \
  --output "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack" \
  "https://download.virtualbox.org/virtualbox/${version}/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"

echo "y" | /usr/local/bin/VBoxManage extpack install --replace "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"

if [ -s "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack" ]; then
  rm -rf "/private/tmp/Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
fi
