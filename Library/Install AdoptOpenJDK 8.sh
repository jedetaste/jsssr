#!/bin/bash

major_version="1.8.0"
version="282"
build="08"

sha256="f12d380ceae806d02c4cae23bdc601402c543692c763122286b99d8ef6059794"
download="https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u${version}-b${build}/OpenJDK8U-jdk_x64_mac_hotspot_8u${version}b${build}.pkg"

tmp_dir=$(/usr/local/bin/tmpDir)
redirect_url=$(curl -w "%{redirect_url}" -o /dev/null -s "${download}")
current_version=$(defaults read /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Info.plist CFBundleGetInfoString 2>/dev/null)
available_version="AdoptOpenJDK ${major_version}_${version}-b${build}"

install_jdk() {

  echo "=> Downloading '${download}'"
  echo "=> Downloading from '${redirect_url}'"
  curl -s -o "${tmp_dir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" "${redirect_url}"

  if [ -s "${tmp_dir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" ]; then
    if [ "$(shasum -a 256 "${tmp_dir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" | cut -d' ' -f1)" = "${sha256}" ]; then
      echo "=> Expected SHA-256 checksum is correct"
      echo "=> Install '${tmp_dir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg'"
      installer -pkg "${tmp_dir}/OpenJDK8U-jdk_x64_mac_hotspot_8u${212}b${build}.pkg" -target /
    else
      echo "SHA-256 checksum mismatch" && exit 1
    fi
  else
    echo "Download failed" && exit 1
  fi

}

if [ -n "${current_version}" ]; then
  if [ ! "${current_version}" = "${available_version}" ]; then
    echo "=> AdoptOpenJDK v${current_version} is installed but outdated"
    install_jdk "$@"
  else
    echo "=> AdoptOpenJDK u${version}-b${build} is installed and up-to-date!"
    exit 0
  fi
else
  echo "=> AdoptOpenJDK u${version}-b${build} is not installed"
  install_jdk "$@"
fi

rm -rf "${tmp_dir}"
