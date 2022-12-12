mkimage -T script -d boot_arch_kernel.txt boot_arch_kernel.scr
cp boot.scr boot.scr.back
cp boot_arch_kernel.scr boot.scr
