#!/bin/bash -e

local_mirror="http://192.168.8.10/"

if [ ! -d ./toolchain ] ; then
	mkdir ./toolchain/
fi

if [ ! -d ./rootfs ] ; then
	mkdir ./rootfs/
fi

