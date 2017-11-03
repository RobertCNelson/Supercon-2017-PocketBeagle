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

sudo sfdisk ${MMC} <<-__EOF__
4M,,L,*
__EOF__

sudo mkfs.ext4 -L rootfs ${MMC}1

sleep 5

sudo mkdir -p /media/rootfs/

sudo mount ${MMC}1 /media/rootfs/

sleep 5

if [ -f ./rootfs/debian-*/armhf-rootfs-*.tar ] ; then
	sudo tar xfvp ./rootfs/debian-*/armhf-rootfs-*.tar -C /media/rootfs/
	sync
	sudo chown root:root /media/rootfs/
	sudo chmod 755 /media/rootfs/

	sudo sh -c "echo 'uname_r=4.14.0-rc7-bone3' > /media/rootfs/boot/uEnv.txt"
	sudo sh -c "echo '/dev/mmcblk0p1  /  auto  errors=remount-ro  0  1' > /media/rootfs/etc/fstab"

	if [ -f ./deploy/zImage ] ; then
		sudo cp -v ./deploy/zImage /media/rootfs/boot/vmlinuz-4.14.0-rc7-bone3
	fi

	if [ -f ./deploy/am335x-pocketbeagle.dtb ] ; then
		if [ ! -d /media/rootfs/boot/dtbs/4.14.0-rc7-bone3/ ] ; then
			sudo mkdir -p /media/rootfs/boot/dtbs/4.14.0-rc7-bone3/
		fi
		sudo cp -v ./deploy/am335x-pocketbeagle.dtb /media/rootfs/boot/dtbs/4.14.0-rc7-bone3/
	fi
fi

sync
sudo umount /media/rootfs
