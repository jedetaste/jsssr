#!/bin/bash
  
  readonly progName=$(/usr/bin/basename ${0})
  readonly progVersion="1.0"
  
  if [ -z "${1}" ]; then
    echo "Error: Invalid argument" && exit 1
  fi
  
  URI="${1}"
  
  javaPlugin=$(/usr/bin/defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Info" CFBundleIdentifier)
  
  if [[ "${javaPlugin}" != 'com.oracle.java.JavaAppletPlugin' ]]; then
    echo "Oracle Java browser plug-in not installed"
    exit 1
  else
    
    # User Template
    
    for userTemplate in "/System/Library/User Template"/*; do
      
      ExceptionListUserTemplate="${userTemplate}/Library/Application Support/Oracle/Java/Deployment/security/exception.sites"
      ExceptionListUserTemplatePath="${userTemplate}/Library/Application Support/Oracle/Java/Deployment/security"
      
      /bin/mkdir -p "${ExceptionListUserTemplatePath}" && touch "${ExceptionListUserTemplate}"
      whitelistCheck=$(/bin/cat "${ExceptionListUserTemplate}" | /usr/bin/grep ${URI})
      
      echo "Fill exception list at '${ExceptionListUserTemplate}'"
			echo "${URI}" >> "${ExceptionListUserTemplate}"
      
    done
    
    # Logged In User
    
    ExceptionListUser="/Users/$(/usr/local/bin/currentuser)/Library/Application Support/Oracle/Java/Deployment/security/exception.sites"
    ExceptionListUserPath="/Users/$(/usr/local/bin/currentuser)/Library/Application Support/Oracle/Java/Deployment/security"
    ExceptionListUserBasePath="/Users/$(/usr/local/bin/currentuser)/Library/Application Support/Oracle/Java/Deployment/security"
    
    /bin/mkdir -p "${ExceptionListUserPath}" && touch "${ExceptionListUser}"
    whitelistCheck=$(/bin/cat "${ExceptionListUser}" | /usr/bin/grep ${URI})
    
    echo "Fill exception list at '${ExceptionListUser}'"
		echo "${URI}" >> "${ExceptionListUser}"
    
    chown -R $(/usr/local/bin/currentuser) "${ExceptionListUserBasePath}" && chmod -R 700 "${ExceptionListUserBasePath}"
    
  fi