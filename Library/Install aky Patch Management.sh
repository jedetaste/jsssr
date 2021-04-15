#!/bin/bash

[ ! -d "/usr/local/bin/" ] && mkdir -p "/usr/local/bin/"
[ -s "/usr/local/bin/aky" ] && rm -f "/usr/local/bin/aky"

curl -so "/usr/local/bin/aky" "https://raw.githubusercontent.com/jedetaste/helper/master/bin/aky"

chown root:wheel "/usr/local/bin/aky"
chmod 775 "/usr/local/bin/aky"
chmod +x "/usr/local/bin/aky"

[ -s "/usr/local/bin/jq" ] && rm -f "/usr/local/bin/jq"

release="1.6"

curl -s -L -o "/usr/local/bin/jq" "https://github.com/stedolan/jq/releases/download/jq-${release}/jq-osx-amd64"

chown root:wheel "/usr/local/bin/jq"
chmod 775 "/usr/local/bin/jq"
chmod +x "/usr/local/bin/jq"
