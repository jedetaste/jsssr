#!/bin/bash
  
  if [ ! -s "/Applications/LehrerOffice/LehrerOffice.app" ]; then
    echo "LehrerOffice is not installed" && exit 0
  fi
  
  LOINIPath="/Applications/LehrerOffice/LehrerOffice.ini"
  LOBundlePath="/Applications/LehrerOffice/LehrerOffice.app"
  LOVersion=$(/usr/bin/defaults read "${LOBundlePath}/Contents/Info.plist" CFBundleShortVersionString)
  
  if [ ! -z "${1}" ]; then
    LHDPathArg="${1}"
  fi
  
  if [ ! -z "${1}" ]; then
    
    if [ -s "${LOINIPath}" ]; then
      rm -f "${LOINIPath}"
    fi
    
    echo "[application]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "version=${LOVersion}" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "env=1" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "data=2" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[update]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "multi=0" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[system]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "open=%Programm%:${LHDPathArg}.lhd" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[userdlg]" >> "${LOINIPath}"
    
  elif [ -z "${1}" ]; then
    
    if [ -s "${LOINIPath}" ]; then
      rm -f "${LOINIPath}"
    fi
    
    echo "[application]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "version=${LOVersion}" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "env=1" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "data=2" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[update]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "multi=0" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[system]" >> "${LOINIPath}"
    echo >> "${LOINIPath}"
    echo "[userdlg]" >> "${LOINIPath}"
    
  fi
