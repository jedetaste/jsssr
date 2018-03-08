#!/bin/bash
  
  # appleLoops
  
  echo "==> Install 'appleLoops'"
  
  if [ -s "/usr/local/bin/appleLoops" ]; then
    rm -f "/usr/local/bin/appleLoops"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/appleLoops" "https://raw.githubusercontent.com/carlashley/appleLoops/master/appleLoops.py"

  /usr/sbin/chown root:wheel "/usr/local/bin/appleLoops"
  /bin/chmod 775 "/usr/local/bin/appleLoops"
  /bin/chmod +x "/usr/local/bin/appleLoops"

  # dockutil
  
  echo "==> Install 'dockutil'"
  
  if [ -s "/usr/local/bin/dockutil" ]; then
    rm -f "/usr/local/bin/dockutil"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/dockutil" "https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil"

  /usr/sbin/chown root:wheel "/usr/local/bin/dockutil"
  /bin/chmod 775 "/usr/local/bin/dockutil"
  /bin/chmod +x "/usr/local/bin/dockutil"
  
  # currentuser
  
  echo "==> Install 'currentuser'"
  
  if [ -s "/usr/local/bin/currentuser" ]; then
    rm -f "/usr/local/bin/currentuser"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/currentuser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/currentuser"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/currentuser"
  /bin/chmod 775 "/usr/local/bin/currentuser"
  /bin/chmod +x "/usr/local/bin/currentuser"
  
  # csc
  
  echo "==> Install 'csc'"
  
  if [ -s "/usr/local/bin/csc" ]; then
    rm -f "/usr/local/bin/csc"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/csc" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/csc"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/csc"
  /bin/chmod 775 "/usr/local/bin/csc"
  /bin/chmod +x "/usr/local/bin/csc"
  
  # defaultbrowser
  
  echo "==> Install 'defaultbrowser'"
  
  if [ -s "/usr/local/bin/defaultbrowser" ]; then
    rm -f "/usr/local/bin/defaultbrowser"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/defaultbrowser" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/defaultbrowser"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/defaultbrowser"
  /bin/chmod 775 "/usr/local/bin/defaultbrowser"
  /bin/chmod +x "/usr/local/bin/defaultbrowser"
  
  # mysides
  
  echo "==> Install 'mysides'"
  
  if [ -s "/usr/local/bin/mysides" ]; then
    rm -f "/usr/local/bin/mysides"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/mysides" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/mysides"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/mysides"
  /bin/chmod 775 "/usr/local/bin/mysides"
  /bin/chmod +x "/usr/local/bin/mysides"
  
  # pkgfixer
  
  echo "==> Install 'pkgfixer'"
  
  if [ -s "/usr/local/bin/pkgfixer" ]; then
    rm -f "/usr/local/bin/pkgfixer"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/pkgfixer" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/pkgfixer"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/pkgfixer"
  /bin/chmod 775 "/usr/local/bin/pkgfixer"
  /bin/chmod +x "/usr/local/bin/pkgfixer"
  
  # blueutil
  
  echo "==> Install 'blueutil'"
  
  if [ -s "/usr/local/bin/blueutil" ]; then
    rm -f "/usr/local/bin/blueutil"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/blueutil" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/blueutil"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/blueutil"
  /bin/chmod 775 "/usr/local/bin/blueutil"
  /bin/chmod +x "/usr/local/bin/blueutil"
  
  # rg
  
  echo "==> Install 'rg'"
  
  if [ -s "/usr/local/bin/rg" ]; then
    rm -f "/usr/local/bin/rg"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/rg" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/rg"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/rg"
  /bin/chmod 775 "/usr/local/bin/rg"
  /bin/chmod +x "/usr/local/bin/rg"
  
  # jq
  
  echo "==> Install 'jq'"
  
  if [ -s "/usr/local/bin/jq" ]; then
    rm -f "/usr/local/bin/jq"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/jq" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/jq"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/jq"
  /bin/chmod 775 "/usr/local/bin/jq"
  /bin/chmod +x "/usr/local/bin/jq"
  
  # aky
  
  echo "==> Install 'aky'"
  
  if [ ! -d "/usr/local/aky" ]; then
    /bin/mkdir -p "/usr/local/aky"
  fi
  
  akyBinary=(
    "aky"
    "download-helper"
    "install-helper"
    "mas-helper"
    "notification-helper"
    "rg"
    "versioning-helper"
  )
  
  for ((i = 0; i < "${#akyBinary[@]}"; i++)); do
    
    /bin/rm -f "/usr/local/bin/${akyBinary[$i]}"
    /bin/rm -f "/usr/local/aky/${akyBinary[$i]}"
    /usr/bin/curl -sfko "/usr/local/aky/${akyBinary[$i]}" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/${akyBinary[$i]}"
    /usr/sbin/chown root:wheel "/usr/local/aky/${akyBinary[$i]}"
    /bin/chmod +x "/usr/local/aky/${akyBinary[$i]}"
    /bin/ln -s "/usr/local/aky/${akyBinary[$i]}" "/usr/local/bin/${akyBinary[$i]}"
    
  done
  
  # Remove2011
  
  echo "==> Install 'Remove2011'"
  
  if [ -s "/usr/local/bin/Remove2011" ]; then
    rm -f "/usr/local/bin/Remove2011"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/Remove2011" "https://raw.githubusercontent.com/pbowden-msft/Remove2011/master/Remove2011"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/Remove2011"
  /bin/chmod 775 "/usr/local/bin/Remove2011"
  /bin/chmod +x "/usr/local/bin/Remove2011"
  
  # adobe_prtk
  
  echo "==> Install 'adobe_prtk'"
  
  if [ -s "/usr/local/bin/adobe_prtk" ]; then
    rm -f "/usr/local/bin/adobe_prtk"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/adobe_prtk" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/adobe_prtk"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/adobe_prtk"
  /bin/chmod 775 "/usr/local/bin/adobe_prtk"
  /bin/chmod +x "/usr/local/bin/adobe_prtk"
  
  # AppStoreXtractor
  
  echo "==> Install 'AppStoreXtractor'"
  
  if [ -s "/usr/local/bin/AppStoreXtractor" ]; then
    rm -f "/usr/local/bin/AppStoreXtractor"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/AppStoreXtractor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/AppStoreXtractor"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/AppStoreXtractor"
  /bin/chmod 775 "/usr/local/bin/AppStoreXtractor"
  /bin/chmod +x "/usr/local/bin/AppStoreXtractor"
  
  # outset
  
  echo "==> Install 'outset'"
  
  outsetVersion="2.0.6"
  
  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(/usr/bin/openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && /bin/mkdir -p "${tmpDir}"
  
  cd "${tmpDir}" && /usr/bin/curl -s -O -J -L "https://github.com/chilcote/outset/releases/download/v${outsetVersion}/outset-${outsetVersion}.pkg"
  
  /usr/sbin/installer -pkg "${tmpDir}/outset-${outsetVersion}.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"
  
  # offset
  
  echo "==> Install 'offset'"
  
  offsetVersion="1.2.0"
  
  tmpFolder=$(getconf DARWIN_USER_CACHE_DIR) && randString=$(/usr/bin/openssl rand -hex 5) && tmpDir="${tmpFolder}${randString}" && /bin/mkdir -p "${tmpDir}"
  
  cd "${tmpDir}" && /usr/bin/curl -s -O -J -L "https://github.com/aysiu/offset/releases/download/${offsetVersion}/Offset.pkg"
  
  /usr/sbin/installer -pkg "${tmpDir}/Offset.pkg" -target / > /dev/null 2>&1 && rm -rf "${tmpDir}"
  
  # SafariBookmarkEditor
  
  echo "==> Install 'SafariBookmarkEditor'"
  
  if [ -s "/usr/local/bin/SafariBookmarkEditor" ]; then
    rm -f "/usr/local/bin/SafariBookmarkEditor"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/SafariBookmarkEditor" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/SafariBookmarkEditor"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/SafariBookmarkEditor"
  /bin/chmod 775 "/usr/local/bin/SafariBookmarkEditor"
  /bin/chmod +x "/usr/local/bin/SafariBookmarkEditor"
  
  # FinderSidebarEditor
  
  echo "==> Install 'FinderSidebarEditor'"
  
  if [ -s "/usr/local/bin/FinderSidebarEditor" ]; then
    rm -f "/usr/local/bin/FinderSidebarEditor"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/FinderSidebarEditor" "https://raw.githubusercontent.com/robperc/FinderSidebarEditor/master/FinderSidebarEditor.py"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/FinderSidebarEditor"
  /bin/chmod 775 "/usr/local/bin/FinderSidebarEditor"
  /bin/chmod +x "/usr/local/bin/FinderSidebarEditor"
  
  # duti
  
  echo "==> Install 'duti'"
  
  if [ -s "/usr/local/bin/duti" ]; then
    rm -f "/usr/local/bin/duti"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/duti" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/duti"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/duti"
  /bin/chmod 775 "/usr/local/bin/duti"
  /bin/chmod +x "/usr/local/bin/duti"
  
  # mas
  
  echo "==> Install 'mas'"
  
  if [ -s "/usr/local/bin/mas" ]; then
    rm -f "/usr/local/bin/mas"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/mas" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/mas"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/mas"
  /bin/chmod 775 "/usr/local/bin/mas"
  /bin/chmod +x "/usr/local/bin/mas"
  
  # reattach-to-user-namespace
  
  echo "==> Install 'reattach-to-user-namespace'"
  
  if [ -s "/usr/local/bin/reattach-to-user-namespace" ]; then
    rm -f "/usr/local/bin/reattach-to-user-namespace"
  fi
  
  /usr/bin/curl -sfko "/usr/local/bin/reattach-to-user-namespace" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/reattach-to-user-namespace"
  
  /usr/sbin/chown root:wheel "/usr/local/bin/reattach-to-user-namespace"
  /bin/chmod 775 "/usr/local/bin/reattach-to-user-namespace"
  /bin/chmod +x "/usr/local/bin/reattach-to-user-namespace"