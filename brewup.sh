#!/bin/sh
set -e

brew="/usr/local/bin/brew"
${brew} update || true
${brew} upgrade
${brew} upgrade --cask
${brew} upgrade --cask `${brew} list --cask`
${brew} cleanup
