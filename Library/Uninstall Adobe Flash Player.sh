	#!/bin/bash

		download="https://fpdownload.macromedia.com/get/flashplayer/current/support/uninstall_flash_player_osx.dmg"

		tmpDir=$(/usr/local/bin/tmpDir)
		
		echo "=> Download '${download}'"
		curl -s -o "${tmpDir}/uninstall_flash_player_osx.dmg" "${download}"

		filePath=$(/usr/bin/find "${tmpDir}" -name "*.dmg")

		fileName=$(/usr/bin/basename "${filePath}")
		extension="${fileName##*.}"
		id="${fileName%.*}"

		echo "==> Installer downloaded to '${filePath}'"

		/usr/bin/hdiutil convert -quiet "${filePath}" -format UDTO -o "${filePath}.cdr"

		echo "==> Mount CDR '${filePath}.cdr' and grep volume name"

		mountPoint="${tmpDir}/mountPoint" && /bin/mkdir "${mountPoint}"
		cdr="${filePath}.cdr"
		tmpMountPointFile=$(mktemp /${tmpDir}/cdr.XXX) &&

		/usr/bin/hdiutil attach -plist -nobrowse -readonly -noidme -mountrandom "${mountPoint}" "${cdr}" > "${tmpMountPointFile}" &&

		loc=":system-entities:"
		num=$(/usr/libexec/PlistBuddy -c "Print :system-entities:" ${tmpMountPointFile} | /usr/bin/grep -c Dict 2>/dev/null)

		for i in $(seq 0 $((num-1))) ; do
			loc=":system-entities:${i}:mount-point"
			locDevEntry=":system-entities:${i}:dev-entry"
			volumeName="$(/usr/libexec/PlistBuddy -c "Print ${loc}" "${tmpMountPointFile}" 2>/dev/null)"
			volumeNameDevEntry="$(/usr/libexec/PlistBuddy -c "Print ${locDevEntry}" "${tmpMountPointFile}" 2>/dev/null)"
			if [ -n "${volumeName}" -a -z "$(echo ${volumeName} | grep 'Does Not Exist')" ]; then
				break
			fi
		done

		echo "==> Running uninstaller at '${volumeName}/Adobe Flash Player Uninstaller.app/Contents/MacOS/Adobe Flash Player Install Manager'"

		"${volumeName}/Adobe Flash Player Uninstaller.app/Contents/MacOS/Adobe Flash Player Install Manager" -uninstall > /dev/null 2>&1

		if [ ! -z "${volumeName}" ]; then
			echo "==> Eject volume '${volumeName}'"
			/usr/sbin/diskutil eject "${volumeName}" > /dev/null 2>&1
			until [ ! -d "${volumeName}" ]; do
				echo "==> Remove Dev-Entry for '${volumeName}'"
				/usr/sbin/diskutil unmount force "${volumeName}" > /dev/null 2>&1
			done
		fi

		if [ ! -z "${volumeNameDevEntry}" ]; then
			echo "==> Eject volume '${volumeNameDevEntry}'"
			/usr/sbin/diskutil eject "${volumeNameDevEntry}" > /dev/null 2>&1
			until [ ! -d "${volumeNameDevEntry}" ]; do
				echo "==> Remove Dev-Entry for '${volumeNameDevEntry}'"
				/usr/sbin/diskutil unmount force "${volumeNameDevEntry}" > /dev/null 2>&1
			done
		fi

		rm -rf "${tmpDir}"
