#!/bin/bash

library=(
  "lame_64bit_osx"
  "ffmpeg_64bit_osx"
)

for library_item in "${library[@]}"; do

  echo "=> Download 'https://lame.buanzo.org/${library_item}.pkg'"
  curl \
    --silent \
    --output "/tmp/${library_item}.pkg" \
    "https://lame.buanzo.org/${library_item}.pkg"

  if [ -s "/tmp/${library_item}.pkg" ]; then
    echo "=> Install '/tmp/${library_item}.pkg'"
    installer -pkg "/tmp/${library_item}.pkg" -target /
    echo "=> Remove installer '/tmp/${library_item}.pkg'"
    rm -f "/tmp/${library_item}.pkg"
  fi
  
done