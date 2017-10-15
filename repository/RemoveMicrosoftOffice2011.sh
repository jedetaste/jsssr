#!/bin/bash

	# Remove working directory if exists
	if [ -d "/private/tmp/Remove2011" ]; then
		rm -rf "/private/tmp/Remove2011"
	fi

	# Switch to tmp directory
	cd "/private/tmp"

	# Clone Remove2011 repository
	git clone "https://github.com/pbowden-msft/Remove2011.git"

	# Make bash script executable
	chmod +x "Remove2011/Remove2011"

	# Run uninstaller
	"Remove2011/Remove2011"

	# Remove tmp directory
	rm -rf "Remove2011"

exit 0