#!/bin/bash

version="2019.2"

echo "=> Download 'https://releases.gpgtools.org/GPG_Suite-${version}.dmg'"

curl -s -L -o "/tmp/GPG_Suite-${version}.dmg" "https://releases.gpgtools.org/GPG_Suite-${version}.dmg"

extract_dir=$(dmg-extractor "/tmp/GPG_Suite-${version}.dmg")

echo "=> Run installer '${extract_dir}/Install.pkg'"

installer -pkg "${extract_dir}/Install.pkg" -target /
