#!/bin/bash

su -l "$(/usr/local/bin/currentuser)" -c "killall zoom.us"

[ -d "/Applications/zoom.us.app" ] && rm -rf "/Applications/zoom.us.app"

for user_home in "/Users"/*; do
  user_uid="$(basename "${user_home}")"
  if [ ! "${user_uid}" = "Shared" ]; then

    array=(
      ".zoomus/ZoomOpener.app"
      "Library/Internet Plug-Ins/ZoomUsPlugIn.plugin"
      ".zoomus"
      "Library/Application Support/zoom.us"
      "Library/Caches/us.zoom.xos"
      "Library/Cookies/us.zoom.xos.binarycookies"
      "Library/Logs/zoom.us"
      "Library/Logs/zoominstall.log"
      "Library/Preferences/ZoomChat.plist"
      "Library/Preferences/us.zoom.xos.plist"
      "Library/Safari/PerSiteZoomPreferences.plist"
      "Library/SafariTechnologyPreview/PerSiteZoomPreferences.plist"
      "Library/Saved Application State/us.zoom.xos.savedState"
    )

    for item in "${array[@]}"; do
      if [ -d "${user_home}/${item}" ]; then
	    echo "=> Remove '${user_home:?}/${item:?}'"
        rm -rf "${user_home:?}/${item:?}"
      elif [ -s "${user_home}/${item}" ]; then
        echo "=> Remove '${user_home:?}/${item:?}'"
        rm -f "${user_home:?}/${item:?}"
      fi
    done

  fi
done
