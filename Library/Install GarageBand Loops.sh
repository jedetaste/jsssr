#!/bin/bash

  if [ -s "/Applications/GarageBand.app" ]; then

    echo "==> GarageBand.app is installed"

    # String handling for GarageBand version

    garageband_version=$(/usr/bin/mdls "/Applications/GarageBand.app" -name kMDItemVersion | awk -F'"' '{print $2}')

    garageband_version_major=$(echo ${garageband_version} | cut -d. -f1)
    garageband_version_minor=$(echo ${garageband_version} | cut -d. -f2)
    garageband_version_revision=$(echo ${garageband_version} | cut -d. -f3)

    echo "==> GarageBand.app is version '${garageband_version}'"

    # String handling for required version

    required_version="10.1.1"

    required_version_major=$(echo ${required_version} | cut -d. -f1)
    required_version_minor=$(echo ${required_version} | cut -d. -f2)
    required_version_revision=$(echo ${required_version} | cut -d. -f3)

    echo "==> Required version is '${required_version}'"

    echo "==> Search for local caching server"

    if [ ! -z $(AssetCacheLocatorUtil 2>&1 | awk '/guid / { gsub(",", "", $4); print $4}' | uniq) ]; then
        caching_server=$(AssetCacheLocatorUtil 2>&1 | awk '/guid / { gsub(",", "", $4); print $4}' | uniq)
        echo "==> Found local caching server at '${caching_server}'"
    fi

    # Check if scripts is executable

    if [ ${garageband_version_major} -ge ${required_version_major} ]; then

      if [ ${garageband_version_minor} -ge ${required_version_minor} ]; then

        echo "==> GarageBand.app has the required version"

        # Download mandatory content only

        if [ ! -z "${caching_server}" ]; then
            "/usr/local/bin/appleLoops" --deployment --mandatory-only --cache-server "http://${caching_server}"
        else
            "/usr/local/bin/appleLoops" --deployment --mandatory-only
        fi

        # Download optional content only if argument == optional

        if [ ! -z "${caching_server}" ]; then
            "/usr/local/bin/appleLoops" --deployment --optional-only --cache-server "http://${caching_server}"
        else
            "/usr/local/bin/appleLoops" --deployment --optional-only
        fi

      else

        echo "==> GarageBand.app has not the required version"

      fi

    fi

  else

    echo "==> GarageBand.app is not installed"

  fi