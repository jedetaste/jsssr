#!/bin/bash
  
  # appleLoops
  
  /usr/bin/curl -sfko "/usr/local/bin/appleLoops" "https://raw.githubusercontent.com/carlashley/appleLoops/master/appleLoops.py"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/appleLoops"
  /bin/chmod 775 "/usr/local/bin/appleLoops"
  /bin/chmod +x "/usr/local/bin/appleLoops"
  
  # dockutil
  
  /usr/bin/curl -sfko "/usr/local/bin/dockutil" "https://github.com/kcrawford/dockutil/blob/master/scripts/dockutil"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/dockutil"
  /bin/chmod 775 "/usr/local/bin/dockutil"
  /bin/chmod +x "/usr/local/bin/dockutil"