#!/bin/bash

IFS='.' read -r os_major os_minor os_revision < <(sw_vers -productVersion)

installer_name="Catalina"
installer_version="10.15"

if [ "${os_minor}" -lt 11 ]; then
  echo "Error: Please run upgrade manually, as macOS Upgrade from OS X 10.10 or less is not supported"
  exit 1
fi

if [ -s "/usr/local/bin/erase-install" ]; then

  echo "Download and Install 'First_Boot_Recon.pkg'"
  curl -s -o "/tmp/First_Boot_Recon.pkg" "https://cdn-clients.anykeyit.ch/Static/First_Boot_Recon.pkg"

  if [ "${os_minor}" -lt 13 ]; then

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --overwrite \
      --extras=/tmp/First_Boot_Recon.pkg \
      --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

  else

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --os=${installer_version} \
      --overwrite \
      --extras=/tmp/First_Boot_Recon.pkg

  fi

else
  echo "Binary 'erase-install' not found." && exit 1
fi
