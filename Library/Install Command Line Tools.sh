#!/bin/bash

minimum_darwin_version="16"

if [[ "$(sw_vers -buildVersion)" > "${minimum_darwin_version}" ]]; then

  if ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]; then

    chomp() {
      printf "%s" "${1/"$'\n'"/}"
    }

    clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"

    touch "${clt_placeholder}"

    clt_label_command="softwareupdate -l | grep -B 1 -E 'Command Line Tools' | awk -F'*' '/^ *\\*/ {print \$2}' | sed -e 's/^ *Label: //' -e 's/^ *//' | sort -V | tail -n1"

    clt_label="$(chomp "$(/bin/bash -c "$clt_label_command")")"

    if [[ -n "${clt_label}" ]]; then
      echo "=> Installing ${clt_label}"
      softwareupdate -i "${clt_label}"
      rm -f "${clt_placeholder}"
      xcode-select --switch "/Library/Developer/CommandLineTools"
    fi

  else
    echo "=> Command Line Tools already installed"
  fi

else
  echo "=> Command Line Tools require Darwin version ${minimum_darwin_version} or greater"
fi
