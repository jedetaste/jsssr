#!/bin/bash

if [ -d "/Applications/GarageBand.app" ]; then

  echo "=> GarageBand.app is installed"

  if [ -n "$(AssetCacheLocatorUtil 2>&1 | awk '/guid / { gsub(",", "", $4); print $4}' | uniq)" ]; then
    caching_server=$(AssetCacheLocatorUtil 2>&1 | awk '/guid / { gsub(",", "", $4); print $4}' | uniq)
    echo "=> Found local caching server at '${caching_server}'"
  fi

  if [ -n "${caching_server}" ]; then
    if [ "${1}" = "optional" ]; then
      "/usr/local/bin/appleloops" --deployment -m -o --cache-server "http://${caching_server}"
    else
      "/usr/local/bin/appleloops" --deployment -m --cache-server "http://${caching_server}"
    fi
  else
    if [ "${1}" = "optional" ]; then
      "/usr/local/bin/appleloops" --deployment -m -o
    else
      "/usr/local/bin/appleloops" --deployment -m
    fi
  fi

else
  echo "=> GarageBand.app is not installed"
fi
