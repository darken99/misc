#!/bin/bash

ENCFS="/usr/local/bin/encfs" 
ENCDIR="$HOME/Library/CloudStorage/Dropbox/Boxcryptor Classic.bc"
DECDIR="$HOME/BoxCryptor"

security find-generic-password -ga encfs 2>&1 >/dev/null | cut -d'"' -f2 | "$ENCFS" -S "$ENCDIR" "$DECDIR"
