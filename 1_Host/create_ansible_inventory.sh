#!/bin/bash
# create_ansible_inventory.sh
# config a lancé depuis jumpbox


cat > /home/vagrant/inventory.ini << EOF
[jumpbox]
jumpbox ansible_connection=local

[master]
master ansible_host=192.168.56.100

[workers]
worker-1 ansible_host=192.168.56.101
worker-2 ansible_host=192.168.56.102

[k8s_cluster:children]
master
workers

[all:vars]
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/.ssh/id_rsa
ansible_python_interpreter=/usr/bin/python3
EOF

# Créer un fichier ansible.cfg
cat > /home/vagrant/ansible.cfg << EOF
[defaults]
inventory = ./inventory.ini
host_key_checking = False
EOF

chown vagrant:vagrant /home/vagrant/inventory.ini /home/vagrant/ansible.cfg