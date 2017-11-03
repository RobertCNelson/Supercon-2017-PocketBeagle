#!/bin/bash -e

. system.sh

if [ "x${MMC}" = "x" ] ; then
	echo "Error, please set MMC in system.sh"
	exit 1
fi

sudo dd if=/dev/zero of=${MMC} bs=1M count=10
sudo dd if=./deploy/MLO of=${MMC} count=1 seek=1 bs=128k
sudo dd if=./deploy/u-boot.img of=${MMC} count=2 seek=1 bs=384k

sudo sfdisk ${MMC} <<-__EOF__
4M,,L,*
__EOF__

sudo mkfs.ext4 -L rootfs ${MMC}1

sleep 5

sudo mkdir -p /media/rootfs/

sudo mount ${MMC}1 /media/rootfs/

sleep 5

sudo tar xfvp ./rootfs/debian-*/armhf-rootfs-*.tar -C /media/rootfs/
sync
sudo chown root:root /media/rootfs/
sudo chmod 755 /media/rootfs/
