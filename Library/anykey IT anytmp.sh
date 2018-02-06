#!/bin/bash

  creationdate=$(date +%Y-%m-%d--%H-%M-%S)
  
  # Move .anytmp to tmp
  
  if [ -d "/.anytmp" ]; then
    /bin/mv "/.anytmp" "/tmp/.anytmp_${creationdate}"
  fi
  
  # Create directory .anytmp
  
  /bin/mkdir - "/.anytmp"
  /usr/sbin/chown -R root:wheel "/.anytmp"
  /bin/chmod -R 770 "/.anytmp"
  
  # Move deleted home directories to .anytmp
  
  /bin/mv "/Library/geloeschteHomes" "/.anytmp/"