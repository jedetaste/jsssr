#!/bin/bash

  echo "Reset MCX for user '$(/usr/local/bin/currentuser)'"

  /usr/bin/dscl . -delete "/Users/$(/usr/local/bin/currentuser)" dsAttrTypeStandard:MCXSettings
  /usr/bin/dscl . -delete "/Users/$(/usr/local/bin/currentuser)" dsAttrTypeStandard:MCXFlags