#!/bin/bash

if [ "$(/usr/bin/arch)" = "arm64" ]; then
    if [[ ! -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; then
      echo "=> This Mac runs on Apple Silicon, installing Rosetta..."
      /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    else 
        echo "Rosetta is already installed. Nothing to do."
    fi

elif [ "$(/usr/bin/arch)" = "i386" ]; then
  echo "=> This Mac runs on Intel"
else
  echo "=> Unknown architecture"
fi
