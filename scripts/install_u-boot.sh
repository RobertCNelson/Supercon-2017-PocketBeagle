#!/bin/bash -e

. system.sh

if [ "x${MMC}" = "x" ] ; then
	echo "Error, please set MMC in system.sh"
	exit 1
fi

sudo dd if=/dev/zero of=${MMC} bs=1M count=10

if [ -f ./deploy/MLO ] ; then
	sudo dd if=./deploy/MLO of=${MMC} count=1 seek=1 bs=128k
fi
if [ -f ./deploy/u-boot.img ] ; then
	sudo dd if=./deploy/u-boot.img of=${MMC} count=2 seek=1 bs=384k
fi

sync
