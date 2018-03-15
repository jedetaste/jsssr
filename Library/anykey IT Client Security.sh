#!/bin/sh
# 20170424 - 18:44 - tobiaslinder

# Get Current User
currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Forcing XProtect blacklist updates
defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
softwareupdate --background-critical
defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false

# Repair user permissions
chmod 700 "/Users/"*

# Repair shared folder
chmod -R 777 "/Users/Shared/"

# Delete the OSX.PROTON virus pieces
rm -rf '/Users/${currentUser}/Library/LaunchAgents/fr.handbrake.activity_agent.plist'
rm -rf '/Users/${currentUser}/Library/RenderFiles/activity_agent.app'

# Delete the Genieo virus pieces.
rm -rf '/private/etc/launchd.conf'
rm -rf '/Applications/Genieo.app'
rm -rf '/Applications/InstallMac.app'
rm -rf '/Applications/Uninstall\ Genieo.app'
rm -rf '/Applications/Uninstall\ IM\ Completer.app'
rm -rf '/Users/${currentUser}/Library/Application\ Support/com.genieoinnovation.Installer'
rm -rf '/Users/${currentUser}/Library/Application\ Support/Genieo/'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.update.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.ltvbit.plist'
rm -rf '/Library/LaunchAgents/com.genieoinnovation.macextension.plist'
rm -rf '/Library/LaunchAgents/com.genieoinnovation.macextension.client.plist'
rm -rf '/Library/LaunchAgents/com.genieo.engine.plist'
rm -rf '/Library/LaunchAgents/com.genieo.completer.update.plist'
rm -rf '/Library/LaunchDaemons/com.genieoinnovation.macextension.client.plist'
rm -rf '/Library/PrivilegedHelperTools/com.genieoinnovation.macextension.client'
rm -rf '/usr/lib/libgenkit.dylib'
rm -rf '/usr/lib/libgenkitsa.dylib'
rm -rf '/usr/lib/libimckit.dylib'
rm -rf '/usr/lib/libimckitsa.dylib'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.update.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.genieo.completer.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.installer.completer.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.installer.completer.update.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.installer.completer.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/texiday.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/texiday.update.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/texiday.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Listchack.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Listchack.update.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Listchack.ltvbit.plist'

# Delete the Vidx malware pieces. 
rm -rf '/Applications/Vidx.app'
rm -rf '/Applications/MacMin.app'
rm -rf '/Library/Application Support/VidToMP3'
rm -rf '/Library/Application Support/fa4e8.94b.550d413f'
rm -rf '/Users/${currentUser}/Library/Application Support/osxDownloader'

# Delete the Bundlore malware pieces. 
rm -rf '/Applications/WebTools.app'
rm -rf '/Applications/WebShopper.app'
rm -rf '/Users/${currentUser}/Applications/WebTools.app'
rm -rf '/Users/${currentUser}/Applications/WebShopper.app'
rm -rf '/Library/cinemapro1-2/'
rm -rf '/Users/${currentUser}/Library/cinemapro1-2/'
rm -rf '/Users/${currentUser}/Library/WebTools/'
rm -rf '/Users/${currentUser}/Library/Application Support/webHelperApp/'
rm -rf '/Users/${currentUser}/Library/Application Support/WebShopper/'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/WebServerSocketApp'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/UpdateDownloder'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.webhelper.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.webtools.update.agent.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.webtools.uninstaller.plist'

# Delete the Premier Opinion malware pieces. 
rm -rf '/Applications/PremierOpinion'
rm -rf '/Library/LaunchDaemons/PremierOpinion.plist'


# Delete MacKeeper
rm -rf '/Applications/MacKeeper.app'
rm -rf '/Library/Preferences/.3FAD0F65-rfC6E-4889-B975-B96CBF807B78'
rm -rf '/private/var/folders/mh/yprf0vxs3mx_n2lg3tjgqddm0000gn/T/MacKeeper*'
rm -rf '/private/tmp/MacKeeper*'
rm -rf '/Users/${currentUser}/Library/Application Support/MacKeeper Helper'
rm -rf '/Users/${currentUser}/Library/Application Support/MacKeeper Helper'
rm -rf '/Users/${currentUser}/Library/Launch Agents/com.zeobit.MacKeeper.Helper.plist'
rm -rf '/Users/${currentUser}/Library/Logs/MacKeeper.log'
rm -rf '/Users/${currentUser}/Library/Logs/MacKeeper.log.signed'
rm -rf '/Users/${currentUser}/Library/Logs/SparkleUpdateLog.log'
rm -rf '/Users/${currentUser}/Library/Preferences/.3246584E-0CF8-4153-835D-C7D952862F9D'
rm -rf '/Users/${currentUser}/Library/Preferences/com.zeobit.MacKeeper.Helper.plist'
rm -rf '/Users/${currentUser}/Library/Preferences/com.zeobit.MacKeeper.plist'
rm -rf '/Users/${currentUser}/Library/Saved Application State/com.zeobit.MacKeeper.savedState'
rm -rf '/Users/${currentUser}/Downloads/MacKeeper*'
rm -rf '/Users/${currentUser}/Documents/MacKeeper*'

# Delete the Conduit virus pieces.
rm -rf '/Library/InputManagers/CTLoader/'
rm -rf '/Library/LaunchAgents/com.conduit.loader.agent.plist'
rm -rf '/Library/LaunchDaemons/com.perion.searchprotectd.plist'
rm -rf '/Library/Application Support/SIMBL/Plugins/CT2285220.bundle'
rm -rf '/Library/Application Support/Conduit/'
rm -rf '/Applications/SearchProtect.app'
rm -rf '/Applications/SearchProtect/'
rm -rf '/Users/${currentUser}/Library/Application Support/Conduit/'
rm -rf '/Users/${currentUser}/Library/Internet Plug-Ins/ConduitNPAPIPlugin.plugin'
rm -rf '/Users/${currentUser}/Conduit/'
rm -rf '/Users/${currentUser}/Library/LaungAgents/com.crossrider.wss002505.agent.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/WebSocketServerApp'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.webhelper.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.webtools.update.agent.plist'
rm -rf '/Users/${currentUser}/Library/Application Support/webHelperApp'
rm -rf '/Users/${currentUser}/Library/WebTools'

# Delete the Trovi virus pieces.
rm -rf '/Library/LaunchDaemons/com.perion.searchprotectd.plist'
rm -rf '/Users/${currentUser}/Trovi'
rm -rf '/Users/${currentUser}/Library/Internet Plug-Ins/TroviNPAPIPlugin.plugin'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/searchExt.safariextz'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/searchme.safariextz'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/palmall-1-2.safariextz'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/Omnibar-2.safariextz'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/palmall-1-2_updater.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/palmall-1-2_updater.sh'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/palmall-1-2.ver'

# Delete the V-Search virus pieces.
rm -rf '/Library/Application Support/VSearch'
rm -rf '/Library/LaunchAgents/com.vsearch.agent.plist'
rm -rf '/Library/LaunchDaemons/com.vsearch.daemon.plist'
rm -rf '/Library/LaunchDaemons/com.vsearch.helper.plist'
rm -rf '/Library/LaunchDaemons/Jack.plist'
rm -rf '/Library/PrivilegedHelperTools/Jack'
rm -rf '/System/Library/Frameworks/VSearch.framework'
rm -rf '/Users/${currentUser}/Library/Application Support/MPlayerX'
rm -rf '/Applications/MPlayerX'

# Delete the Javeview malware pieces. 
rm -rf '/Users/${currentUser}/Library/Application Support/Javeview'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Javeview.update.plist'

# Delete the Manroling malware pieces. 
rm -rf '/Users/${currentUser}/Library/Application Support/Manroling'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Manroling.update.plist'

# Delete the Myppes malware pieces. 
rm -rf '/Applications/Myppes'
rm -rf '/Users/${currentUser}/Library/Application Support/Myppes'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/Myppes.safariextz'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Myppes.AppRemoval.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Myppes.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Myppes.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Myppes.update.plist'

# Delete the Olivernetko malware pieces. 
rm -rf '/Applications/Olivernetko'
rm -rf '/Users/${currentUser}/Library/Application Support/Olivernetko'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Olivernetko.AppRemoval.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Olivernetko.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Olivernetko.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Olivernetko.update.plist'

# Delete the Youppes malware pieces. 
rm -rf '/Applications/Youppes'
rm -rf '/Users/${currentUser}/Library/Application Support/Youppes'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Youppes.AppRemoval.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Youppes.download.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Youppes.ltvbit.plist'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/Youppes.update.plist'

# Delete the ChatZum malware pieces. 
rm -rf '/Applications/ChatZumUninstaller.pkg'
rm -rf '/Library/Application Support/SIMBL/Plugins/SafariOmnibar.bundle'
rm -rf '/Library/Internet Plug-Ins/uid.plist'
rm -rf '/Library/Internet Plug-Ins/zako.plugin'

# Delete the FkCodec malware pieces. 
rm -rf '/Users/${currentUser}/Library/Application Support/Codec-M'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.codecm.uploader.plist'
rm -rf '/Applications/Codec-M.app'

# Delete the Yontoo malware pieces. 
rm -rf '/Users/${currentUser}/Library/Application Support/Google/Chrome/YontooLayers.crx'
rm -rf '/Users/${currentUser}/Library/LaunchAgents/com.codecm.uploader.plist'
rm -rf '/Applications/Codec-M.app'

# Delete the Spigot malware pieces. 
rm -rf '/Users/${currentUser}/Library/Application Support/Spigot/'

# Delete the SaveKeep malware pieces. 
rm -rf '/Applications/Savekeep.app'

# Delete different malware
rm -rf '/Applications/SearchProtect/'
rm -rf '/Users/${currentUser}/Library/Application Support/Firefox/Profiles/*/searchplugins/my-homepage.xml'
rm -rf '/Users/${currentUser}/Library/Application Support/Firefox/Profiles/*/takeOverNewTab.txt'
rm -rf '/Users/${currentUser}/Library/Application Support/Firefox/Profiles/*/searchplugins/my-homepage.xml'
rm -rf '/Users/${currentUser}/Library/Safari/Extensions/s1h2m3o4o5p6i.safariextz'

exit 0
