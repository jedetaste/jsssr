#!/bin/bash -x

/usr/local/bin/aky parallelsdesktop

chflags nohidden "/Applications/Parallels Desktop.app"
xattr -d com.apple.FinderInfo "/Applications/Parallels Desktop.app"

sudo -E -- "/Applications/Parallels Desktop.app/Contents/MacOS/inittool" init
