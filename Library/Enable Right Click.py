#!/usr/bin/python

import CoreFoundation
from Foundation import NSBundle
import objc

## Enable right click on Apple wired mouse

# Set Button 1 aka "Primary Button"
CoreFoundation.CFPreferencesSetAppValue("Button1", 1,  "com.apple.driver.AppleHIDMouse")

# Set Button 2 aka "Secondary Button"
CoreFoundation.CFPreferencesSetAppValue("Button2", 2,  "com.apple.driver.AppleHIDMouse")

# Set Button 3
CoreFoundation.CFPreferencesSetAppValue("Button3", 3,  "com.apple.driver.AppleHIDMouse")

# Set Button 4
CoreFoundation.CFPreferencesSetAppValue("Button4", 4,  "com.apple.driver.AppleHIDMouse")

# Update user preferences cache
CoreFoundation.CFPreferencesAppSynchronize("com.apple.driver.AppleHIDMouse")

# Update kernel preferences cache
bezel_bundle = NSBundle.bundleWithPath_('/System/Library/PrivateFrameworks/BezelServices.framework')
functions = [('BSKernelPreferenceChanged', '@@'),]
objc.loadBundleFunctions(bezel_bundle, globals(), functions)
BSKernelPreferenceChanged("com.apple.driver.AppleHIDMouse")

## Enable right click on Apple bluetooth mouse

# Set Secondary Click
CoreFoundation.CFPreferencesSetAppValue("MouseButtonMode", "TwoButton",  "com.apple.driver.AppleBluetoothMultitouch.mouse")
# Update user preferences cache
CoreFoundation.CFPreferencesAppSynchronize("com.apple.driver.AppleBluetoothMultitouch.mouse")

# Update kernel preferences cache
bezel_bundle = NSBundle.bundleWithPath_('/System/Library/PrivateFrameworks/BezelServices.framework')
functions = [('BSKernelPreferenceChanged', '@@'),]
objc.loadBundleFunctions(bezel_bundle, globals(), functions)
BSKernelPreferenceChanged("com.apple.driver.AppleBluetoothMultitouch.mouse")