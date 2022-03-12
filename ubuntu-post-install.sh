#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Ce script doit etre lancé en root"
  exit
fi

# Update
apt update

# Install all packages
apt install neovim
