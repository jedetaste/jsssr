#!/bin/bash

	BootVolume=$(diskutil info / | grep "Volume Name" | cut -c 30-)
	
	if [ "$VolumeName" != "Macintosh HD" ]; then
		diskutil renameVolume "$BootVolume" "Macintosh HD"
	fi
	
	BootVolume=$(diskutil info / | grep "Volume Name" | cut -c 30-)
	
	echo "<result>${BootVolume}</result>"
	
exit 0