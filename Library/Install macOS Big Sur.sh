#!/bin/bash
# shellcheck disable=SC2071

installer_version="11.0"

if [[ "$(sw_vers -buildVersion)" < "15" ]]; then
  echo "Error: Please run upgrade manually, as macOS Upgrade from OS X 10.10 or less is not supported" && exit 1
fi

if [ -s "/usr/local/bin/erase-install" ]; then

  [ -d "/Applications/Install macOS Catalina.app" ] && rm -rf "/Applications/Install macOS Catalina.app"
  [ -d "/Applications/Install macOS Mojave.app" ] && rm -rf "/Applications/Install macOS Mojave.app"
  [ -d "/Applications/Install macOS High Sierra.app" ] && rm -rf "/Applications/Install macOS High Sierra.app"
  [ -d "/Applications/Install macOS Sierra.app" ] && rm -rf "/Applications/Install macOS Sierra.app"

  if [[ "$(sw_vers -buildVersion)" < "17" ]]; then

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

  else

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version}

  fi

else
  echo "Binary 'erase-install' not found." && exit 1
fi
