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
ansible-playbook playbooks/test_ssh.yml 
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


# Prompts

## Context

Current Setup:

You have a Kubernetes cluster created using kubeadm, kubectl, Vagrant, and Ansible.
Your cluster consists of:
    1 jumpbox running Ansible
    1 master node
    2 worker nodes

Goals:
    CI Pipeline with GitLab:
        You want to use a repository (repoA) to build a Docker image.
        Push the built Docker image to a container registry.
    CD Pipeline with ArgoCD:
        Use a configuration repository (repoB) to manage Kubernetes manifests.
        Deploy new images to the Kubernetes cluster based on updates in repoB.

Pour lancer ansible directement apres vagrant :
RUN_ANSIBLE=true vagrant up


power shell : 
$env:RUN_ANSIBLE="true"; vagrant up