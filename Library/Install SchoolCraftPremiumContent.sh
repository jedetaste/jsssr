#!/bin/bash

  tmpDir=$(/usr/local/bin/tmpDir)

  echo "==> Download 'https://www.hidrive.strato.com/wget/TpAqjsrr'"
  curl -s -o "${tmpDir}/SchoolCraftPremiumContent.pkg" "https://www.hidrive.strato.com/wget/TpAqjsrr"

  if [ -s "${tmpDir}/SchoolCraftPremiumContent.pkg" ]; then

    echo "==> Prepare '${tmpDir}/SchoolCraftPremiumContent.pkg'"
    pkgutil --expand "${tmpDir}/SchoolCraftPremiumContent.pkg" "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg"

    cat > "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg/SchoolCraftPremiumContent.pkg/Scripts/postinstall" <<EOF
#!/bin/sh
exit 0
EOF

    pkgutil --flatten "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg" "${tmpDir}/SchoolCraftPremiumContent-flatten.pkg"

    echo "==> Install '${tmpDir}/SchoolCraftPremiumContent-flatten.pkg'"
    installer -pkg "${tmpDir}/SchoolCraftPremiumContent-flatten.pkg" -target /

    mkdir -p "/Library/Application Support/WorksheetCrafter"

    if [ -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" ]; then
      rm -rf "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    fi

    mv "/private/tmp/SchoolCraft Premium Content.bundle" "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"

    for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
      if [ -s "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
        rm -rf "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle"
      elif [ ! -s "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
        echo "==> Symlink '/Users/${user}/Pictures/SchoolCraft Premium Content.bundle'"
        ln -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" "/Users/${user}/Pictures"
      fi
    done

  fi

  rm -rf "${tmpDir}"