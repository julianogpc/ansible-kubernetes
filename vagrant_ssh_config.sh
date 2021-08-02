#!/bin/bash

vagrant ssh-config centos8-control-plane-01 > ansible/centos8-control-plane-01.cfg 
vagrant ssh-config centos8-control-plane-02 > ansible/centos8-control-plane-02.cfg 
vagrant ssh-config centos8-control-plane-03 > ansible/centos8-control-plane-03.cfg 

vagrant ssh-config centos8-work-node-01 > ansible/centos8-work-node-01.cfg 
vagrant ssh-config centos8-work-node-02 > ansible/centos8-work-node-02.cfg 
vagrant ssh-config centos8-work-node-03 > ansible/centos8-work-node-03.cfg 