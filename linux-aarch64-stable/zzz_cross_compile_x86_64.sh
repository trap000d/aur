#! /bin/bash

# This is a compiler wrapper for cross building kernel on x86_64 computer

CARCH=aarch64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- makepkg -cCAf && \
makepkg --printsrcinfo > .SRCINFO
