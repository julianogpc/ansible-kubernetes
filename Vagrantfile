# -*- mode: ruby -*-
# vi: set ft=ruby :

$number_of_master_nodes = 3
$number_of_work_nodes = 3
$vm_mem = "2048"
$vm_cpus = 2
$vb_gui = false
$ansible_install_mode = "pip"
$ansible_version = "2.7.9"
$project_src = "/vagrant/"
$compatibility_mode = "2.0"
$ip_range="172.19.8."


# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.require_version ">= 2.0.2"

Vagrant.configure(2) do |config|
  config.vm.box = "generic/centos8"
  config.vm.box_version = "3.3.2"

  (1..$number_of_master_nodes).each do |i|
    hostname = "centos8-master-%02d" % i

    config.vm.define hostname do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.memory = $vm_mem
            vb.cpus = $vm_cpus
            vb.gui = $vb_gui
            vb.customize [ "modifyvm", :id, "--paravirtprovider", "hyperv" ]
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
        end
      
        ip = $ip_range + "#{i+100}"

        node.vm.network "private_network", ip: ip

        node.vm.hostname = hostname
    end
  end

  (1..$number_of_work_nodes).each do |i|
    hostname = "centos8-worker-node-%02d" % i

    config.vm.define hostname do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.memory = $vm_mem
            vb.cpus = $vm_cpus
            vb.gui = $vb_gui
            vb.customize [ "modifyvm", :id, "--paravirtprovider", "hyperv" ]
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
        end
      
        ip = $ip_range + "#{i+150}"

        node.vm.network "private_network", ip: ip

        node.vm.hostname = hostname
    end
  end
end
