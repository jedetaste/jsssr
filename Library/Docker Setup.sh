#!/bin/bash -x

declare -r docker_bundle_dir="/Applications/Docker.app/Contents"
declare -r privtools="/Library/PrivilegedHelperTools"
declare -r usr_local_bin="/usr/local/bin"

[[ ! -d "${usr_local_bin}" ]] && /bin/mkdir -p ${usr_local_bin}

chmod 1755 "${usr_local_bin}"

for tool in docker docker-compose docker-diagnose docker-machine notary; do
  /bin/ln -sf "${docker_bundle_dir}/Resources/bin/${tool}" "/usr/local/bin"
done

[[ ! -d "${privtools}" ]] && mkdir -p "${privtools}"

chmod 1755 "${privtools}"

# unload com.docker.vmnetd if present

if [[ -e "/Library/LaunchDaemons/com.docker.vmnetd.plist" ]]; then
  launchctl unload "/Library/LaunchDaemons/com.docker.vmnetd.plist"
fi

install -m 0544 -o root -g wheel "${docker_bundle_dir}/Library/LaunchServices/com.docker.vmnetd" "${privtools}"

/bin/cat >"/Library/LaunchDaemons/com.docker.vmnetd.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
	<key>Label</key>
	<string>com.docker.vmnetd</string>
	<key>Program</key>
	<string>/Library/PrivilegedHelperTools/com.docker.vmnetd</string>
	<key>ProgramArguments</key>
	<array>
	  <string>/Library/PrivilegedHelperTools/com.docker.vmnetd</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>Sockets</key>
	<dict>
	  <key>Listener</key>
	  <dict>
		<key>SockPathMode</key>
		<integer>438</integer>
		<key>SockPathName</key>
		<string>/var/run/com.docker.vmnetd.sock</string>
	  </dict>
	</dict>
  </dict>
</plist>
EOF

chmod 644 "/Library/LaunchDaemons/com.docker.vmnetd.plist"

VERSION=$(defaults read "/Applications/Docker.app/Contents/Info.plist" VmnetdVersion)

defaults write "/Library/LaunchDaemons/com.docker.vmnetd.plist" Version -string "${VERSION}"
plutil -convert xml1 "/Library/LaunchDaemons/com.docker.vmnetd.plist"
chmod 0644 "/Library/LaunchDaemons/com.docker.vmnetd.plist"
launchctl load "/Library/LaunchDaemons/com.docker.vmnetd.plist"
