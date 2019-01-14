#!/bin/bash
  
  su -l $(/usr/local/bin/currentuser) -c "/usr/local/bin/duti -s com.adobe.Reader com.adobe.pdf all"
  su -l $(/usr/local/bin/currentuser) -c "/usr/local/bin/duti -s com.adobe.Reader public.composite-content all"