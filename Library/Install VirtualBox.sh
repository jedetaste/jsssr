#!/bin/bash

	/usr/local/bin/aky virtualbox
	
	for bin in VirtualBox VirtualBoxVM VBoxNetAdpCtl VBoxNetDHCP VBoxNetNAT VBoxHeadless; do
		echo "==> Adjust permissions for '${bin}'"
		/bin/chmod u+s "/Applications/VirtualBox.app/Contents/MacOS/${bin}"
	done