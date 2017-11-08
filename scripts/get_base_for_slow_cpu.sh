#!/bin/bash -e

local_mirror="http://192.168.8.10/"
web_mirror="http://rcn-ee.online/supercon/"

dl_web () {
	wget -c --directory-prefix=./${pre}/ ${web_mirror}${pre}/${file}
}

dl_local () {
	if [ ! -f ./${pre}/${file} ] ; then
		wget --timeout=2 --tries=2 -c --directory-prefix=./${pre}/ ${local_mirror}${pre}/${file} || dl_web
	fi
}

if [ ! -d ./rootfs ] ; then
	mkdir ./rootfs/
fi

if [ ! -d ./deploy ] ; then
	mkdir ./deploy/
fi

pre="rootfs"
file="debian-9.2-iot-armhf-2017-11-08.tar.xz"
dl_local

pre="deploy"
file="MLO"
dl_local

pre="deploy"
file="u-boot.img"
dl_local

pre="deploy"
file="zImage"
dl_local

pre="deploy"
file="modules.tar.gz"
dl_local

pre="deploy"
file="am335x-pocketbeagle.dtb"
dl_local

if [ -f ./rootfs/debian-9.2-iot-armhf-2017-11-08/armhf-rootfs-debian-stretch.tar ] ; then
	rm -rf ./rootfs/debian-9.2-iot-armhf-2017-11-08/ || true
	echo "extracting: debian-9.2-iot-armhf-2017-11-08.tar.xz"
	cd ./rootfs/
	tar xf debian-9.2-iot-armhf-2017-11-08.tar.xz
	cd ../
else
	echo "extracting: debian-9.2-iot-armhf-2017-11-08.tar.xz"
	cd ./rootfs/
	tar xf debian-9.2-iot-armhf-2017-11-08.tar.xz
	cd ../
fi


