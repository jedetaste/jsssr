#!/bin/bash

confFile="/Library/Application Support/Macromedia/mms.cfg"

/bin/cat >"${confFile}" <<EOF
AutoUpdateDisable=1
SilentAutoUpdateEnable=0
EOF
