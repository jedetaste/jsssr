#!/bin/bash

workDir=$(/private/tmp/)

readonly Filepath="${1}.url"
readonly URL="${2}"
readonly Icon="https://github.com/jedetaste/james/blob/master/icons/${3}.png"

# Check if fileicon binary is installed 
if [ ! -s "/usr/local/bin/sponge" ]; then
	echo "FileIcon Binary not Found. Exiting" && exit 1
fi

#Create .url File
	cat >"${Filepath}" <<EOF
[InternetShortcut]
URL="${URL}"
EOF

# Download and assign Icon
	echo "==> Downloading '${Icon}'"

	curl \
		--show-error --fail --location --remote-time \
		--output "${workDir}/${3}.png" \
		--silent \
		"${url}" \
		
		 if [ -s "${workDir}/${3}" ]; then
					echo "==> Download was successful"
				else
					echo "==> Download failed, as no appropriate data was found"
					rm -rf "${workDir}" && exit 1
				fi		
				
				
