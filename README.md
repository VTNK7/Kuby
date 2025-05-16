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

zscaler_setup must be CF and not CRLF


TASK [k8s_worker : Join worker node to Kubernetes cluster] ***************************************************************************
fatal: [worker-2]: FAILED! => {"changed": true, "cmd": "kubeadm join 192.168.56.106:6443 --token zk15d3.imp3iiqrc53mevyf --discovery-token-ca-cert-hash sha256:cf782ef30abf3d38f940c1035df8326a43d3fc5bc93e5889b750bbeb98c618de ", "delta": "0:01:31.224433", "end": "2025-05-16 16:12:44.119715", "msg": "non-zero return code", "rc": 1, "start": "2025-05-16 16:11:12.895282", "stderr": "error execution phase kubelet-wait-bootstrap: error writing CRISocket for this node: Get \"https://192.168.56.106:6443/api/v1/nodes/worker-2?timeout=10s\": context deadline exceeded\nTo see the stack trace of this error execute with --v=5 or higher", "stderr_lines": ["error execution phase kubelet-wait-bootstrap: error writing CRISocket for this node: Get \"https://192.168.56.106:6443/api/v1/nodes/worker-2?timeout=10s\": context deadline exceeded", "To see the stack trace of this error execute with --v=5 or higher"], "stdout": "[preflight] Running pre-flight checks\n[preflight] Reading configuration from the \"kubeadm-config\" ConfigMap in namespace \"kube-system\"...\n[preflight] Use 'kubeadm init phase upload-config --config your-config-file' to re-upload it.\n[kubelet-start] Writing kubelet configuration to file \"/var/lib/kubelet/config.yaml\"\n[kubelet-start] Writing kubelet environment file with flags to file \"/var/lib/kubelet/kubeadm-flags.env\"\n[kubelet-start] Starting the kubelet\n[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s\n[kubelet-check] The kubelet is healthy after 1.504340755s\n[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap", "stdout_lines": ["[preflight] Running pre-flight checks", "[preflight] Reading configuration from the \"kubeadm-config\" ConfigMap in namespace \"kube-system\"...", "[preflight] Use 'kubeadm init phase upload-config --config your-config-file' to re-upload it.", "[kubelet-start] Writing kubelet configuration to file \"/var/lib/kubelet/config.yaml\"", "[kubelet-start] Writing kubelet environment file with flags to file \"/var/lib/kubelet/kubeadm-flags.env\"", "[kubelet-start] Starting the kubelet", "[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s", "[kubelet-check] The kubelet is healthy after 1.504340755s", "[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap"]}
fatal: [worker-1]: FAILED! => {"changed": true, "cmd": "kubeadm join 192.168.56.106:6443 --token zk15d3.imp3iiqrc53mevyf --discovery-token-ca-cert-hash sha256:cf782ef30abf3d38f940c1035df8326a43d3fc5bc93e5889b750bbeb98c618de ", "delta": "0:01:31.304831", "end": "2025-05-16 16:12:44.100033", "msg": "non-zero return code", "rc": 1, "start": "2025-05-16 16:11:12.795202", "stderr": "error execution phase kubelet-wait-bootstrap: error writing CRISocket for this node: Get \"https://192.168.56.106:6443/api/v1/nodes/worker-1?timeout=10s\": net/http: request canceled (Client.Timeout exceeded while awaiting headers)\nTo see the stack trace of this error execute with --v=5 or higher", "stderr_lines": ["error execution phase kubelet-wait-bootstrap: error writing CRISocket for this node: Get \"https://192.168.56.106:6443/api/v1/nodes/worker-1?timeout=10s\": net/http: request canceled (Client.Timeout exceeded while awaiting headers)", "To see the stack trace of this error execute with --v=5 or higher"], "stdout": "[preflight] Running pre-flight checks\n[preflight] Reading configuration from the \"kubeadm-config\" ConfigMap in namespace \"kube-system\"...\n[preflight] Use 'kubeadm init phase upload-config --config your-config-file' to re-upload it.\n[kubelet-start] Writing kubelet configuration to file \"/var/lib/kubelet/config.yaml\"\n[kubelet-start] Writing kubelet environment file with flags to file \"/var/lib/kubelet/kubeadm-flags.env\"\n[kubelet-start] Starting the kubelet\n[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s\n[kubelet-check] The kubelet is healthy after 1.504318378s\n[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap", "stdout_lines": ["[preflight] Running pre-flight checks", "[preflight] Reading configuration from the \"kubeadm-config\" ConfigMap in namespace \"kube-system\"...", "[preflight] Use 'kubeadm init phase upload-config --config your-config-file' to re-upload it.", "[kubelet-start] Writing kubelet configuration to file \"/var/lib/kubelet/config.yaml\"", "[kubelet-start] Writing kubelet environment file with flags to file \"/var/lib/kubelet/kubeadm-flags.env\"", "[kubelet-start] Starting the kubelet", "[kubelet-check] Waiting for a healthy kubelet at http://127.0.0.1:10248/healthz. This can take up to 4m0s", "[kubelet-check] The kubelet is healthy after 1.504318378s", "[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap"]}

PLAY RECAP ***************************************************************************************************************************
jumpbox_host               : ok=55   changed=27   unreachable=0    failed=0    skipped=12   rescued=0    ignored=0
master_host                : ok=67   changed=33   unreachable=0    failed=0    skipped=12   rescued=0    ignored=0
worker-1                   : ok=57   changed=27   unreachable=0    failed=1    skipped=12   rescued=0    ignored=0
worker-2                   : ok=57   changed=27   unreachable=0    failed=1    skipped=12   rescued=0    ignored=0

vagrant@jumpbox:/etc/ansible$ 