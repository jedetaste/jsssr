#!/bin/bash

if [ "$(/usr/bin/arch)" = "arm64" ]; then
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi
