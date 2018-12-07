#!/bin/bash
  
  currentUser=$(python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
  
  su -l "${currentUser}" -c "/usr/local/bin/duti -s com.adobe.Reader com.adobe.pdf all"
  su -l "${currentUser}" -c "/usr/local/bin/duti -s com.adobe.Reader public.composite-content all"