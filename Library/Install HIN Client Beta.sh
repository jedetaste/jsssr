#!/bin/bash -x

set_uid() {
  echo "==> Set setuid bit for system proxy helper"
  proxysettings_wrapper_path="/Applications/HIN Client.app/Contents/Resources/app/proxysettings"
  proxysettings_script_path="/Applications/HIN Client.app/Contents/Resources/app/proxysettings.sh"
  chown 0:0 "${proxysettings_wrapper_path}"
  chown 0:0 "${proxysettings_script_path}"
  chmod 6755 "${proxysettings_wrapper_path}"
}

if [ "${1}" = "update" ]; then
  /usr/local/bin/aky --update "hinclient"
  [ -d "/Applications/HIN Client.app" ] && set_uid
else
  /usr/local/bin/aky "hinclient" && set_uid
fi
