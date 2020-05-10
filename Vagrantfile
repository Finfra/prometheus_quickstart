# -*- mode: ruby -*-
# vi: set ft=ruby :
SUBNET="172.17.8"

Vagrant.configure("2") do |config|
  # config.vm.box_check_update = false
  # config.vm.provider 'virtualbox' do |vb|
  #   vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
  # end
  #
  # # nowage Changed
  # #config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
  #
  $num_prometheus_instances = 1
  (1..$num_prometheus_instances).each do |i|
    config.vm.define "p#{i}" do |node|
      #node.vm.box = "lasp/ubuntu18.04"
      #node.vm.box = "bento/ubuntu-18.04"
      #node.vm.box = "generic/ubuntu1804"
      #node.vm.box = "ubuntu/xenial64"
      node.vm.box = "generic/ubuntu1804"
      node.vm.hostname = "p#{i}"
      ip = "#{SUBNET}.#{i+4}"
      node.vm.network "private_network", ip: ip
      node.vm.provider "virtualbox" do |vb|
          vb.name="p#{i}"
          vb.cpus = 1
          vb.memory = "2048"
      end
  #    node.vm.provision "shell", path: "install.sh", args:[1]
    end
  end

  $num_node_instances = 2
  (1..$num_node_instances).each do |i|
    config.vm.define "s#{i}" do |node|
      node.vm.box = "generic/ubuntu1804"
      node.vm.hostname = "s#{i}"
      ip = "#{SUBNET}.#{i+10}"
      node.vm.network "private_network", ip: ip
      node.vm.provider "virtualbox" do |vb|
          vb.name="s#{i}"
          vb.cpus = 1
          vb.memory = "2048"
      end
  #    node.vm.provision "shell", path: "install.sh", args:[2]
    end
  end

end
