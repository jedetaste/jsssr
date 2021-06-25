#!/bin/bash -x

array=(
  "/Applications/Microsoft Excel.app"
  "/Applications/Microsoft OneNote.app"
  "/Applications/Microsoft Outlook.app"
  "/Applications/Microsoft PowerPoint.app"
  "/Applications/Microsoft Word.app"
  "/Applications/OneDrive.app"
)

for item in "${array[@]}"; do
  echo "Remove Gatekeeper Quarantine for '${item}'"
  xattr -r -d -s "com.apple.quarantine" "${item}"
  spctl --add "${item}"
done
