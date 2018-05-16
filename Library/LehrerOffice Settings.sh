#!/bin/bash
  
  if [ ! -s "/Applications/LehrerOffice/LehrerOffice.app" ]; then
    echo "LehrerOffice is not installed" && exit 0
  fi
  
  LOINIpath="/Applications/LehrerOffice/LehrerOffice.ini"
  LOBundlePath="/Applications/LehrerOffice/LehrerOffice.app"
  LOVersion=$(/usr/bin/defaults read "${LOBundlePath}/Contents/Info.plist" CFBundleShortVersionString)
  
  if [ ! -z "${1}" ]; then
    LHDPathArg="${1}"
  fi
  
  if [ ! -z "${1}" ]; then
    
    if [ -s "${LOINIpath}" ]; then
      rm -f "${LOINIpath}"
    fi
    
    echo "[application]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "version=${LOVersion}" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "env=1" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "data=2" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[update]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "multi=0" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[system]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "open=%Programm%:${LHDPathArg}.lhd" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[userdlg]" >> "${LOINIpath}"
    
  elif [ -z "${1}" ]; then
    
    if [ -s "${LOINIpath}" ]; then
      rm -f "${LOINIpath}"
    fi
    
    echo "[application]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "version=${LOVersion}" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "env=1" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "data=2" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[update]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "multi=0" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[system]" >> "${LOINIpath}"
    echo >> "${LOINIpath}"
    echo "[userdlg]" >> "${LOINIpath}"
    
  fi