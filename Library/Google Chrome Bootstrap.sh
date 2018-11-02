#!/bin/bash

  if [ -r "/Library/Google/Google Chrome Master Preferences" ]; then
    rm -rf "/Library/Google/Google Chrome Master Preferences"
  fi

  mkdir -p "/Library/Google"

  touch "/Library/Google/Google Chrome Master Preferences"

  chown -R root:wheel "/Library/Google/"
  chmod -R 755 "/Library/Google/"

  GoogleChromeMasterPreferences="/Library/Google/Google Chrome Master Preferences"

  cat > "${GoogleChromeMasterPreferences}" <<EOL
{
  "homepage" : "https://google.ch",
  "homepage_is_newtabpage" : false,
  "browser" : {
    "show_home_button" : true,
    "check_default_browser" : false
},
  "distribution" : {
    "show_welcome_page" : false,
    "skip_first_run_ui" : true,
    "import_history" : false,
    "import_bookmarks" : false,
    "import_home_page" : false,
    "import_search_engine" : false,
    "suppress_first_run_bubble": true,
    "suppress_first_run_default_browser_prompt": true
},
  "sync_promo" : {
    "user_skipped" : true
},
  "first_run_tabs" : [
    "https://google.ch"
  ]
}
EOL

  for usertemplate in "/System/Library/User Template"/*; do

    PreferencesFolder="${usertemplate}/Library/Application Support/Google"

    if [ -d "${PreferencesFolder}" ]; then
      rm -rf "${PreferencesFolder}"
    fi

    mkdir -p "${PreferencesFolder}/Chrome/Default"

    touch "${PreferencesFolder}/Chrome/Default/Preferences"
    touch "${PreferencesFolder}/Chrome/First Run"

    chown -R root:wheel "${PreferencesFolder}"

    Preferences="${PreferencesFolder}/Chrome/Default/Preferences"

    cat > "${Preferences}" <<EOL
{
  "apps": {
    "shortcuts_version": 2
  },
  "autofill": {
    "use_mac_address_book": false
  },
  "browser": {
    "check_default_browser": false,
    "last_known_google_url": "https://www.google.ch",
    "last_prompted_google_url": "https://www.google.ch",
    "show_home_button": false,
    "show_update_promotion_info_bar": false,
    "window_placement": {
      "always_on_top": false,
      "bottom": 683,
      "left": 10,
      "maximized": false,
      "right": 1060,
      "top": 22,
      "work_area_bottom": 727,
      "work_area_left": 0,
      "work_area_right": 1280,
      "work_area_top": 22
    }
  },
  "countryid_at_install": 16725,
  "default_apps_install_state": 3,
  "distribution": {
    "import_bookmarks": false,
    "import_history": false,
    "import_home_page": false,
    "import_search_engine": false,
    "show_welcome_page": false,
    "skip_first_run_ui": true,
    "suppress_first_run_bubble": true,
    "suppress_first_run_default_browser_prompt": true
  },
  "first_run_tabs": [ "https://google.ch" ],
  "homepage": "https://google.ch",
  "homepage_is_newtabpage": false,
  "hotword": {
    "previous_language": "de-CH"
  },
  "intl": {
    "accept_languages": "de-CH,de"
  },
  "invalidator": {
    "client_id": "NPkJsIb50XkFfjJb1lH8SQ=="
  },
  "media": {
    "device_id_salt": "qPIPmfV9u7CJGs6aXx9DxA=="
  },
  "pinned_tabs": [  ],
  "plugins": {
    "migrated_to_pepper_flash": true,
    "plugins_list": [  ],
    "removed_old_component_pepper_flash_settings": true
  },
  "profile": {
    "avatar_index": 26,
    "content_settings": {
      "clear_on_exit_migrated": true,
    "pattern_pairs": {

    },
    "pref_version": 1
  },
  "exit_type": "Normal",
  "exited_cleanly": true,
  "managed_user_id": "",
  "name": "First user",
  "password_manager_enabled": true,
  "per_host_zoom_levels": {

  }
  },
  "proxy": {
    "bypass_list": "",
    "mode": "system",
    "server": ""
  },
  "session": {
    "restore_on_startup": 4,
    "restore_on_startup_migrated": true,
    "startup_urls": [ "https://google.ch" ],
    "startup_urls_migration_time": "13064995362418883"
  },
  "sync_promo": {
    "user_skipped": true
  },
  "translate_blocked_languages": [ "de" ],
  "translate_whitelists": {

  }
}
EOL

  done