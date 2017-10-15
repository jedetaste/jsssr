#!/bin/bash
	
	# Set keyboard layout
	# Set computer language
	# Set the region
	
	KEYBOARDNAME="Swiss German"
	KEYBOARDCODE="19"
	LANG="de"
	REGION="de_CH"
	PLBUDDY="/usr/libexec/PlistBuddy"
	
	update_kdb_layout() {
		${PLBUDDY} -c "Delete :AppleCurrentKeyboardLayoutInputSourceID" "${1}" &>/dev/null
		if [ ${?} -eq 0 ]; then
			${PLBUDDY} -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.${KEYBOARDNAME}" "${1}"
		fi
	
		for SOURCE in AppleDefaultAsciiInputSource AppleCurrentAsciiInputSource AppleCurrentInputSource AppleEnabledInputSources AppleSelectedInputSources
		do
			${PLBUDDY} -c "Delete :${SOURCE}" "${1}" &>/dev/null
			if [ ${?} -eq 0 ]; then
				${PLBUDDY} -c "Add :${SOURCE} array" "${1}"
				${PLBUDDY} -c "Add :${SOURCE}:0 dict" "${1}"
				${PLBUDDY} -c "Add :${SOURCE}:0:InputSourceKind string 'Keyboard Layout'" "${1}"
				${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ ID integer ${KEYBOARDCODE}" "${1}"
				${PLBUDDY} -c "Add :${SOURCE}:0:KeyboardLayout\ Name string '${KEYBOARDNAME}'" "${1}"
			fi
		done
	}
	
	update_language() {
		${PLBUDDY} -c "Delete :AppleLanguages" "${1}" &>/dev/null
		if [ ${?} -eq 0 ]; then
			${PLBUDDY} -c "Add :AppleLanguages array" "${1}"
			${PLBUDDY} -c "Add :AppleLanguages:0 string '${LANG}'" "${1}"
		fi
	}
	
	update_region() {
		${PLBUDDY} -c "Delete :AppleLocale" "${1}" &>/dev/null
		${PLBUDDY} -c "Add :AppleLocale string ${REGION}" "${1}" &>/dev/null
		${PLBUDDY} -c "Delete :Country" "${1}" &>/dev/null
		${PLBUDDY} -c "Add :Country string ${REGION:3:2}" "${1}" &>/dev/null
	}
	
	update_kdb_layout "/Library/Preferences/com.apple.HIToolbox.plist" "${KEYBOARDNAME}" "${KEYBOARDCODE}"
	
	for HOME in /Users/*
		do
			if [ -d "${HOME}"/Library/Preferences ]; then
				cd "${HOME}"/Library/Preferences
				HITOOLBOX_FILES=`find . -name "com.apple.HIToolbox.*plist"`
				for HITOOLBOX_FILE in ${HITOOLBOX_FILES}
				do
					update_kdb_layout "${HITOOLBOX_FILE}" "${KEYBOARDNAME}" "${KEYBOARDCODE}"
				done
			fi
	done
	
	update_language "/Library/Preferences/.GlobalPreferences.plist" "${LANG}"
	
	for HOME in /Users/*
		do
			if [ -d "${HOME}"/Library/Preferences ]; then
				cd "${HOME}"/Library/Preferences
				GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
				for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
				do
					update_language "${GLOBALPREFERENCES_FILE}" "${LANG}"
				done
			fi
	done
	
	update_region "/Library/Preferences/.GlobalPreferences.plist" "${REGION}"
	
	for HOME in /Users/*
		do
			if [ -d "${HOME}"/Library/Preferences ]; then
				cd "${HOME}"/Library/Preferences
				GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
				for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
				do
					update_region "${GLOBALPREFERENCES_FILE}" "${REGION}"
				done
			fi
	done
	
	/usr/sbin/languagesetup -langspec German
	
exit 0