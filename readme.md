# Supercon 2017 PocketBeagle Workshop

## Hardware

Part List: http://www.digikey.com/short/qt08d7

## Setup

The development environment is contained inside a Linux virtual machine. The contents of the current directory are shared/mounted inside the VM at `/vagrant`.

1. Install [VirtualBox 5.1.x](https://www.virtualbox.org/wiki/Download_Old_Builds_5_1) (don't use 5.2.x) and Extension Pack
   - You can also use libvirt or VMware (with a paid plug-in)
1. Install [Vagrant](https://www.vagrantup.com/downloads.html) >= 2.0.1
1. Open Terminal
   - Windows: Open a command prompt as Administrator (in order for symlinks in /vagrant to work)
1. Run `vagrant up`

## Build

1. `vagrant ssh -c "cd Supercon-2017-PocketBeagle; ./scripts/build_u-boot.sh"`
1. `vagrant ssh -c "cd Supercon-2017-PocketBeagle; ./scripts/build_linux.sh"`

## Usage

1. `vagrant ssh`
