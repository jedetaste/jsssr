#!/bin/bash

logo="/System/Library/CoreServices/Software Update.app/Contents/Resources/SoftwareUpdate.icns"

plist="/Library/Preferences/ch.anykey.asu"

bundle_id="ch.anykey.asu"

###

MSG_ACT_OR_DEFER_HEADING="Critical updates are available"

MSG_ACT_OR_DEFER="Apple has released critical security updates, and your IT department would like you to install them as soon as possible. Please save your work, quit all applications, and click Run Updates.
{{If now is not a good time, you may defer this message until later. }}Updates will install automatically after %DEFER_HOURS% hours<<, forcing your Mac to restart in the process>>. Note: This may result in losing unsaved work.
If you'd like to manually install the updates yourself, open %UPDATE_MECHANISM% and apply all system and security updates<<, then restart when prompted>>.
If you have any questions, please call or email the IT help desk."

MSG_ACT_HEADING="Please run updates now"

MSG_ACT="Please save your work, then open %UPDATE_MECHANISM% and apply all system and security updates<<, then restart when prompted>>. If no action is taken, updates will be installed automatically<<, and your Mac will restart>>."

MSG_UPDATING_HEADING="Running updates"

MSG_UPDATING="Running system updates in the background.<< Your Mac will restart automatically when this is finished.>> You can force this to complete sooner by opening %UPDATE_MECHANISM% and applying all system and security updates."

###

check_for_updates() {

  echo "Checking for pending system updates..."
  update_check=$(softwareupdate --list)

  if [[ "${update_check}" =~ (Action: restart|\[restart\]) ]]; then
    install_which="all"
  elif [[ "${update_check}" =~ (Recommended: YES|\[recommended\]) ]]; then
    install_which="recommended"
  else
    echo "No critical updates available."
    exit 0
  fi

  echo "Caching ${install_which} system updates..."
  softwareupdate --download --${install_which} --no-scan

}

run_updates() {

  echo "Running ${install_which} system updates..."
  "${jamf_helper}" -windowType "hud" -icon "${logo}" -title "$MSG_UPDATING_HEADING" -description "$MSG_UPDATING" -lockHUD &

  update_output_capture="$(softwareupdate --install --${install_which} --no-scan 2>&1)"

  echo "Finished running updates."
  killall jamfHelper 2>/dev/null
  clean_up

  if [[ "${install_which}" == "all" ]]; then
    if [[ "$update_output_capture" =~ "select Shut Down from the Apple menu" ]]; then
      trigger_restart "shut down"
    else
      trigger_restart "restart"
    fi
  fi

}

trigger_restart() {

  hard_restart_delay=$((60 * 5))

  echo "Attempting a \"soft\" ${1}..."
  current_user=$(scutil <<<"show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }'%)
  user_id=$(id -u "${current_user}")
  launchctl asuser "${user_id}" osascript -e "tell application \"System Events\" to ${1}"

  echo "Waiting $((hard_restart_delay / 60)) minutes before forcing a \"hard\" ${1}..."
  sleep "${hard_restart_delay}"
  echo "$((hard_restart_delay / 60)) minutes have elapsed since \"soft\" ${1} was attempted. Forcing \"hard\" ${1}..."

  user_pids=$(pgrep -u "${user_id}")
  loginwindow_pid=$(pgrep -x -u "${user_id}" loginwindow)
  for pid in ${user_pids}; do
    if [[ "$PID" -ne "${loginwindow_pid}" ]]; then
      kill -9 "${pid}"
    fi
  done

  launchctl asuser "${user_id}" osascript -e "tell application \"System Events\" to ${1}"

}

clean_up() {

  echo "Cleaning up stored plist values..."
  defaults delete "${plist}" AppleSoftwareUpdatesForcedAfter 2>/dev/null
  defaults delete "${plist}" AppleSoftwareUpdatesDeferredUntil 2>/dev/null

  echo "Cleaning up main script and LaunchDaemons..."
  mv "/Library/LaunchDaemons/$bundle_id.plist" "/private/tmp/$bundle_id.plist"
  launchctl unload -w "$HELPER_LD"
  mv "$0" "/private/tmp/"

}

bailout=false

jamf_helper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
if [[ ! -x "${jamf_helper}" ]]; then
  echo "Error: The jamfHelper binary must be present in order to run this script."
  bailout=true
fi

if [[ ! "$(command -v jamf)" ]]; then
  echo "Error: The jamf binary could not be found."
  bailout=true
fi

IFS='.' read -r os_major os_minor os_revision < <(sw_vers -productVersion)

if [[ "${os_major}" -eq 10 && "${os_minor}" -lt 12 ]] || [[ "${os_major}" -lt 10 ]]; then
  echo "Error: This script requires at least macOS 10.12. This Mac has ${os_major}.${os_minor}.${os_revision}"
  bailout=true
elif [[ "${os_major}" -gt 10 ]] || [[ "${os_minor}" -gt 15 ]]; then
  echo "Error: This script has been tested through macOS 10.15 only. This Mac has ${os_major}.${os_minor}.${os_revision}"
  bailout=true
fi

if fdesetup status | grep -q "in progress"; then
  echo "Error: FileVault encryption or decryption is in progress."
  bailout=true
fi

if [[ "${bailout}" == "true" ]]; then
  echo "Error: Validation and error checking failed"
  exit 1
else
  echo "Validation and error checking passed. Starting main process..."
fi

check_for_updates

echo "Prompting to install updates now or defer..."
"${jamf_helper}" -windowType "utility" -icon "${logo}" -title "$MSG_ACT_OR_DEFER_HEADING" -description "$MSG_ACT_OR_DEFER" -button1 "Run Updates" -button2 "Defer" -defaultButton 2 -timeout 3600

echo "Prompting to install updates now or defer..."
PROMPT=$("$JAMFHELPER" -windowType "utility" -windowPosition "ur" -icon "$LOGO" -title "$MSG_ACT_OR_DEFER_HEADING" -description "$MSG_ACT_OR_DEFER" -button1 "Run Updates" -button2 "Defer" -defaultButton 2 -timeout 3600 -startlaunchd 2>/dev/null)
JAMFHELPER_PID=$!
