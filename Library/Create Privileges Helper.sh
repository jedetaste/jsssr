#!/bin/bash

error=0

helper_path="/Applications/Privileges.app/Contents/Library/LaunchServices/corp.sap.privileges.helper"

if [[ -f "${helper_path}" ]]; then

  # Create the target directory if needed

  if [[ ! -d "/Library/PrivilegedHelperTools" ]]; then
    mkdir -p "/Library/PrivilegedHelperTools"
    chmod 755 "/Library/PrivilegedHelperTools"
    chown -R root:wheel "/Library/PrivilegedHelperTools"
  fi

  # Move the privileged helper into place

  cp -f "${helper_path}" "/Library/PrivilegedHelperTools"

  if [[ $? -eq 0 ]]; then
    chmod 755 "/Library/PrivilegedHelperTools/corp.sap.privileges.helper"

    # create the launchd plist

    plist="/Library/LaunchDaemons/corp.sap.privileges.helper.plist"

    cat >"${plist}" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>Label</key>
		<string>corp.sap.privileges.helper</string>
		<key>MachServices</key>
		<dict>
			<key>corp.sap.privileges.helper</key>
			<true/>
		</dict>
		<key>ProgramArguments</key>
		<array>
			<string>/Library/PrivilegedHelperTools/corp.sap.privileges.helper</string>
		</array>
	</dict>
</plist>
EOF

    chmod 644 "${plist}"

    # Load the launchd plist

    launchctl load -wF "${plist}"

  else
    error=1
  fi
else
  error=1
fi

exit ${error}
