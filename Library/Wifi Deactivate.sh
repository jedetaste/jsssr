#!/bin/bash

  ACTIVEIF=$(/usr/sbin/netstat -rn 2>&1 | /usr/bin/grep -m 1 'default' | /usr/bin/awk '{ print $6 }')
  WIFIIF=$(/usr/sbin/networksetup -listallhardwareports | grep -A 1 Wi-Fi | awk '/Device/{ print $2 }')
  WIFIPWR=$(/usr/sbin/networksetup -getairportpower $WIFIIF | sed 's/Wi-Fi Power.*: //g')

  if [ "$ACTIVEIF" == "$WIFIIF" ]; then
    exit 0
  else
    if [ "$WIFIPWR" != "On" ]; then
      exit 0
    else
      /usr/sbin/networksetup -setairportpower $WIFIIF Off
    fi
  fi
