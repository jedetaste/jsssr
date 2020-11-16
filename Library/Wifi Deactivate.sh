#!/bin/bash

ACTIVEIF=$(netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $6 }')
WIFIIF=$(networksetup -listallhardwareports | grep -A 1 Wi-Fi | awk '/Device/{ print $2 }')
WIFIPWR=$(networksetup -getairportpower "${WIFIIF}" | sed 's/Wi-Fi Power.*: //g')

if [ "${ACTIVEIF}" == "${WIFIIF}" ]; then
  exit 0
else
  if [ ! "${WIFIPWR}" = "On" ]; then
    exit 0
  else
    networksetup -setairportpower "${WIFIIF}" Off
  fi
fi
