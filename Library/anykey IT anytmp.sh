#!/bin/bash

  creationdate=$(date +%Y-%m-%d--%H-%M-%S)
  
  # Move .anytmp to tmp
  
  if [ -d "/.anytmp" ]; then
    mv "/.anytmp" "/tmp/.anytmp_${creationdate}"
  fi
  
  # Create directory .anytmp
  
  mkdir - "/.anytmp"
  chown -R root:wheel "/.anytmp"
  chmod -R 770 "/.anytmp"
  
  # Move deleted home directories to .anytmp
  
  mv "/Library/geloeschteHomes" "/.anytmp/"
  
exit 0