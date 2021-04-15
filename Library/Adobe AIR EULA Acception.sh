#!/bin/bash

# AdobeAIR EULA Acception for existing users

cat <<EOF >"/tmp/stylesheet.xslt"
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>
  <xsl:template match="/">
    <xsl:for-each select="users/user">
      <xsl:value-of select="name"/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
EOF

/usr/local/bin/jamf listUsers | xsltproc "/tmp/stylesheet.xslt" - | while read -r username; do

  if [ ! -s "/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then

    mkdir -p "/Users/${username}/Library/Application Support/Adobe/AIR/"
    touch "/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted"
    chown -R "${username}" "/Users/${username}/Library/Application Support/Adobe/"
    chmod -R 700 "/Users/$username/Library/Application Support/Adobe/"

  else

    rm -f "/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted"
    touch "/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"/Users/${username}/Library/Application Support/Adobe/AIR/eulaAccepted"
    chown -R "${username}" "/Users/${username}/Library/Application Support/Adobe/"
    chmod -R 700 "/Users/${username}/Library/Application Support/Adobe/"

  fi

done

rm -f "/tmp/stylesheet.xslt"

# AdobeAIR EULA Acception for user template

for user_template in "/System/Library/User Template"/*; do
  if [ ! -s "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted" ]; then
    mkdir -p "${user_template}/Library/Application Support/Adobe/AIR/"
    touch "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
  else
    rm -f "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    mkdir -p "${user_template}/Library/Application Support/Adobe/AIR/"
    touch "${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
    echo "3" >>"${user_template}/Library/Application Support/Adobe/AIR/eulaAccepted"
  fi
done
