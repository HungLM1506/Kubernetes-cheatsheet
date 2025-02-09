# Minimum configuration

| Hostname | OS | IP | RAM(Minimum) | CPU(Minimum) |
|----------|----|----|--------------|--------------|
|k8s-master-1 | Ubuntu 20.04 | 192.168.1.111 | 3G | 2 |
|k8s-master-2 | Ubuntu 20.04 | 192.168.1.112 | 3G | 2 |
|k8s-master-3 | Ubuntu 20.04 | 192.168.1.113 | 3G | 2 |

Network: Brigde 


# Install On-premise
## **Step 1: Add Host**
Perform on 3 servers
```bash
vi /etc/hosts
```
Configuration content
```
192.168.1.111 k8s-master-1
192.168.1.112 k8s-master-2
192.168.1.113 k8s-master-3
```

---

## **Step 2: Disable swap**
Temporarily off. When restarting the computer, it will automatically turn on.
```bash
sudo swapoff -a
```

To automatically turn off
```
sudo swapoff -a
sudo sed -i '/swap.img/s/^/#/' /etc/fstab
```

Verify off swap 
```
cat /etc/fstab
```

---

## **Step 3: Configuration module kernel**
```bash
vi /etc/modules-load.d/containerd.conf
```
Configuration content
```
overlay
br_netfilter
```

Download module kernel
```bash
sudo modprobe overlay
sudo modprobe br_netfilter
```
---

## **Step 4: Configuration network system**

```bash
echo "net.bridge.bridge-nf-call-ip6tables = 1" | sudo tee -a /etc/sysctl.d/kubernetes.conf
echo "net.bridge.bridge-nf-call-iptables = 1" | sudo tee -a /etc/sysctl.d/kubernetes.conf
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.d/kubernetes.conf
```

Apply config

```bash
sudo sysctl --system
```
---

## **Step 5: Install containerd**
Kubernetes needs a container runtime. We'll use **containerd** (recommended).

### **5.1: Install the necessary packages and add the Containerd repository**
```bash
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

Install containerd
```bash
sudo apt update -y
sudo apt install -y containerd.io
```

### **5.2: Configure containerd**
Generate the default configuration file:
```bash
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml
```

Restart containerd:
```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
```

---

## **Step 6: Install Kubernetes Components**
Install **kubeadm**, **kubelet**, and **kubectl**.

### **6.1: Add the Kubernetes APT repository**
```bash
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```
If `/etc/apt/keyrings` not exist, you can create it
```bash
mkdir /etc/apt/keyrings
```


### **6.2: Install kubeadm, kubelet, and kubectl**
```bash
sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

---

## **Step 7: Initialize the Kubernetes Cluster (1 master node and 2 worker nodes)**

![Kubernetes Architecture 1-master-2-worker](/images/1-master-2worker.png)

Run the following command on the **k8s-master-1**:
```bash
sudo kubeadm init
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
```

Run the following command on the **k8s-master-2** and **k8s-master-3**
```bash
sudo kubeadm join 192.168.1.111:6443 --token your_token --discovery-token-ca-cert-hash your_sha
```


---

## **Step 8: Initialize the Kubernetes Cluster (3 master-worker nodes)**
![Kubernetes Architecture 3-master-worker](/images/3-master-worker.png)
### **8.1: Perform in k8s-master-1**
```bash
sudo kubeadm init --control-plane-endpoint "192.168.1.111:6443" --upload-certs
mkdir -p $HOME/.kube 
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
```

### **8.1: Perform in k8s-master-2 and k8s-master-3**
```bash
sudo kubeadm join 192.168.1.111:6443 --token your_token --discovery-token-ca-cert-hash your_sha --control-plane --certificate-key your_cert
mkdir -p $HOME/.kube 
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config 
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

---

## **Step 9: Verify the Cluster**
### **9.1: Check Nodes**
On the master node, check the status of nodes:
```bash
kubectl get nodes
```

### **9.2: Check Pods**
Verify that the cluster is working by checking pods in the `kube-system` namespace:
```bash
kubectl get pods -n kube-system
```

---

## **Optional: Enable Autocompletion for kubectl**
```bash
sudo apt install -y bash-completion
echo 'source <(kubectl completion bash)' >>~/.bashrc
source ~/.bashrc
```

---

## **Troubleshooting Tips**
1. **Reset the Cluster**  
   If the installation fails, reset kubeadm and try again:
   ```bash
   sudo kubeadm reset -f
   sudo rm -rf /var/lib/etcd
   sudo rm -rf /etc/kubernetes/manifests/*
   ```

2. **Check Logs**  
   Use the following commands to troubleshoot issues:
   ```bash
   journalctl -xeu kubelet
   kubectl describe pod <pod-name> -n kube-system
   ```

---

This guide provides a basic Kubernetes cluster installation. For production, consider high-availability setups, security configurations, and monitoring tools. Let me know if you'd like additional details!

## By [HungLM](https://www.github.com/HungLM1506)