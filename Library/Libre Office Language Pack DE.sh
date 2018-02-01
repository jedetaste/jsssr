#!/bin/bash
  
  tmp="/private/tmp/libreoffice"
  /bin/mkdir -p "${tmp}"
  
  language="de"
  version="6.0.3"
  
  cd "${tmp}" && /usr/bin/curl -# -O -J -L "http://download.documentfoundation.org/libreoffice/stable/${version}/mac/x86_64/LibreOffice_${version}_MacOS_x86-64_langpack_${language}.dmg" && cd
  
  dldmg=$(find "${tmp}" -name "*.dmg" -execdir echo '{}' ';' -print | sed -n 1p)
  
  volume=$(hdiutil attach -noautoopen -noverify -nobrowse "${tmp}/${dldmg}" | egrep "Volumes" | grep -o "/Volumes/.*")
  
  sleep 2
  
  if [ -s "/Applications/LibreOffice.app" ]; then
    
    /usr/bin/tar -C "/Applications/LibreOffice.app/" -xjf "${volume}/LibreOffice Language Pack.app/Contents/tarball.tar.bz2"
    /usr/bin/touch "/Applications/LibreOffice.app/Contents/Resources/extensions"
    
  else
    
    /usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volume}" | awk '{print $1}') -quiet -force
    /bin/rm -rf "${tmp}"
    echo "LibreOffice not installed" && exit 1
    
  fi
  
  /usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volume}" | awk '{print $1}') -quiet -force
  /bin/rm -rf "${tmp}"

exit 0