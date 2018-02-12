#!/bin/bash

  localCDN8080=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch:8080/CasperShare/HTTPCODE" -o /dev/null)
  localCDN80=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch/CasperShare/HTTPCODE" -o /dev/null)
  cloudCDN=$(/usr/bin/host cdn.anykeyit.ch | /usr/bin/awk '{print $NF}')
  
  osvers=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')

  if [ "${localCDN8080}" == "200" ] && [ "${cloudCDN}" != "217.150.247.87" ]; then

    echo "CDN resolves to a local IP. Continuing..."
    
    if [ "${osvers}" -eq 9 ]; then
      echo "Upgrading Keynote for Mavericks"
      /usr/local/bin/aky keynote10098080
    fi

    if [ "${osvers}" -eq 10 ]; then
      echo "Upgrading Keynote for Yosemite"
      /usr/local/bin/aky keynote10108080
    fi

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading Keynote for El Capitain"
      /usr/local/bin/aky keynote10118080
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading Keynote for Sierra"
      /usr/local/bin/aky keynote10128080
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading Keynote for High Sierra"
      /usr/local/bin/aky keynote10138080
    fi

  elif [ "${localCDN80}" == "200" ] && [ "${cloudCDN}" != "217.150.247.87" ]; then

    echo "CDN resolves to a local IP. Continuing..."

    if [ "${osvers}" -eq 9 ]; then
      echo "Upgrading Keynote for Mavericks"
      /usr/local/bin/aky keynote1009
    fi

    if [ "${osvers}" -eq 10 ]; then
      echo "Upgrading Keynote for Yosemite"
      /usr/local/bin/aky keynote1010
    fi

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading Keynote for El Capitain"
      /usr/local/bin/aky keynote1011
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading Keynote for Sierra"
      /usr/local/bin/aky keynote1012
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading Keynote for High Sierra"
      /usr/local/bin/aky keynote1013
    fi

  else

    echo "No local CDN detected, exiting..." && exit 0

  fi