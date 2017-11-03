#!/bin/bash -e

export CC=`pwd`/toolchain/gcc-linaro-6.4.1-2017.08-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

cd ./linux/linux-4.14-rc7/

if [ ! -f ./arch/arm/configs/rcn-ee_defconfig ] ; then
	patch -p1 < ../patch-4.14-rc7-bone3.diff
fi

make ARCH=arm CROSS_COMPILE=${CC} distclean
cp -v ../defconfig ./.config
make ARCH=arm CROSS_COMPILE=${CC} menuconfig
cp -v ./.config ../defconfig
make -j3 ARCH=arm CROSS_COMPILE=${CC} zImage modules
#make ARCH=arm CROSS_COMPILE=${CC} zImage modules
make ARCH=arm CROSS_COMPILE=${CC} dtbs
cd ../../
