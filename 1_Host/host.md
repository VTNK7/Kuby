# Objective

Create a vagrant configuration that sets up ssh and ansible on vms
To be able to configure the jumpbox with ansible afterwards

# Commands
Vagrant up

Test ssh
ssh -i .vagrant/machines/jumpbox/virtualbox/private_key vagrant@192.168.56.10 

Test manual zscaler config
scp -r -i .vagrant/machines/master/virtualbox/private_key ./config_asset vagrant@192.168.56.100:/home/vagrant/
ssh -i .vagrant/machines/master/virtualbox/private_key vagrant@192.168.56.100 chmod +x ./config_asset/zscaler_setup.sh
ssh -i .vagrant/machines/master/virtualbox/private_key vagrant@192.168.56.100 ./config_asset/zscaler_setup.sh
ssh vagrant@192.168.56.100 /home/vagrant
ssh vagrant@192.168.56.102 


cd /etc/ansible
ansible-playbook playbooks/test.yml 
ansible-playbook playbooks/setup.yml 
vagrant reload



# Structure

ansible/
├── playbooks/
│   ├── setup-k8s.yml         
│   └── verify-k8s.yml         
│
├── roles        
│
├── inventory/
│   └── hosts.ini             
│
├── vars/
│   └── all.yml                
│
└── ansible.cfg