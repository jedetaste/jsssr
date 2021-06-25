#!/bin/bash

applications_list=(
  "Pages.app"
  "Numbers.app"
  "Keynote.app"
  "GarageBand.app"
  "iMovie.app"
)

for applications in "${applications_list[@]}"; do
  if [ -s "/Applications/${applications}" ]; then
    if [ "$(mdls -raw -name kMDItemAppStoreHasReceipt /Applications/"${applications}")" == "(null)" ]; then
      echo "==> Remove legacy '/Applications/${applications}'"
      rm -rf "/Applications/${applications}"
    else
      echo "==> Application '/Applications/${applications}' has already an App Store receipt"
    fi
  fi
done

/usr/local/bin/jamf "recon"
