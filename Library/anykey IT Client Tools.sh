#!/bin/bash
  
  if [ ! -d "/usr/local/bin" ]; then
    mkdir -p "/usr/local/bin"
  fi
  
  # appleLoops
  
  if [ -s "/usr/local/bin/appleLoops" ]; then
    rm -f "/usr/local/bin/appleLoops"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/appleLoops" "https://raw.githubusercontent.com/carlashley/appleLoops/master/appleLoops.py"

  /usr/sbin/chown root:wheel "/usr/local/bin/appleLoops"
  /bin/chmod 775 "/usr/local/bin/appleLoops"
  /bin/chmod +x "/usr/local/bin/appleLoops"

  # dockutil
  
  if [ -s "/usr/local/bin/dockutil" ]; then
    rm -f "/usr/local/bin/dockutil"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/dockutil" "https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil"

  /usr/sbin/chown root:wheel "/usr/local/bin/dockutil"
  /bin/chmod 775 "/usr/local/bin/dockutil"
  /bin/chmod +x "/usr/local/bin/dockutil"
  
  # currentuser
  
  if [ -s "/usr/local/bin/currentuser" ]; then
    rm -f "/usr/local/bin/currentuser"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/currentuser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/currentuser"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/currentuser"
  /bin/chmod 775 "/usr/local/bin/currentuser"
  /bin/chmod +x "/usr/local/bin/currentuser"
  
  # csc
  
  if [ -s "/usr/local/bin/csc" ]; then
    rm -f "/usr/local/bin/csc"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/csc" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/csc"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/csc"
  /bin/chmod 775 "/usr/local/bin/csc"
  /bin/chmod +x "/usr/local/bin/csc"
  
  # defaultbrowser
  
  if [ -s "/usr/local/bin/defaultbrowser" ]; then
    rm -f "/usr/local/bin/defaultbrowser"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/defaultbrowser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/defaultbrowser"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/defaultbrowser"
  /bin/chmod 775 "/usr/local/bin/defaultbrowser"
  /bin/chmod +x "/usr/local/bin/defaultbrowser"
  
  # mysides
  
  if [ -s "/usr/local/bin/mysides" ]; then
    rm -f "/usr/local/bin/mysides"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/mysides" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/mysides"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/mysides"
  /bin/chmod 775 "/usr/local/bin/mysides"
  /bin/chmod +x "/usr/local/bin/mysides"
  
  # pkgfixer
  
  if [ -s "/usr/local/bin/pkgfixer" ]; then
    rm -f "/usr/local/bin/pkgfixer"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/pkgfixer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/pkgfixer"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/pkgfixer"
  /bin/chmod 775 "/usr/local/bin/pkgfixer"
  /bin/chmod +x "/usr/local/bin/pkgfixer"
  
  # blueutil
  
  if [ -s "/usr/local/bin/blueutil" ]; then
    rm -f "/usr/local/bin/blueutil"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/blueutil" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/blueutil"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/blueutil"
  /bin/chmod 775 "/usr/local/bin/blueutil"
  /bin/chmod +x "/usr/local/bin/blueutil"
  
  # jq
  
  if [ -s "/usr/local/bin/jq" ]; then
  	rm -f "/usr/local/bin/jq"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/jq" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/jq"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/jq"
  /bin/chmod 775 "/usr/local/bin/jq"
  /bin/chmod +x "/usr/local/bin/jq"
  
  # rg
  
  if [ -s "/usr/local/bin/rg" ]; then
  	rm -f "/usr/local/bin/rg"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/rg" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/rg"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/rg"
  /bin/chmod 775 "/usr/local/bin/rg"
  /bin/chmod +x "/usr/local/bin/rg"
  
  # aky
  
  if [ -s "/usr/local/bin/aky" ]; then
  	rm -f "/usr/local/bin/aky"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/aky" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/aky"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/aky"
  /bin/chmod 775 "/usr/local/bin/aky"
  /bin/chmod +x "/usr/local/bin/aky"
  
  # Remove2011
  
  if [ -s "/usr/local/bin/Remove2011" ]; then
  	rm -f "/usr/local/bin/Remove2011"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/Remove2011" "https://raw.githubusercontent.com/pbowden-msft/Remove2011/master/Remove2011"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/Remove2011"
  /bin/chmod 775 "/usr/local/bin/Remove2011"
  /bin/chmod +x "/usr/local/bin/Remove2011"
  
  # adobe_prtk
  
  if [ -s "/usr/local/bin/adobe_prtk" ]; then
  	rm -f "/usr/local/bin/adobe_prtk"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/adobe_prtk" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/adobe_prtk"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/adobe_prtk"
  /bin/chmod 775 "/usr/local/bin/adobe_prtk"
  /bin/chmod +x "/usr/local/bin/adobe_prtk"
  
  # AppStoreXtractor
  
  if [ -s "/usr/local/bin/AppStoreXtractor" ]; then
  	rm -f "/usr/local/bin/AppStoreXtractor"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/AppStoreXtractor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/AppStoreXtractor"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/AppStoreXtractor"
  /bin/chmod 775 "/usr/local/bin/AppStoreXtractor"
  /bin/chmod +x "/usr/local/bin/AppStoreXtractor"
  
  # outset
  
  outsetVersion="2.0.6"
  
  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(/usr/bin/openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && /bin/mkdir -p "${tmpDir}"
  
  cd "${tmpDir}" && /usr/bin/curl -s -O -J -L "https://github.com/chilcote/outset/releases/download/v${outsetVersion}/outset-${outsetVersion}.pkg"
  
  /usr/sbin/installer -pkg "${tmpDir}/outset-${outsetVersion}.pkg" -target / && rm -f "${tmpDir}"