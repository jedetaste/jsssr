#!/bin/sh

    # Searches for locally installed printers and deletes them
    
    for file in /etc/cups/ppd/*
        do
            path=${file%.ppd}
            name=${path##*/}
            lpadmin -x "${name}"
        done
    
exit 0