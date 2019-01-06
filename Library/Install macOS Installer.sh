#!/bin/bash
  
  latest_macos="10.14"
  
  if [ -s "/usr/local/bin/erase-install" ]; then
    /usr/local/bin/erase-install --move --version=${latest_macos}
  fi