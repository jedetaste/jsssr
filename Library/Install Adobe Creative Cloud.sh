#!/bin/bash

url="https://ccmdl.adobe.com/AdobeProducts/KCCC/CCD/5_2/osx10/ACCCx5_2_0_436.dmg"

echo "=> Download '${url}'"

curl -s -o "/tmp/adobe-creative-cloud.dmg" "${url}"

echo "=> Extract '/tmp/adobe-creative-cloud.dmg'"

extract_dir=$(dmg-extractor "/tmp/adobe-creative-cloud.dmg")

echo "=> "

sudo "${extract_dir}/Install.app/Contents/MacOS/Install" --mode=silent

rm -f "/tmp/adobe-creative-cloud.dmg"
rm -rf "$(dirname "${extract_dir}")"
