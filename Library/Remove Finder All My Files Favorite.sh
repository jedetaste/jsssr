#!/bin/bash

  currentuser=$(/usr/sbin/scutil <<< "show State:/Users/ConsoleUser" | awk -F': ' '/[[:space:]]+Name[[:space:]]:/ { if ( $2 != "loginwindow" ) { print $2 }}')

  if [ -z "${currentuser}" ]; then
    su -l "${currentuser}" -c "/usr/local/bin/mysides remove 'All My Files'"
    su -l "${currentuser}" -c "/usr/local/bin/mysides remove 'Alle meine Dateien'"
  fi
