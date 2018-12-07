#!/bin/bash

  for file in /etc/cups/ppd/*; do
    path="${file%.ppd}"
    name="${path##*/}"
    lpadmin -x "${name}"
  done