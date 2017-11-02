#!/bin/bash -e

local_mirror="http://192.168.8.10/"

if [ ! -d ./toolchain ] ; then
	mkdir ./toolchain/
fi

if [ ! -d ./rootfs ] ; then
	mkdir ./rootfs/
fi

http://192.168.8.10/toolchain/gcc-linaro-6.4.1-2017.08-x86_64_arm-linux-gnueabihf.tar.xz
http://192.168.8.10/linux/linux-4.14-rc7.tar.gz
http://192.168.8.10/u-boot/u-boot-2017.11-rc3.tar.bz2
http://192.168.8.10/rootfs/debian-9.2-iot-armhf-2017-11-02.tar.xz
