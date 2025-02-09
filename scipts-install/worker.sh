#!/bin/bash

echo  " _   _ _                 _                    _ _   _       _    ___       "
echo  "| | | | |__  _   _ _ __ | |_ _   _  __      _(_) |_| |__   | | _( _ ) ___  "
echo  "| | | | '_ \| | | | '_ \| __| | | | \ \ /\ / / | __| '_ \  | |/ / _ \/ __| "
echo  "| |_| | |_) | |_| | | | | |_| |_| |  \ V  V /| | |_| | | | |   < (_) \__ \ "
echo  " \___/|_.__/ \__,_|_| |_|\__|\__,_|   \_/\_/ |_|\__|_| |_| |_|\_\___/|___/ "

echo                                                     

echo  "__        __         _               _   _           _       "
echo  "\ \      / /__  _ __| | _____ _ __  | \ | | ___   __| | ___  "
echo  " \ \ /\ / / _ \| '__| |/ / _ \ '__| |  \| |/ _ \ / _\` |/ _ \ "
echo  "  \ V  V / (_) | |  |   <  __/ |    | |\  | (_) | (_| |  __/ "
echo  "   \_/\_/ \___/|_|  |_|\_\___|_|    |_| \_|\___/ \__,_|\___| "


sleep 5

echo 
echo "****  Config node worker with k8s and Docker *****"
echo 

echo 
echo "**** update repository package ****"
echo 

apt-get update

echo 
echo "**** disable swap ****"
echo 

swapoff -a
cp /etc/fstab /etc/fstab.bkp
sed -i.bak '/ swap / s/^\(.*\)$/#/g' /etc/fstab


echo 
echo "**** install repository packages kubernetes ****"
echo 

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg


echo 
echo "**** update repository package ****"
echo 

apt-get update 

echo 
echo "**** install kubectl, kubeadm and kubelet ****"
echo 

apt-get -y install kubectl
apt-get -y install kubeadm 
apt-get -y install kubelet

echo 
echo "**** autocompletion kubectl ****"
echo 

echo "source <(kubectl completion bash)" >> $HOME/.bashrc

echo "finish install"