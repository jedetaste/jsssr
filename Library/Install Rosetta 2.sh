#!/bin/bash

if [ "$(/usr/bin/arch)" = "arm64" ]; then
  echo "=> This Mac runs on Apple Silicon, installing Rosetta..."
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
elif [ "$(/usr/bin/arch)" = "i386" ]; then
  echo "=> This Mac runs on Intel"
else
  echo "=> Unknown architecture"
fi
