#!/bin/bash

download="https://secure.join.me/Download.aspx?installer=mac&webdownload=true"
echo "=> Download from '${download}'"

curl -s "${download}" --user-agent "Homebrew/2.1.10-12-g9812693 (Macintosh; Intel Mac OS X 10.14.6) curl/7.54.0" -o "/tmp/join.me.zip"
echo "=> Install 'join.me.zip' to '/Applications/join.me.app'"

if [ -s "/tmp/join.me.zip" ]; then
  if [ -s "/Applications/join.me.app" ]; then
    rm -rf "/Applications/join.me.app"
  fi
  ditto -x -k "/tmp/join.me.zip" "/Applications/"
  rm -f "/tmp/join.me.zip"
else
  echo "=> Download failed"
fi