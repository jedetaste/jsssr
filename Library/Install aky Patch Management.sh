#!/bin/bash

	if [ ! -d "/usr/local/aky" ]; then
		/bin/mkdir -p "/usr/local/aky"
	fi
	
	akyBinary=(
		"aky"
		"download-helper"
		"install-helper"
		"mas-helper"
		"notification-helper"
		"rg"
		"versioning-helper"
		"jq"
		"aria2c"
	)
	
	for ((i = 0; i < "${#akyBinary[@]}"; i++)); do
		/bin/rm -f "/usr/local/bin/${akyBinary[$i]}"
		/bin/rm -f "/usr/local/aky/${akyBinary[$i]}"
		/usr/bin/curl -so "/usr/local/aky/${akyBinary[$i]}" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/${akyBinary[$i]}"
		/usr/sbin/chown root:wheel "/usr/local/aky/${akyBinary[$i]}"
		/bin/chmod +x "/usr/local/aky/${akyBinary[$i]}"
		/bin/ln -s "/usr/local/aky/${akyBinary[$i]}" "/usr/local/bin/${akyBinary[$i]}"
	done