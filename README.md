# Objective
Craft a kube cluster


Create a vagrant configuration that sets up ssh and ansible on vms
To be able to configure the jumpbox with ansible afterwards

# Setup

Installer virtualbox
Installer vagrant

Pour créer les vm avec vagrant sur virtualbox :
vagrant up

Pour se connecter aux vm :
vagrant ssh nomvm

Faire le script de paul pour le certificat ssl/tls

Copier le certificat zscaler.cer et le script zscaler_setup.sh sur les machines dans home/vagrant

chmod +x ./zscaler_setup.sh
./zscaler_setup.sh

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

# Tests

vagrant up
vagrant ssh jumpbox
cd /etc/ansible
ansible-playbook playbooks/setup.yml 

vagrant ssh master
kubectl get nodes
kubectl get pods --all-namespaces

kubectl create deployment nginx-dep --image=nginx
kubectl expose deployment nginx-dep --type=NodePort --port=80

kubectl get deployments
kubectl get services

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

# Bugs

fixed : zscaler_setup must be CF and not CRLF

timeout during calisto waiting


# ArgoCD

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pod -n argocd 
kubectl get svc -n argocd

## Port forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl rollout restart deployment -n argocd

Error : root@master:/home/vagrant# kubectl port-forward svc/argocd-server -n argocd 8080:443
error: error upgrading connection: unable to upgrade connection: pod does not exist

## Load Balancer
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc argocd-server -n argocd
https://<ipmaster>:<portsvc>/

## Login
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

admin
password

## conf

Add gitlab repo with ssh
Create app

kubectl create namespace dekans
kubectl get deployments -n dekans

http://<ipmaster>:<nodeport>
http://192.168.56.106:30007

# State

Curent argocd working with base image nginx and docker file

