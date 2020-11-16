#!/bin/bash

version="$(curl -s -L "https://formulae.brew.sh/api/cask/libreoffice-language-pack.json" | jq -r '.version')"
url="https://download.documentfoundation.org/libreoffice/stable/${version}/mac/x86_64/LibreOffice_${version}_MacOS_x86-64_langpack_de.dmg"

curl -s -L -o "/tmp/libreoffice-langpack-de.dmg" "${url}"

extract_dir="$(dmg-extractor "/tmp/libreoffice-langpack-de.dmg")"

tar -C "/Applications/LibreOffice.app/" -xjf "${extract_dir}/LibreOffice Language Pack.app/Contents/tarball.tar.bz2" && touch "/Applications/LibreOffice.app/Contents/Resources/extensions"

rm -f "/tmp/libreoffice-langpack-de.dmg"
rm -rf "$(dirname "${extract_dir}")"
