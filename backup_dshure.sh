#!/usr/bin/env sh

if [ -d '/Volumes/DATASHUR' ]; then
    a2scp desktop:\*.kdbx ~/BoxCryptor/security/keepass/
    zip -qr /Volumes/DATASHUR/keepass-$(date +"%Y%m%d").zip ~/Dropbox/keepass_main_db.*
    zip -qr /Volumes/DATASHUR/security-$(date +"%Y%m%d").zip ~/BoxCryptor/security/*
    zip -qr /Volumes/DATASHUR/archive-$(date +"%Y%m%d").zip ~/BoxCryptor/_Archive/*
fi
