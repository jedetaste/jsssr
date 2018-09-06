#!/bin/bash
  
  function checkAvailableASU() {
    /usr/sbin/softwareupdate --reset-ignored
    /usr/sbin/softwareupdate --list
  }
  
  function downloadASU () {
    /usr/sbin/softwareupdate --download --all
  }
  
  function checkRestartASU() {
    /usr/sbin/softwareupdate --reset-ignored
    /usr/sbin/softwareupdate --list
  }
  
  function notificationUser() {
    
    currentuser=$(/usr/local/bin/currentuser)
    userLanguage=$(/usr/bin/defaults read "/Users/${currentuser}/Library/Preferences/.GlobalPreferences" AppleLanguages 2>/dev/null)
    
    case "${userLanguage}" in 
      *en-US*|*en-CH*|*en-IN*|*en-IE*|*en-CA*|*en-NZ*|*en-SG*|*en-ZA*|*en-GB*)
        userLanguageEnglish="true" ;;
    esac
    
    if [ "${userLanguageEnglish}" == "true" ]; then
      su -l "${currentuser}" -c "'/usr/local/bin/alerter' -title 'Apple Software Update' -message 'Install new updates and restart now?' -actions 'Yes' -closeLabel 'No' -sender 'com.apple.dt.CommandLineTools.installondemand'"
    fi
    
    case "${userLanguage}" in 
      *de*|*de-CH*|*de-DE*|*de-AT*)
        userLanguageGerman="true" ;;
    esac
    
    if [ "${userLanguageGerman}" == "true" ]; then
      su -l "${currentuser}" -c "'/usr/local/bin/alerter' -title 'Apple Software Update' -message 'Neue Updates jetzt installieren und neu starten?' -actions 'Ja' -closeLabel 'Nein' -sender 'com.apple.dt.CommandLineTools.installondemand'"
    fi
    
    case "${userLanguage}" in 
      *fr*|*fr-CH*|*fr-BE*|*fr-FR*|*fr-CA*)
        userLanguageFrench="true" ;;
    esac
    
    if [ "${userLanguageFrench}" == "true" ]; then
      su -l "${currentuser}" -c "'/usr/local/bin/alerter' -title 'Apple Software Update' -message 'Installer et redémarrer les mises à jour maintenant?' -actions 'Oui' -closeLabel 'Non' -sender 'com.apple.dt.CommandLineTools.installondemand'"
    fi
    
  }
  
  function runASU() {
    /usr/sbin/softwareupdate --install --all
  }
  
  checkAvailableASUResult=$(checkAvailableASU)
  
  if [[ ${checkAvailableASUResult} != *"No new software available"* ]]; then
    
    echo "==> Download ASU for caching"
    downloadASU
    
    echo "==> Check if ASU requires a restart"
    checkRestartASUResult=$(checkRestartASU)
    
    if [[ ${checkRestartASUResult} = *"restart"* || ${checkRestartASUResult} = *"shut down"* ]]; then
      
      if [ ! -z "$(/usr/local/bin/currentuser)" ]; then
        
        notificationUserResult=$(notificationUser)
        
        if [ "${notificationUserResult}" == "Yes" ] || [ "${notificationUserResult}" == "Ja" ] || [ "${notificationUserResult}" == "Oui" ]; then
          
          echo "==> Install ASU"
          
          currentuser=$(/usr/local/bin/currentuser)
          userLanguage=$(/usr/bin/defaults read "/Users/${currentuser}/Library/Preferences/.GlobalPreferences" AppleLanguages 2>/dev/null)
          
          case "${userLanguage}" in 
            *en-US*|*en-CH*|*en-IN*|*en-IE*|*en-CA*|*en-NZ*|*en-SG*|*en-ZA*|*en-GB*)
              userLanguageEnglish="true" ;;
          esac
          
          if [ "${userLanguageEnglish}" == "true" ]; then
            heading="Apple Software Update"
            description="This Update will take approximately 5-10 Minutes.
            
            After initiating your Mac will reboot and start the update process, please do not interrupt it."
            icon="/System/Library/CoreServices/Install Command Line Developer Tools.app/Contents/Resources/SoftwareUpdate.icns"
            jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
            
            "${jamfHelper}" \
              -windowType fs \
              -title "" \
              -icon "${icon}" \
              -heading "${heading}" \
              -description "${description}" &
              
          fi
          
          case "${userLanguage}" in 
            *de*|*de-CH*|*de-DE*|*de-AT*)
              userLanguageGerman="true" ;;
          esac
          
          if [ "${userLanguageGerman}" == "true" ]; then
            heading="Apple Software Update"
            description="Dieser Prozess benötigt ungefähr 5-10 Minuten.
            
            Der Mac startet anschliessend neu und beginnt mit dem Update."
            icon="/System/Library/CoreServices/Install Command Line Developer Tools.app/Contents/Resources/SoftwareUpdate.icns"
            jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
            
            "${jamfHelper}" \
              -windowType fs \
              -title "" \
              -icon "${icon}" \
              -heading "${heading}" \
              -description "${description}" &
              
          fi
          
          case "${userLanguage}" in 
            *fr*|*fr-CH*|*fr-BE*|*fr-FR*|*fr-CA*)
              userLanguageFrench="true" ;;
          esac
          
          if [ "${userLanguageFrench}" == "true" ]; then
            heading="Apple Software Update"
            description="Ce processus prend environ 5-10 minutes.
            
            Le Mac redémarre par la suite et commence la mise à jour."
            icon="/System/Library/CoreServices/Install Command Line Developer Tools.app/Contents/Resources/SoftwareUpdate.icns"
            jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
            
            "${jamfHelper}" \
              -windowType fs \
              -title "" \
              -icon "${icon}" \
              -heading "${heading}" \
              -description "${description}" &
              
          fi
          
          runASU && /usr/local/bin/jamf policy -event "anykey IT ASU Restart" && exit 0
          
        else
          echo "==> User said no to ASU" && exit 0
        fi
        
      elif [ -z "$(/usr/local/bin/currentuser)" ]; then
        runASU && /usr/local/bin/jamf policy -event "anykey IT ASU Restart" && exit 0
      fi
      
    elif [[ ${checkRestartASUResult} != *"restart"* || ${checkRestartASUResult} != *"shut down"* ]]; then
      echo "==> Install ASU, as no restart is required"
      runASU && exit 0
    fi
    
  elif [[ ${checkAvailableASUResult} = *"No new software available"* ]]; then
    echo "==> There is no ASU available" && exit 0
  fi