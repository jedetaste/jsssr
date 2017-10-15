#!/bin/bash

	# Check "QuickTime Plugin.plugin"
	
	if [ -e "/Library/Internet Plug-Ins/QuickTime Plugin.plugin" ]; then
		pluginqtenabled="true"
	else
		pluginqtenabled="false"
	fi
	
	if [ -e "/Library/Internet Plug-Ins/Disabled Plug-Ins/QuickTime Plugin.plugin" ]; then
		pluginqtdisabled="true"
	else
		pluginqtdisabled="false"
	fi
	
	# Check "nsIQTScriptablePlugin.xpt"
	
	if [ -e "/Library/Internet Plug-Ins/nsIQTScriptablePlugin.xpt" ]; then
		pluginnsenabled="true"
	else
		pluginnsenabled="false"
	fi
	
	if [ -e "/Library/Internet Plug-Ins/Disabled Plug-Ins/nsIQTScriptablePlugin.xpt" ]; then
		pluginnsdisabled="true"
	else
		pluginnsdisabled="false"
	fi
	
	# Disable "QuickTime Plugin.plugin"
	
	if [ "${pluginqtenabled}" == "true" ] && [ "${pluginqtdisabled}" == "true" ]; then
		rm -rf "/Library/Internet Plug-Ins/QuickTime Plugin.plugin"
	fi
	
	if [ "${pluginqtenabled}" == "true" ] && [ "${pluginqtdisabled}" == "false" ]; then
		mv "/Library/Internet Plug-Ins/QuickTime Plugin.plugin" "/Library/Internet Plug-Ins/Disabled Plug-Ins/QuickTime Plugin.plugin"
	fi
	
	# Disable "nsIQTScriptablePlugin.xpt"
	
	if [ "${pluginnsenabled}" == "true" ] && [ "${pluginnsdisabled}" == "true" ]; then
		rm -rf "/Library/Internet Plug-Ins/nsIQTScriptablePlugin.xpt"
	fi
	
	if [ "${pluginnsenabled}" == "true" ] && [ "${pluginnsdisabled}" == "false" ]; then
		mv "/Library/Internet Plug-Ins/nsIQTScriptablePlugin.xpt" "/Library/Internet Plug-Ins/Disabled Plug-Ins/nsIQTScriptablePlugin.xpt"
	fi
	
exit 0