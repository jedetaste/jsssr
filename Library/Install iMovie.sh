#!/bin/bash

  localCDN8080=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch:8080" -o /dev/null)
  localCDN80=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch" -o /dev/null)
  cloudCDN=$(/usr/bin/host cdn.anykeyit.ch | /usr/bin/awk '{print $NF}')
  
  osvers=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')

  if [ "${localCDN8080}" == "200" ]; then

    startTime=$(date +"%s")

    echo "CDN resolves to a local IP. Continuing..."

    if [ "${osvers}" -eq 9 ]; then
      echo "Upgrading iMovie for Mavericks"
      /usr/local/bin/aky imovie10098080
    fi

    if [ "${osvers}" -eq 10 ]; then
      echo "Upgrading iMovie for Yosemite"
      /usr/local/bin/aky imovie10108080
    fi

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading iMovie for El Capitain"
      /usr/local/bin/aky imovie10118080
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading iMovie for Sierra"
      /usr/local/bin/aky imovie10128080
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading iMovie for High Sierra"
      /usr/local/bin/aky imovie10138080
    fi

    endTime=$(date +"%s") && echo "Run time: $((endTime-startTime)) seconds..."

  elif [ "${localCDN80}" == "200" ] || [ "${cloudCDN}" != "217.150.247.87"  ]; then

    startTime=$(date +"%s")

    echo "CDN resolves to a local IP. Continuing..."

    if [ "${osvers}" -eq 9 ]; then
      echo "Upgrading iMovie for Mavericks"
      /usr/local/bin/aky imovie1009
    fi

    if [ "${osvers}" -eq 10 ]; then
      echo "Upgrading iMovie for Yosemite"
      /usr/local/bin/aky imovie1010
    fi

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading iMovie for El Capitain"
      /usr/local/bin/aky imovie1011
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading iMovie for Sierra"
      /usr/local/bin/aky imovie1012
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading iMovie for High Sierra"
      /usr/local/bin/aky imovie1013
    fi

    endTime=$(date +"%s") && echo "Run time: $((endTime-startTime)) seconds..."

  else

    echo "No local CDN detected, exiting..." && exit 0

  fi