#!/bin/bash
  
  jamf="/usr/local/jamf/bin/jamf"
  computerName=$(/usr/sbin/scutil --get ComputerName)
  
  if [ -s "${jamf}" ]; then
    "${jamf}" setComputerName -target / -name "${computerName}"
  fi