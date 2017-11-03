#!/bin/bash -e

CORES=$(getconf _NPROCESSORS_ONLN)

export CC=`pwd`/toolchain/gcc-linaro-6.4.1-2017.08-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

cd ./u-boot/u-boot-2017.11-rc3/

if [ ! -f ./configs/am335x_pocketbeagle_defconfig ] ; then
	patch -p1 < ../0001-am335x_evm-uEnv.txt-bootz-n-fixes.patch
	patch -p1 < ../0002-U-Boot-BeagleBone-Cape-Manager.patch
fi

make ARCH=arm CROSS_COMPILE=${CC} distclean
make ARCH=arm CROSS_COMPILE=${CC} am335x_evm_defconfig
make -j${CORES} ARCH=arm CROSS_COMPILE=${CC}

if [ -f ./MLO ] ; then
	cp -v ./MLO ../../deploy/MLO
fi

if [ -f ./u-boot.img ] ; then
	cp -v ./u-boot.img ../../deploy/u-boot.img
fi

cd ../../

ls -lh ./deploy/
