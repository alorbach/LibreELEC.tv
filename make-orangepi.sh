#!/bin/sh

# Build Images
#export PROJECT=H3 SYSTEM=opipc ARCH=arm
#make image
export PROJECT=H3 SYSTEM=opilite ARCH=arm
make image
#export PROJECT=H3 SYSTEM=opione ARCH=arm
#make image

# Build Addons
#export PROJECT=H3 ARCH=arm 
#scripts/create_addon hyperion
#scripts/create_addon oscam
