#!/bin/bash

  localCDN8080=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch:8080" -o /dev/null)
  localCDN80=$(/usr/bin/curl -sL -w "%{http_code}" "http://cdn.anykeyit.ch" -o /dev/null)
  cloudCDN=$(/usr/bin/host cdn.anykeyit.ch | /usr/bin/awk '{print $NF}')
  
  osvers=$(/usr/bin/sw_vers -productVersion | awk -F. '{print $2}')

  if [ "${localCDN8080}" == "200" ] && [ "${cloudCDN}" != "217.150.247.87" ]; then

    echo "CDN resolves to a local IP. Continuing..."

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading iBooks Author for El Capitain"
      /usr/local/bin/aky ibooksauthor10118080
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading iBooks Author for Sierra"
      /usr/local/bin/aky ibooksauthor10128080
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading iBooks Author for High Sierra"
      /usr/local/bin/aky ibooksauthor10138080
    fi

  elif [ "${localCDN80}" == "200" ] && [ "${cloudCDN}" != "217.150.247.87" ]; then

    echo "CDN resolves to a local IP. Continuing..."

    if [ "${osvers}" -eq 11 ]; then
      echo "Upgrading iBooks Author for El Capitain"
      /usr/local/bin/aky ibooksauthor1011
    fi

    if [ "${osvers}" -eq 12 ]; then
      echo "Upgrading iBooks Author for Sierra"
      /usr/local/bin/aky ibooksauthor1012
    fi

    if [ "${osvers}" -eq 13 ]; then
      echo "Upgrading iBooks Author for High Sierra"
      /usr/local/bin/aky ibooksauthor1013
    fi

  else

    echo "No local CDN detected, exiting..." && exit 0

  fi