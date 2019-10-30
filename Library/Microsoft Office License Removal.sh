#!/bin/bash

curl \
  -s \
  -L \
  -o "/tmp/Microsoft_Office_License_Removal.pkg" \
  "https://go.microsoft.com/fwlink/?linkid=849815"

installer -pkg "/tmp/Microsoft_Office_License_Removal.pkg" -target /

rm -rf "/tmp/Microsoft_Office_License_Removal.pkg"
