#!/bin/bash

# Install Privileges.app

/usr/local/bin/aky "privileges" && /usr/local/bin/jsssr "Create Privileges Helper.sh"

# Promote privileges for the current user

su -l "$(/usr/local/bin/currentuser)" -c "/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --add"

# Scheduled task for demote privileges for the current user

/usr/local/bin/jamf scheduledTask \
  -command "/Applications/Privileges.app/Contents/Resources/PrivilegesCLI --remove" \
  -name "demoteprivileges" \
  -user "$(/usr/local/bin/currentuser)" \
  -minute "*/10/"

# Scheduled task for removing Privileges.app

/usr/local/bin/jamf scheduledTask \
  -command "/usr/local/bin/aky --remove privileges" \
  -name "removeprivileges" \
  -user "root" \
  -minute "*/11/"

# Scheduled task for removing scheduled tasks

/usr/local/bin/jamf scheduledTask \
  -command "rm -f /Library/LaunchDaemons/com.jamfsoftware.task.demoteprivileges.plist /Library/LaunchDaemons/com.jamfsoftware.task.removeprivileges.plist /Library/LaunchDaemons/com.jamfsoftware.task.removescheduledtasks.plist" \
  -name "removescheduledtasks" \
  -user "root" \
  -minute "*/12/"
