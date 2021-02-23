#!/bin/bash
# shellcheck disable=SC2071

if [[ "$(sw_vers -buildVersion)" > "18" ]]; then

  echo "=> Reset the printing system..."
  /System/Library/Frameworks/ApplicationServices.framework/Frameworks/PrintCore.framework/Versions/A/printtool --reset -f

else

  for file in /etc/cups/ppd/*; do
    path="${file%.ppd}"
    name="${path##*/}"
    echo "=> Remove printer '${name}'"
    lpadmin -x "${name}"
  done

fi
