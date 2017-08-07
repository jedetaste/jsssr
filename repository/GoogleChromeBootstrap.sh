#!/bin/bash
	
	if [ -r "/Library/Google/Google Chrome Master Preferences" ]; then
		rm -rf "/Library/Google/Google Chrome Master Preferences"
	fi
	
	mkdir -p "/Library/Google"
	
	touch "/Library/Google/Google Chrome Master Preferences"
	
	chown -R root:wheel "/Library/Google/"
	chmod -R 755 "/Library/Google/"
	
	GoogleChromeMasterPreferences="/Library/Google/Google Chrome Master Preferences"
	
	echo '{' >> "${GoogleChromeMasterPreferences}"
	echo '	"homepage" : "https://google.ch",' >> "${GoogleChromeMasterPreferences}"
	echo '	"homepage_is_newtabpage" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '	"browser" : {' >> "${GoogleChromeMasterPreferences}"
	echo '		"show_home_button" : true,' >> "${GoogleChromeMasterPreferences}"
	echo '		"check_default_browser" : false' >> "${GoogleChromeMasterPreferences}"
	echo '},' >> "${GoogleChromeMasterPreferences}"
	echo '	"distribution" : {' >> "${GoogleChromeMasterPreferences}"
	echo '		"show_welcome_page" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '		"skip_first_run_ui" : true,' >> "${GoogleChromeMasterPreferences}"
	echo '		"import_history" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '		"import_bookmarks" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '		"import_home_page" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '		"import_search_engine" : false,' >> "${GoogleChromeMasterPreferences}"
	echo '		"suppress_first_run_bubble": true,' >> "${GoogleChromeMasterPreferences}"
	echo '		"suppress_first_run_default_browser_prompt": true' >> "${GoogleChromeMasterPreferences}"
	echo '},' >> "${GoogleChromeMasterPreferences}"
	echo '	"sync_promo" : {' >> "${GoogleChromeMasterPreferences}"
	echo '		"user_skipped" : true' >> "${GoogleChromeMasterPreferences}"
	echo '},' >> "${GoogleChromeMasterPreferences}"
	echo '	"first_run_tabs" : [' >> "${GoogleChromeMasterPreferences}"
	echo '		"https://google.ch"' >> "${GoogleChromeMasterPreferences}"
	echo '	]' >> "${GoogleChromeMasterPreferences}"
	echo '}' >> "${GoogleChromeMasterPreferences}"
	
	if [ ! -d "/System/Library/User Template/German.lproj/Library/Application Support/Google/Chrome" ]; then
		rm -rf "/System/Library/User Template/German.lproj/Library/Application Support/Google/"
	fi
	
	mkdir -p "/System/Library/User Template/German.lproj/Library/Application Support/Google/Chrome/Default/"
	
	touch "/System/Library/User Template/German.lproj/Library/Application Support/Google/Chrome/Default/Preferences"
	touch "/System/Library/User Template/German.lproj/Library/Application Support/Google/Chrome/First Run"
	
	chown -R root:wheel "/System/Library/User Template/German.lproj/Library/Application Support/Google"
	chmod -R 755 "/System/Library/User Template/German.lproj/Library/Application Support/Google"
	
	Preferences="/System/Library/User Template/German.lproj/Library/Application Support/Google/Chrome/Default/Preferences"
	
	echo '{' >> "${Preferences}"
	echo '	"apps": {' >> "${Preferences}"
	echo '		"shortcuts_version": 2' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"autofill": {' >> "${Preferences}"
	echo '		"use_mac_address_book": false' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"browser": {' >> "${Preferences}"
	echo '		"check_default_browser": false,' >> "${Preferences}"
	echo '		"last_known_google_url": "https://www.google.ch",' >> "${Preferences}"
	echo '		"last_prompted_google_url": "https://www.google.ch",' >> "${Preferences}"
	echo '		"show_home_button": true,' >> "${Preferences}"
	echo '		"show_update_promotion_info_bar": false,' >> "${Preferences}"
	echo '		"window_placement": {' >> "${Preferences}"
	echo '			"always_on_top": false,' >> "${Preferences}"
	echo '			"bottom": 683,' >> "${Preferences}"
	echo '			"left": 10,' >> "${Preferences}"
	echo '			"maximized": false,' >> "${Preferences}"
	echo '			"right": 1060,' >> "${Preferences}"
	echo '			"top": 22,' >> "${Preferences}"
	echo '			"work_area_bottom": 727,' >> "${Preferences}"
	echo '			"work_area_left": 0,' >> "${Preferences}"
	echo '			"work_area_right": 1280,' >> "${Preferences}"
	echo '			"work_area_top": 22' >> "${Preferences}"
	echo '		}' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"countryid_at_install": 16725,' >> "${Preferences}"
	echo '	"default_apps_install_state": 3,' >> "${Preferences}"
	echo '	"distribution": {' >> "${Preferences}"
	echo '		"import_bookmarks": false,' >> "${Preferences}"
	echo '		"import_history": false,' >> "${Preferences}"
	echo '		"import_home_page": false,' >> "${Preferences}"
	echo '		"import_search_engine": false,' >> "${Preferences}"
	echo '		"show_welcome_page": false,' >> "${Preferences}"
	echo '		"skip_first_run_ui": true,' >> "${Preferences}"
	echo '		"suppress_first_run_bubble": true,' >> "${Preferences}"
	echo '		"suppress_first_run_default_browser_prompt": true' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"first_run_tabs": [ "https://google.ch" ],' >> "${Preferences}"
	echo '	"homepage": "https://google.ch",' >> "${Preferences}"
	echo '	"homepage_is_newtabpage": false,' >> "${Preferences}"
	echo '	"hotword": {' >> "${Preferences}"
	echo '		"previous_language": "de-CH"' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"intl": {' >> "${Preferences}"
	echo '		"accept_languages": "de-CH,de"' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"invalidator": {' >> "${Preferences}"
	echo '		"client_id": "NPkJsIb50XkFfjJb1lH8SQ=="' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"media": {' >> "${Preferences}"
	echo '		"device_id_salt": "qPIPmfV9u7CJGs6aXx9DxA=="' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"pinned_tabs": [  ],' >> "${Preferences}"
	echo '	"plugins": {' >> "${Preferences}"
	echo '		"migrated_to_pepper_flash": true,' >> "${Preferences}"
	echo '		"plugins_list": [  ],' >> "${Preferences}"
	echo '		"removed_old_component_pepper_flash_settings": true' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"profile": {' >> "${Preferences}"
	echo '		"avatar_index": 26,' >> "${Preferences}"
	echo '		"content_settings": {' >> "${Preferences}"
	echo '			"clear_on_exit_migrated": true,' >> "${Preferences}"
	echo '		"pattern_pairs": {' >> "${Preferences}"
	echo '	' >> "${Preferences}"
	echo '		},' >> "${Preferences}"
	echo '		"pref_version": 1' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"exit_type": "Normal",' >> "${Preferences}"
	echo '	"exited_cleanly": true,' >> "${Preferences}"
	echo '	"managed_user_id": "",' >> "${Preferences}"
	echo '	"name": "First user",' >> "${Preferences}"
	echo '	"password_manager_enabled": false,' >> "${Preferences}"
	echo '	"per_host_zoom_levels": {' >> "${Preferences}"
	echo '		' >> "${Preferences}"
	echo '	}' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"proxy": {' >> "${Preferences}"
	echo '		"bypass_list": "",' >> "${Preferences}"
	echo '		"mode": "system",' >> "${Preferences}"
	echo '		"server": ""' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"session": {' >> "${Preferences}"
	echo '		"restore_on_startup": 4,' >> "${Preferences}"
	echo '		"restore_on_startup_migrated": true,' >> "${Preferences}"
	echo '		"startup_urls": [ "https://google.ch" ],' >> "${Preferences}"
	echo '		"startup_urls_migration_time": "13064995362418883"' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"sync_promo": {' >> "${Preferences}"
	echo '		"user_skipped": true' >> "${Preferences}"
	echo '	},' >> "${Preferences}"
	echo '	"translate_blocked_languages": [ "de" ],' >> "${Preferences}"
	echo '	"translate_whitelists": {' >> "${Preferences}"
	echo '' >> "${Preferences}"
	echo '	}' >> "${Preferences}"
	echo '}' >> "${Preferences}"
	
exit 0