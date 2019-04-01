#!/bin/bash

  latest_macos="10.14.4"

  if [ -s "/usr/local/bin/erase-install" ]; then
    /usr/local/bin/erase-install --version=${latest_macos} --move
  fi