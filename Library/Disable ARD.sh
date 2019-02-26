#!/bin/bash

  # Disable ARD

  kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"

  ${kickstart}" --deactivate