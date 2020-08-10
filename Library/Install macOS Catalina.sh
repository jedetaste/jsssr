#!/bin/bash
# shellcheck disable=SC2034

IFS='.' read -r os_major os_minor os_revision < <(sw_vers -productVersion)

installer_version="10.15"

if [ "${os_minor}" -lt 11 ]; then
  echo "Error: Please run upgrade manually, as macOS Upgrade from OS X 10.10 or less is not supported"
  exit 1
fi

if [ -s "/usr/local/bin/erase-install" ]; then

  [ -d "/Applications/Install macOS Mojave.app" ] && rm -rf "/Applications/Install macOS Mojave.app"
  [ -d "/Applications/Install macOS High Sierra.app" ] && rm -rf "/Applications/Install macOS High Sierra.app"
  [ -d "/Applications/Install macOS Sierra.app" ] && rm -rf "/Applications/Install macOS Sierra.app"

  if [ "${os_minor}" -lt 13 ]; then

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

  else

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version}

  fi

else
  echo "Binary 'erase-install' not found." && exit 1
fi
