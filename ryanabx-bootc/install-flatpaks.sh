#!/usr/bin/bash

# Install flatpaks from list

xargs -a flatpaks.txt -r -- flatpak install -y