#!/bin/bash
	
	currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
	configFile="/Users/${currentUser}/Library/Application Support/Kerio Connect/config.json"
	
	if [ -s "${configFile}" ]; then
		
		randstring=$(openssl rand -hex 5)
		tmp="/private/tmp/${randstring}"
		mkdir -p ${tmp}
				
		if [ -z "${currentuser}" ]; then
			if [ -s "/Users/${currentuser}/.rnd" ]; then
				rm -f "/Users/${currentuser}/.rnd"
			fi
		else
			rm -rf "${tmp}"
			exit 0
		fi
		
		/usr/local/bin/jq '.updateAllowed = false' "${configFile}" > "${tmp}/config.json"
		rm -f "${configFile}"
		/bin/mv "${tmp}/config.json" "${configFile}"
		chown "${currentUser}" "${configFile}"
		
		rm -rf "${tmp}"
		
	fi
	
exit 0