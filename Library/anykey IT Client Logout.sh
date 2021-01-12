#!/bin/bash

username=(
  'gastschule'
  'gastkonto'
  'lernende'
  'lokal'
  'mittelstufe'
  'unterstufe'
  'schueler'
  'schuler'
  'sus'
  'schule'
  'stud'
  'student'
)

# Set password policy

for ((i = 0; i < "${#username[@]}"; i++)); do
  if [ -d "/Users/${username[$i]}" ]; then
    echo "=> Set password policy for user '${username[$i]}'"
    pwpolicy -u "${username[$i]}" -setpolicy "canModifyPasswordforSelf=0"
  fi
done

# Move home directory to Library

if [ ! -d "/Library/geloeschteHomes/" ]; then
  mkdir -p "/Library/geloeschteHomes"
fi

timestamp=$(date +%Y-%m-%d-%H-%M-%S)

for ((i = 0; i < "${#username[@]}"; i++)); do
  if [ -d "/Users/${username[$i]}" ]; then
    echo "=> Move home directory '/Users/${username[$i]}' to '/Library/geloeschteHomes/${username[$i]}-${timestamp}'"
    mv "/Users/${username[$i]}" "/Library/geloeschteHomes/${username[$i]}-${timestamp}"
  fi
done

# Remove user homes older than 10 days

for dir in "/Library/geloeschteHomes/"*; do
  creation_date=$(stat -f%B "${dir%*/}")
  threshold_time_stamp=$(date -j -v -10d +%s)
  if [ "${creation_date}" -lt "${threshold_time_stamp}" ]; then
    echo "=> Remove home directory '${dir%*/}' from archive as it is older than 10 days"
    rm -rf "${dir%*/}"
  fi
done

# Remove legacy workflow

if [ -d "/.anytmp/" ]; then
  echo "=> Remove legacy workflow"
  rm -rf "/.anytmp/"
fi

# Set permissions

echo "=> Set permissions on '/Library/geloeschteHomes/'"
chown -R admin "/Library/geloeschteHomes/" && chmod -R 700 "/Library/geloeschteHomes/"

# Cancel all print jobs

echo "=> Cancel all print jobs"
cancel -a

# Restart all disabled printers

echo "=> Restart all disabled printers"
lpstat -p | grep "disabled" | awk '{print $2}' | xargs -n 1 -I{} sudo cupsenable {}
