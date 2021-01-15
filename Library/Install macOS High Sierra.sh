#!/bin/bash
# shellcheck disable=SC2071

recon_after_upgrade() {

  jamf scheduledTask \
    -command "/Library/Scripts/run_recon.sh" \
    -name "reconreboot" \
    -minute "*/5/"

  cat >"/Library/Scripts/run_recon.sh" <<EOF
#!/bin/bash

if /usr/local/bin/jamf checkJSSConnection -retry 2; then

  /usr/local/bin/jamf policy -event updateinventory

  launchctl unload "/Library/LaunchDaemons/com.jamfsoftware.task.reconreboot.plist"

  sleep 5

  rm -f "/Library/LaunchDaemons/com.jamfsoftware.task.reconreboot.plist"
  rm -f "/Library/Scripts/run_recon.sh"

  exit 0

fi

else
  exit 1
fi
EOF

  chmod +x "/Library/Scripts/run_recon.sh"

}

installer_version="10.13"

if [[ "$(sw_vers -buildVersion)" < "15" ]]; then
  echo "Error: Please run upgrade manually, as macOS Upgrade from OS X 10.10 or less is not supported" && exit 1
fi

if [ -s "/usr/local/bin/erase-install" ]; then

  [ -d "/Applications/Install macOS Sierra.app" ] && rm -rf "/Applications/Install macOS Sierra.app"

  if [[ "$(sw_vers -buildVersion)" < "17" ]]; then

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --force-curl \
      --os=${installer_version} \
      --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog

    recon_after_upgrade

  else

    softwareupdate --reset-ignored

    /usr/local/bin/erase-install \
      --reinstall \
      --force-curl \
      --os=${installer_version}

    recon_after_upgrade

  fi

else
  echo "Binary 'erase-install' not found." && exit 1
fi
