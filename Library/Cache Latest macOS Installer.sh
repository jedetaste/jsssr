#!/bin/bash
# shellcheck disable=SC2071

if [[ "$(sw_vers -buildVersion)" > "20" ]]; then
  echo "=> Mac is running Darwin $(sw_vers -buildVersion)"
  echo "Error: This Mac seems to run a beta of macOS" && exit 0
elif [[ "$(sw_vers -buildVersion)" < "17" ]]; then
  echo "=> Mac is running Darwin $(sw_vers -buildVersion)"
  /usr/local/bin/erase-install --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog --update --os=10.15
else
  echo "=> Mac is running Darwin $(sw_vers -buildVersion)"
  /usr/local/bin/erase-install --update --os=11.0
fi
