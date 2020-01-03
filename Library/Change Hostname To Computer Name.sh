#!/bin/bash

if [ -s "/usr/local/jamf/bin/jamf" ]; then
  "/usr/local/jamf/bin/jamf" setComputerName -target / -name "$(scutil --get computer_name)"
fi
