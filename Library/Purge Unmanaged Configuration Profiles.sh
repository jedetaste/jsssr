#!/bin/bash

  profiles -L | awk '{print $4}' | while read profile_uuid; do

    mdm_profile_uuid=$(profiles -Lv | grep "name: MDM Profile" -6 | awk '/attribute: profileUUID:/ {print $NF}')
    profile_removal_disallowed=$(profiles -Lv | grep "profileUUID: ${profile_uuid}" -6 | awk '/attribute: removalDisallowed:/ {print $NF}')
    profile_identifier=$(profiles -Lv | grep "profileUUID: ${profile_uuid}" -6 | awk '/attribute: profileIdentifier:/ {print $NF}')

    if [[ "${profile_removal_disallowed}" = "FALSE" && ! -z "${profile_removal_disallowed}" ]]; then
      if [ ! "${mdm_profile_uuid}" = "${profile_uuid}" ]; then
        echo "=> Profile '${profile_uuid}' is unmanaged, identifier is '${profile_identifier}'"
        profiles -R -p "${profile_identifier}"
      fi
    fi

  done