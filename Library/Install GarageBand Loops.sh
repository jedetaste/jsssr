#!/bin/bash

  # Download mandatory content only
  
  "/usr/local/bin/appleLoops" --deployment --mandatory-only
  
  # Download optional content only if argument == optional
  
  if [ "${1}" == "optional" ]; then
    "/usr/local/bin/appleLoops" --deployment --optional-only
  fi