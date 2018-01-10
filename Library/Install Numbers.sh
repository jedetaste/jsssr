#!/bin/bash

  localCDN8080=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch:8080" -o /dev/null)
  localCDN80=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch" -o /dev/null)
  cloudCDN=$(/usr/bin/host cdn.anykeyit.ch | /usr/bin/awk '{print $NF}')

  if [[ "${localCDN8080}" == "200" ]]; then

    startTime=$(date +"%s")

    echo "CDN resolves to a local IP. Continuing..."

    osvers=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')

    if [[ "${osvers}" -eq 9 ]]; then
      echo "Upgrading Numbers for Mavericks"
      /usr/local/bin/aky numbers10098080
    fi

    if [[ "${osvers}" -eq 10 ]]; then
      echo "Upgrading Numbers for Yosemite"
      /usr/local/bin/aky numbers10108080
    fi

    if [[ "${osvers}" -eq 11 ]]; then
      echo "Upgrading Numbers for El Capitain"
      /usr/local/bin/aky numbers10118080
    fi

    if [[ "${osvers}" -eq 12 ]]; then
      echo "Upgrading Numbers for Sierra"
      /usr/local/bin/aky numbers10128080
    fi

    if [[ "${osvers}" -eq 13 ]]; then
      echo "Upgrading Numbers for High Sierra"
      /usr/local/bin/aky numbers10138080
    fi

    endTime=$(date +"%s") && echo "Run time: $((endTime-startTime)) seconds..."

  elif [[  "${localCDN80}" == "200" ] || [ "${cloudCDN}" != "217.150.247.87"  ]]; then

    startTime=$(date +"%s")

    echo "CDN resolves to a local IP. Continuing..."

    if [[ "${osvers}" -eq 9 ]]; then
      echo "Upgrading Numbers for Mavericks"
      /usr/local/bin/aky numbers1009
    fi

    if [[ "${osvers}" -eq 10 ]]; then
      echo "Upgrading Numbers for Yosemite"
      /usr/local/bin/aky numbers1010
    fi

    if [[ "${osvers}" -eq 11 ]]; then
      echo "Upgrading Numbers for El Capitain"
      /usr/local/bin/aky numbers1011
    fi

    if [[ "${osvers}" -eq 12 ]]; then
      echo "Upgrading Numbers for Sierra"
      /usr/local/bin/aky numbers1012
    fi

    if [[ "${osvers}" -eq 13 ]]; then
      echo "Upgrading Numbers for High Sierra"
      /usr/local/bin/aky numbers1013
    fi

    endTime=$(date +"%s") && echo "Run time: $((endTime-startTime)) seconds..."

  else

    echo "No local CDN detected, exiting..." && exit 0

  fi