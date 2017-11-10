# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "4"

    vb.memory = "2048"
 
    # support symlinks in /vagrant (on Windows this required starting vagrant in an Admin shell)
    vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant", "1"]

    # support USB
    # if your system has USB 3.0 you *may* need to enable the xHCI controller
    vb.customize ["modifyvm", :id, "--usb", "on"]
    vb.customize ["modifyvm", :id, "--usbehci", "on"]
    #vb.customize ["modifyvm", :id, "--usbxhci", "on"]

    # share the USB microSD card reader with the VM
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'Generic USB Storage', '--vendorid', '05e3', '--productid', '0743']

  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y libncurses5-dev bc

    # Do a clean checkout and build inside VM.
    # Cannot use shared folder because Windows don't support symlinks (without admin rights) and mmap (mkimage fails).
    cd /home/vagrant
    sudo -u vagrant -H git clone https://github.com/lucasrangit/Supercon-2017-PocketBeagle.git 
    cd Supercon-2017-PocketBeagle
    sudo -u vagrant ./scripts/get_all.sh
  SHELL
end
