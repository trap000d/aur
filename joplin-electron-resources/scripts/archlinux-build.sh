set -e
makepkg -si -f
makepkg --printsrcinfo > .SRCINFO
