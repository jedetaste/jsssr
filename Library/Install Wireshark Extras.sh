#!/bin/bash -x

if [ -d "/Applications/Wireshark.app" ]; then
  installer -verboseR -pkg "/Applications/Wireshark.app/Contents/Resources/Extras/Add Wireshark to the system path.pkg" -target /
  installer -verboseR -pkg "/Applications/Wireshark.app/Contents/Resources/Extras/Install ChmodBPF.pkg" -target /
fi
