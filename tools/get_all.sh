#!/bin/bash -e

local_mirror="http://192.168.8.10/"
web_mirror="http://rcn-ee.online/supercon/"

dl_web () {
	wget -c --directory-prefix=./${pre}/ ${web_mirror}${pre}/${file}
}

dl_local () {
	wget --timeout=2 --tries=2 -c --directory-prefix=./${pre}/ ${local_mirror}${pre}/${file} || dl_web
}

if [ ! -d ./toolchain ] ; then
	mkdir ./toolchain/
fi

if [ ! -d ./rootfs ] ; then
	mkdir ./rootfs/
fi

if [ ! -f ./toolchain/gcc-linaro-6.4.1-2017.08-x86_64_arm-linux-gnueabihf.tar.xz ] ; then
	pre="toolchain"
	file="gcc-linaro-6.4.1-2017.08-x86_64_arm-linux-gnueabihf.tar.xz"
	dl_local
fi

if [ ! -f ./linux/linux-4.14-rc7.tar.gz ] ; then
	pre="linux"
	file="linux-4.14-rc7.tar.gz"
	dl_local
fi

if [ ! -f ./u-boot/u-boot-2017.11-rc3.tar.bz2 ] ; then
	pre="u-boot"
	file="u-boot-2017.11-rc3.tar.bz2"
	dl_local
fi

if [ ! -f ./rootfs/debian-9.2-iot-armhf-2017-11-02.tar.xz ] ; then
	pre="rootfs"
	file="debian-9.2-iot-armhf-2017-11-02.tar.xz"
	dl_local
fi
