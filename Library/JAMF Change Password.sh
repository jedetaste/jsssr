#!/bin/bash
  
  username="${1}"
  password="${2}"
  oldPassword="${3}"
  
  jamf="/usr/local/jamf/bin/jamf"
  
  "${jamf}" changePassword \
    -username "${username}" \
    -password "${password}" \
    -oldPassword "${oldPassword}"