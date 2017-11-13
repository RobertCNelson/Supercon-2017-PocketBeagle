#!/bin/bash -e

web_mirror="http://rcn-ee.online/supercon/"

dl_web () {
	wget --progress=bar:force -c --directory-prefix=./${pre}/ ${web_mirror}${pre}/${file}
}

if [ ! -d ./rootfs ] ; then
	mkdir ./rootfs/
fi

if [ ! -d ./deploy ] ; then
	mkdir ./deploy/
fi

pre="rootfs"
file="debian-9.2-iot-armhf-2017-11-08.tar.xz"
dl_web

pre="deploy"
file="MLO"
dl_web

pre="deploy"
file="u-boot.img"
dl_web

pre="deploy"
file="zImage"
dl_web

pre="deploy"
file="modules.tar.gz"
dl_web

pre="deploy"
file="am335x-pocketbeagle.dtb"
dl_web

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


