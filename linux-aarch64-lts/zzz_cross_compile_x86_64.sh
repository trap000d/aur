#! /bin/bash


REP=~/src/arch/aur/linux-aarch64-lts
VER="6.12.65"
OLDPWD=$PWD
sed -i "s/^pkgver=.*/pkgver=$VER/" PKGBUILD

awk -v newsums="$(makepkg -g)" '
BEGIN {
  if (!newsums) exit 1
}

/^[[:blank:]]*(md|sha)[[:digit:]]+sums=/,/\)[[:blank:]]*$/ {
  if (!i) print newsums; i++
  next
}

1
' PKGBUILD > PKGBUILD.new && mv PKGBUILD{.new,}

# This is a compiler wrapper for cross building kernel on x86_64 computer
# sudo pacman -S \
# aarch64-linux-gnu-binutils
# aarch64-linux-gnu-gcc
# aarch64-linux-gnu-gdb
# aarch64-linux-gnu-glibc
# aarch64-linux-gnu-linux-api-headers

CARCH=aarch64 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- makepkg -cCAf && \
makepkg --printsrcinfo > .SRCINFO

RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo "Buid success, pushing to Github"
  cd $REP && git pull && cd $OLDPWD
  cp 0001-net-smsc95xx-Allow-mac-address-to-be-set-as-a-parame.patch \
     0002-arm64-dts-rockchip-disable-pwm0-on-rk3399-firefly.patch    \
     0003-pps-Compatibility-hack-should-be-X86-specific.patch        \
     config                                                          \
     generate_chromebook_its.sh                                      \
     kernel_data_key.vbprivk                                         \
     kernel.keyblock                                                 \
     linux-aarch64-lts-chromebook.install                            \
     linux-aarch64-lts.install                                       \
     linux.preset                                                    \
     PKGBUILD                                                        \
     zzz_cross_compile_x86_64.sh                                     \
     $REP

  cd $REP
  git add .
  git commit -m "v$VER"
  git push
  cd $OLDPWD
else
  echo "Build failed"
fi
