#!/bin/bash

workDir=$(/usr/local/bin/tmpDir)

readonly Filepath="${1}.url"
readonly URL="${2}"
readonly Icon="https://raw.githubusercontent.com/jedetaste/james/master/icons/${3}.png"

# Check if fileicon binary is installed 
if [ ! -s "/usr/local/bin/fileicon" ]; then
	echo "FileIcon Binary not Found. Exiting" && exit 1
fi

#Create .url File
	cat >"${Filepath}" <<EOF
[InternetShortcut]
URL=${URL}
EOF

# Download and assign Icon
	echo "==> Downloading '${Icon}'"

	curl \
		--show-error \
		--output "${workDir}/Icon.png" \
		--silent \
		"${Icon}" \
		
		 if [ -s "${workDir}/Icon.png" ]; then
					echo "==> Download was successful"
				else
					echo "==> Download failed, as no appropriate data was found"
					rm -rf "${workDir}" && exit 1
				fi		
				
				
