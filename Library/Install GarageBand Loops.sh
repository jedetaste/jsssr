#!/bin/bash
  
  if [ -s "/Applications/GarageBand.app" ]; then
    
    # String handling for GarageBand version
    
    garageband_version=$(/usr/bin/mdls "/Applications/GarageBand.app" -name kMDItemVersion | awk -F'"' '{print $2}')
    
    garageband_version_major=$(echo ${garageband_version} | cut -d. -f1)
    garageband_version_minor=$(echo ${garageband_version} | cut -d. -f2)
    garageband_version_revision=$(echo ${garageband_version} | cut -d. -f3)
    
    echo "==> GarageBand.app is version '${garageband_version}'"
    
    # String handling for required version
    
    required_version="10.1.1"
    
    required_version_major=$(echo ${required_version} | cut -d. -f1)
    required_version_minor=$(echo ${required_version} | cut -d. -f2)
    required_version_revision=$(echo ${required_version} | cut -d. -f3)
    
    echo "==> Required version is '${required_version}'"
    
    # Check if scripts is executable
    
    if [ ${garageband_version_major} -ge ${required_version_major} ]; then
      
      if [ ${garageband_version_minor} -ge ${required_version_minor} ]; then
        
        echo "==> GarageBand.app has the required version"
        
        # Download mandatory content only
        
        "/usr/local/bin/appleLoops" --apps garageband --deployment --mandatory-only
        
        # Download optional content only if argument == optional
        
        if [ "${1}" == "optional" ]; then
          "/usr/local/bin/appleLoops" --apps garageband --deployment --optional-only
        fi
        
      else
        
        echo "==> GarageBand.app has not the required version"
        
      fi
      
    fi
    
  fi