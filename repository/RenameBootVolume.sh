#!/bin/bash

BootVolume=$(/usr/sbin/diskutil info / | grep "Volume Name" | cut -c 30-)

if [ "${VolumeName}" != "Macintosh HD" ]; then
  /usr/sbin/diskutil renameVolume "${BootVolume}" "Macintosh HD"
fi

BootVolume=$(/usr/sbin/diskutil info / | grep "Volume Name" | cut -c 30-)

echo "<result>${BootVolume}</result>"
