#!/bin/bash

  config_file="/Applications/Promethean/Activsoftware Inspire/Inspire.app/Contents/MacOs/admin.ini"

  if [ -d "/Applications/Promethean" ]; then
    echo > "${config_file}"

    cat > "${config_file}" <<EOL
[General]

0=
1=
2=
3=
4=
5=
6=
7=
8=
9=
10=
11=1
EOL

    if [ -s "${config_file}" ]; then
      echo "Successfully created configuration file in '${config_file}'" && exit 0
    else
      echo "Something went wrong, while creating configuration file in '${config_file}'" && exit 1
    fi

  fi