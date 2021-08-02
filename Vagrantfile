# -*- mode: ruby -*-
# vi: set ft=ruby :

$number_of_control_plane_nodes = 3
$number_of_work_nodes = 3
$vm_control_plane_mem = "2048"
$vm_control_plane_cpus = 2
$vm_worker_node_mem = "1024"
$vm_worker_node_cpus = 1
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

  (1..$number_of_control_plane_nodes).each do |i|
    hostname = "centos8-control-plane-%02d" % i

    config.vm.define hostname do |node|
        node.vm.provider "virtualbox" do |vb|
            vb.memory = $vm_control_plane_mem
            vb.cpus = $vm_control_plane_cpus
            vb.gui = $vb_gui
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
            vb.customize [ "modifyvm", :id, "--paravirtprovider", "hyperv" ]
            vb.customize [ "modifyvm", :id, "--cpuexecutioncap", "100"]
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
            vb.memory = $vm_worker_node_mem
            vb.cpus = $vm_worker_node_cpus
            vb.gui = $vb_gui
            vb.customize [ "modifyvm", :id, "--uartmode1", "disconnected" ]
            vb.customize [ "modifyvm", :id, "--paravirtprovider", "hyperv" ]
            vb.customize [ "modifyvm", :id, "--cpuexecutioncap", "100"]
        end
      
        ip = $ip_range + "#{i+1100}"

        node.vm.network "private_network", ip: ip

        node.vm.hostname = hostname
    end
  end
end
