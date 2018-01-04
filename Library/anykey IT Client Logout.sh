#!/bin/bash

	# Set permissions on Accounts.prefPane

	if [ -d "/Users/gastschule/" ]; then
		pwpolicy -u gastschule -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer gastschule gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/lernende/" ]; then
		pwpolicy -u lernende -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer lernende gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/lokal/" ]; then
		pwpolicy -u lokal -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer lokal gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/mittelstufe/" ]; then
		pwpolicy -u mittelstufe -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer mittelstufe gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/schueler/" ]; then
		pwpolicy -u schueler -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer schueler gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/sus/" ]; then
		pwpolicy -u sus -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer sus gefunden und Kennwort Aenderung deaktiviert
	fi

	if [ -d "/Users/unterstufe/" ]; then
		pwpolicy -u unterstufe -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer unterstufe gefunden und Kennwort Aenderung deaktiviert
	fi
	
	if [ -d "/Users/schule/" ]; then
		pwpolicy -u schule -setpolicy "canModifyPasswordforSelf=0"
		echo Benutzer schule gefunden und Kennwort Aenderung deaktiviert
	fi

	# Create directory geloeschteHomes in Library

	if [ ! -d "/Library/geloeschteHomes/" ]; then
		mkdir /Library/geloeschteHomes
	fi

	# Move home directory schueler to Library

	if [ -d "/Users/gastschule/" ]; then
		mv /Users/gastschule /Library/geloeschteHomes/gastschule-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner gastschule gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/lernende/" ]; then
		mv /Users/lernende /Library/geloeschteHomes/lernende-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner lernende gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/lokal/" ]; then
		mv /Users/lokal /Library/geloeschteHomes/lokal-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner lokal gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/mittelstufe/" ]; then
		mv /Users/mittelstufe /Library/geloeschteHomes/mittelstufe-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner mittelstufe gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/schueler/" ]; then
		mv /Users/schueler /Library/geloeschteHomes/schueler-$(date +%Y-%m-%d--%H-%M-%S)	
		echo Benutzerordner schueler gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/sus/" ]; then
		mv /Users/sus /Library/geloeschteHomes/sus-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner sus gefunden und Benutzerordner archiviert
	fi

	if [ -d "/Users/unterstufe/" ]; then
		mv /Users/unterstufe /Library/geloeschteHomes/unterstufe-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner unterstufe gefunden und Benutzerordner archiviert
	fi
	
	if [ -d "/Users/schule/" ]; then
		mv /Users/schule /Library/geloeschteHomes/schule-$(date +%Y-%m-%d--%H-%M-%S)
		echo Benutzerordner schule gefunden und Benutzerordner archiviert
	fi

	# Set permissions
	
	chown -R admin "/Library/geloeschteHomes/"
	chmod -R 700 "/Library/geloeschteHomes/"

	# Cancel all print jobs
	
	cancel -a

	# Start all cancelled print jobs
	
	lpstat -p | grep "disabled" | awk '{print $2}' | xargs -n 1 -I{} sudo cupsenable {}

	# Kill CloudKeychainProxy
	
	killall CloudKeychainProxy

	# Repair user permissions
	
	chmod 700 /Users/*

	# Repair shared folder
	
	chmod -R 777 "/Users/Shared/"

exit 0