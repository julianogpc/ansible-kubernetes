export TERM=xterm-256color
export CLICOLOR_FORCE=true
export RICHGO_FORCE_COLOR=1

export ANSIBLE_CONFIG=./ansible/ansible.cfg
export DEFAULT_HOST_LIST=./ansible/hosts.yml

ANSIBLE_EXTRA_ARGS=""

.ONESHELL:

default: prepare

install-ansible:
	@ virtualenv venv
	@ . venv/bin/activate
	@ pip install -r ansible/requirements.txt

prepare:
	@ . venv/bin/activate

ping: prepare
	@ ansible -i ${DEFAULT_HOST_LIST} -m ping all ${ANSIBLE_EXTRA_ARGS}

install-load-balancer: prepare
	@ ansible-playbook ansible/load_balancer.yml ${ANSIBLE_EXTRA_ARGS}

install-k8s: prepare
	@ ansible-playbook ansible/install.yml ${ANSIBLE_EXTRA_ARGS}

install-k8s-work-node: prepare
	@ ansible-playbook ansible/config_work_node.yml ${ANSIBLE_EXTRA_ARGS}

config-k8s-init-control-plane: prepare
	@ ansible-playbook ansible/config.yml --tags init-control-plane ${ANSIBLE_EXTRA_ARGS}

config-k8s-join-control-plane: prepare
	@ ansible-playbook ansible/config.yml --tags join-control-plane ${ANSIBLE_EXTRA_ARGS}

config-k8s-join-worker-node: prepare
	@ ansible-playbook ansible/config.yml --tags join-worker-node ${ANSIBLE_EXTRA_ARGS}

config-k8s-all: prepare
	@ ansible-playbook ansible/config.yml --tags="init-control-plane,join-control-plane,join-worker-node" ${ANSIBLE_EXTRA_ARGS}

reset-k8s: prepare
	@ ansible-playbook ansible/uninstall.yml