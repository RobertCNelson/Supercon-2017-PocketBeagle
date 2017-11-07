#!/bin/bash -e

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

if [ ! -d /media/rootfs/ ] ; then
	sudo mkdir -p /media/rootfs/
fi

sudo mount ${MMC}1 /media/rootfs/ || true

sleep 5

if [ -f /media/rootfs/etc/fstab ] ; then
	sudo sh -c "echo 'uname_r=4.14.0-rc8-bone3' > /media/rootfs/boot/uEnv.txt"
	sudo sh -c "echo 'cmdline=coherent_pool=1M net.ifnames=0 quiet' >> /media/rootfs/boot/uEnv.txt"

	sudo sh -c "echo '/dev/mmcblk0p1  /  auto  errors=remount-ro  0  1' > /media/rootfs/etc/fstab"

	if [ -f ./deploy/zImage ] ; then
		echo "Copying zImage"
		sudo cp -v ./deploy/zImage /media/rootfs/boot/vmlinuz-4.14.0-rc8-bone3
	fi

	if [ -f ./deploy/am335x-pocketbeagle.dtb ] ; then
		if [ ! -d /media/rootfs/boot/dtbs/4.14.0-rc8-bone3/ ] ; then
			sudo mkdir -p /media/rootfs/boot/dtbs/4.14.0-rc8-bone3/
		fi
		echo "Copying Device Tree Binary"
		sudo cp -v ./deploy/am335x-pocketbeagle.dtb /media/rootfs/boot/dtbs/4.14.0-rc8-bone3/
	fi

	if [ -f ./deploy/modules.tar.gz ] ; then
		echo "Copying Modules"
		sudo tar xf ./deploy/modules.tar.gz -C /media/rootfs/
	fi

	sync

	service="alsa-restore.service" ; kill_systemd_service
	service="alsa-state.service" ; kill_systemd_service
	service="alsa-utils.service" ; kill_systemd_service
	service="apache2.service" ; kill_systemd_service
	service="apache2@.service" ; kill_systemd_service
	service="apt-daily.service" ; kill_systemd_service
	service="apt-daily.timer" ; kill_systemd_service
	service="apt-daily-upgrade.service" ; kill_systemd_service
	service="apt-daily-upgrade.timer" ; kill_systemd_service
	service="avahi-daemon.service" ; kill_systemd_service
	service="avahi-daemon.socket" ; kill_systemd_service
	service="bb-wl18xx-bluetooth.service" ; kill_systemd_service
	service="bb-wl18xx-wlan0.service" ; kill_systemd_service
	service="beagle-tester.service" ; kill_systemd_service
	service="bluetooth.service" ; kill_systemd_service
	service="bonescript-autorun.service" ; kill_systemd_service
	service="bonescript.service" ; kill_systemd_service
	service="bonescript.socket" ; kill_systemd_service
	service="capemgr.service" ; kill_systemd_service
	service="cloud9.service" ; kill_systemd_service
	service="cloud9.socket" ; kill_systemd_service
	service="connman-wait-online.service" ; kill_systemd_service
	service="node-red.service" ; kill_systemd_service
	service="node-red.socket" ; kill_systemd_service
	service="pppd-dns.service" ; kill_systemd_service
	service="rc_battery_monitor.service" ; kill_systemd_service
	service="roboticscape.service" ; kill_systemd_service
	service="wpa_supplicant.service" ; kill_systemd_service
	service="wpa_supplicant@.service" ; kill_systemd_service

	service="alsa-utils" ; kill_system_service
	service="apache2" ; kill_system_service
	service="apache-htcacheclean" ; kill_system_service
	service="avahi-daemon" ; kill_system_service
	service="bluetooth" ; kill_system_service
	service="cpufrequtils" ; kill_system_service
	service="pppd-dns" ; kill_system_service
fi

sync
sudo umount /media/rootfs
