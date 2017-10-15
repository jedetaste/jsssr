#!/bin/bash
	
	consoleuser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
	
	echo "logged in user is ${consoleuser}"
	
	pkill -f Microsoft
	
	folders=(
		"/Applications/Microsoft Excel.app"
		"/Applications/Microsoft OneNote.app"
		"/Applications/Microsoft Outlook.app"
		"/Applications/Microsoft PowerPoint.app"
		"/Applications/Microsoft Word.app"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.errorreporting"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.Excel"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.netlib.shipassertprocess"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.Office365ServiceV2"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.Outlook"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.Powerpoint"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.RMS-XPCService"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.Word"
		"/Users/${consoleuser}/Library/Containers/com.microsoft.onenote.mac"
	)
	
	search="*"
	
	for i in "${folders[@]}"; do
		
		echo "removing folder ${i}"
		rm -rf "${i}"
		
	done
	
	/usr/local/bin/dockutil --remove "Microsoft Excel" /Users/${consoleuser}
	/usr/local/bin/dockutil --remove "Microsoft OneNote" /Users/${consoleuser}
	/usr/local/bin/dockutil --remove "Microsoft Outlook" /Users/${consoleuser}
	/usr/local/bin/dockutil --remove "Microsoft PowerPoint" /Users/${consoleuser}
	/usr/local/bin/dockutil --remove "Microsoft Word" /Users/${consoleuser}
	
	if [ $? == 0 ]; then
		
		echo "Success"
		
		exit 0
		
	else
		
		echo "Failure"
		
		exit 1
		
	fi