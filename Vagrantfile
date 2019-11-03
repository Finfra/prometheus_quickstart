# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu1804"
  config.vm.hostname = "p1"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
  
  config.vm.network "private_network", ip: "172.17.8.100"
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
  end
  config.vm.provision "shell", path: "install.sh", args: []
end
