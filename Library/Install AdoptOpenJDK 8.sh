#!/bin/bash

major_version="1.8.0"
version="212"
build="04"
sha256="20c4d9d3c0b10c21f781ba3a723683c70805e61939f908522cbce76e6e1ed2af"
download="https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u${version}-b${build}/OpenJDK8U-jdk_x64_mac_hotspot_8u${version}b${build}.pkg"

tmpDir=$(/usr/local/bin/tmpDir)
redirect_url=$(curl -w "%{redirect_url}" -o /dev/null -s "${download}")
current_version=$(defaults read /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Info.plist CFBundleGetInfoString 2> /dev/null)
available_version="AdoptOpenJDK ${major_version}_${version}-b${build}"

install_jdk() {

  echo "=> Downloading '${download}'"
  echo "=> Downloading from '${redirect_url}'"
  curl -s -o "${tmpDir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" "${redirect_url}"

  if [ -s "${tmpDir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" ]; then
    if [ $(shasum -a 256 -p "${tmpDir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" | cut -d' ' -f1) = "${sha256}" ]; then
      echo "=> Expected SHA-256 checksum is correct"
      echo "=> Install '${tmpDir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg'"
      installer -pkg "${tmpDir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" -target /
    else
      echo "SHA-256 checksum mismatch" && exit 1
    fi
  else
    echo "Download failed" && exit 1
  fi

}

if [ ! -z "${current_version}" ]; then
  if [ ! "${current_version}" = "${available_version}" ]; then
    echo "=> AdoptOpenJDK u${version}-b${build} is installed but outdated"
    install_jdk
  else
    echo "=> AdoptOpenJDK u${version}-b${build} is installed and up-to-date!"
    exit 0
  fi
else
  echo "=> AdoptOpenJDK u${version}-b${build} is not installed"
  install_jdk
fi

rm -rf "${tmpDir}"