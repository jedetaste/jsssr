#!/bin/bash

spruce_version="3.0.0"

curl -s -L -o "/tmp/Spruce-${spruce_version}.zip" "https://github.com/jssimporter/Spruce/archive/${spruce_version}.zip"

ditto -x -k "/tmp/Spruce-${spruce_version}.zip" "/tmp/"

[ -s "/usr/local/bin/spruce" ] && rm -f "/usr/local/bin/spruce"

mv "/tmp/Spruce-${spruce_version}/spruce.py" "/usr/local/bin/spruce"
chmod +x "/usr/local/bin/spruce"

[ -d "/tmp/Spruce-${spruce_version}" ] && rm -rf "/tmp/Spruce-${spruce_version}"
[ -s "/tmp/Spruce-${spruce_version}".zip ] && rm -rf "/tmp/Spruce-${spruce_version}.zip"
