#!/bin/bash
  
  readonly username="${1}"
  readonly password="${2}"
  readonly oldPassword="${3}"
  
  jamf="/usr/local/jamf/bin/jamf"
  
  "${jamf}" changePassword \
    -username "${username}" \
    -password "${password}" \
    -oldPassword "${oldPassword}"