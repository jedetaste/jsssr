#!/bin/bash
	
	rm -rf "/private/tmp/recipes2"
	
	cd "/private/tmp/"
	git clone "https://github.com/jedetaste/recipes2.git"
	
	rm -f "/private/tmp/recipes2/firefoxesr.json"
	rm -f "/private/tmp/recipes2/firefox-en.json"
	rm -f "/private/tmp/recipes2/firefoxesr-en.json"
	rm -f "/private/tmp/recipes2/thunderbird-en.json"
	rm -f "/private/tmp/recipes2/istopmotion2.json"
	
	for json in /private/tmp/recipes2/*.json; do
		
		id=$(/usr/local/bin/jq -r '.[].id' "${json}")
		/usr/local/bin/aky -u "${id}"
		
	done
	
	rm -rf "/private/tmp/recipes2"
	
exit 0