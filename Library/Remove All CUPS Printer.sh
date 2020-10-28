#!/bin/bash

for file in /etc/cups/ppd/*; do
  path="${file%.ppd}"
  name="${path##*/}"
  echo "=> Remove printer '${name}'"
  lpadmin -x "${name}"
done
