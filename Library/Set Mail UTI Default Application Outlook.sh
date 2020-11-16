#!/bin/bash

su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/duti -s com.microsoft.outlook mailto"
su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/duti -s com.microsoft.outlook ics all"
su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/duti -s com.microsoft.outlook vcf all"
