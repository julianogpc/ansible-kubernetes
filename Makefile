export TERM=xterm-256color
export CLICOLOR_FORCE=true
export RICHGO_FORCE_COLOR=1

export ANSIBLE_CONFIG=./ansible/ansible.cfg
export DEFAULT_HOST_LIST=./ansible/hosts.yml

ANSIBLE_EXTRA_ARGS="--timeout=10"

.ONESHELL:

##########################################################
### Prepare
##########################################################
default: activate-venv

install-ansible:
	@ virtualenv venv
	@ . venv/bin/activate
	@ pip install -r ansible/requirements.txt

activate-venv:
	@ . venv/bin/activate

ping: activate-venv
	@ ansible -i ${DEFAULT_HOST_LIST} -m ping all


##########################################################
### Install
##########################################################
install-load-balancer: activate-venv
	@ ansible-playbook ansible/load_balancer.yml ${ANSIBLE_EXTRA_ARGS}

install-k8s: activate-venv
	@ ansible-playbook ansible/install.yml ${ANSIBLE_EXTRA_ARGS}


##########################################################
### Configuration
##########################################################
config-k8s-init-control-plane: activate-venv
	@ ansible-playbook ansible/config.yml --tags init-control-plane ${ANSIBLE_EXTRA_ARGS}

config-k8s-join-control-plane: activate-venv
	@ ansible-playbook ansible/config.yml --tags join-control-plane ${ANSIBLE_EXTRA_ARGS}

config-k8s-join-worker-node: activate-venv
	@ ansible-playbook ansible/config.yml --tags join-worker-node ${ANSIBLE_EXTRA_ARGS}


##########################################################
### Uninstall
##########################################################
reset-k8s: activate-venv
	@ ansible-playbook ansible/uninstall.yml ${ANSIBLE_EXTRA_ARGS}