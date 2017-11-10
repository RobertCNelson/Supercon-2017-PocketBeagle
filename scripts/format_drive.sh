#!/bin/bash -e
set -x
. system.sh

kill_systemd_service () {
	if [ -f /media/rootfs/lib/systemd/system/${service} ] ; then
		sudo rm -f /media/rootfs/lib/systemd/system/${service}
	fi
}

kill_system_service () {
	if [ -f /media/rootfs/etc/init.d/${service} ] ; then
		sudo rm -f /media/rootfs/etc/init.d/${service}
	fi
}

if [ "x${MMC}" = "x" ] ; then
	echo "Error, please set MMC in system.sh"
	exit 1
fi

sudo dd if=/dev/zero of=${MMC} bs=1M count=10

sudo sfdisk ${MMC} <<-__EOF__
4M,,L,*
__EOF__

sudo mkfs.ext4 -L rootfs ${MMC}1
