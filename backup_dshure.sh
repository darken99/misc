#!/bin/env sh

if [ -d '/Volumes/DATASHUR' ]; then
    a2scp desktop:\*.kdbx ~/BoxCryptor/security/keepass/
    zip -r /Volumes/DATASHUR/keepass-$(date +"%Y%m%d").zip ~/Dropbox/keepass_main_db.*
    zip -r /Volumes/DATASHUR/security-$(date +"%Y%m%d").zip ~/BoxCryptor/security/*
    zip -r /Volumes/DATASHUR/archive-$(date +"%Y%m%d").zip ~/BoxCryptor/_Archive/*
fi
