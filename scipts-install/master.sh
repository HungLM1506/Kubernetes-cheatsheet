#!/bin/bash

echo  " _   _ _                 _                    _ _   _       _    ___       "
echo  "| | | | |__  _   _ _ __ | |_ _   _  __      _(_) |_| |__   | | _( _ ) ___  "
echo  "| | | | '_ \| | | | '_ \| __| | | | \ \ /\ / / | __| '_ \  | |/ / _ \/ __| "
echo  "| |_| | |_) | |_| | | | | |_| |_| |  \ V  V /| | |_| | | | |   < (_) \__ \ "
echo  " \___/|_.__/ \__,_|_| |_|\__|\__,_|   \_/\_/ |_|\__|_| |_| |_|\_\___/|___/ "

echo  

echo  " __  __           _              _   _           _       "
echo  "|  \/  | __ _ ___| |_ ___ _ __  | \ | | ___   __| | ___  "
echo  "| |\/| |/ _\` / __| __/ _ \ '__| |  \| |/ _ \ / _\` |/ _ \ "
echo  "| |  | | (_| \__ \ ||  __/ |    | |\  | (_) | (_| |  __/ "
echo  "|_|  |_|\__,_|___/\__\___|_|    |_| \_|\___/ \__,_|\___| "

sleep 5

echo  
echo "**** Config node master with k8s, Docker and Helm *****"
echo   

echo 
echo "**** update repository package ****"
echo

sudo apt-get update -y

echo 
echo "**** disable swap ****"
echo 

sudo swapoff -a
sudo cp /etc/fstab /etc/fstab.bkp
sudo sed -i.bak '/ swap / s/^\(.*\)$/#/g' /etc/fstab

echo 
echo "**** install docker ****"
echo

# code 




echo 
echo "**** install repository packages kubernetes ****"
echo 


# sudo apt-get install -y ca-certificates curl
# sudo apt-get install -y apt-transport-https

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo
echo "**** update repository package ****"
echo 

sudo apt-get update -y

echo 
echo "**** install kubectl, kubeadm and kubelet ****"
echo 

sudo apt-get -y install kubectl
sudo apt-get -y install kubeadm
sudo apt-get -y install kubelet

# optipnal
sudo apt-mark hold kubelet kubeadm kubectl

echo 
echo "**** init cluster ****"
echo

# init kubeadm
kubeadm config images pull
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo 
echo "**** autocompletion kubectl ****"
echo 

echo "source <(kubectl completion bash)" >> $HOME/.bashrc

echo
echo "**** pod network - calico ****"  
echo

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo 
echo "**** install helm ****"
echo 

curl -L https://git.io/get_helm.sh | bash

helm init

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'


echo 
echo "**** view status cluster ****"
echo

kubectl get nodes,svc,deploy,rs,rc,po -o wide

echo 
echo "**** add node worker with token ****"
echo 

kubeadm token create --print-join-command

echo 
echo "finish install"
