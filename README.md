# Scripts Install Kubernetes

## Description
This repository contains scripts and detailed guides for installing Kubernetes in the cloud and on-premise environment, including both automatic and manual installation.

## Directory Structure

```
SCRIPTS-INSTALL-KUBERNETES/
├── command-kubectl/            # Documentation and guide for kubectl commands
│   ├── cheatsheet.md           # Cheat sheet for basic commands
│
├── install-guide/
|   ├── Cloud/
|   ├── On-premise/  # Kubernetes on-premise installation guide
│   |   ├── automatic installation/ # Automatic Kubernetes installation
│   |   |   ├── README.md           # Guide for automatic installation
│   |   ├── manual installation/    # Manual Kubernetes installation
│   |   |   ├── README.md           # Guide for manual installation
│
├── scripts-install/            # Installation scripts
│   ├── master.sh               # Installation script for master node
│   ├── worker.sh               # Installation script for worker node
├── README.md               # Guide for using the installation scripts
```

## Usage Guide

### 1. Automatic Kubernetes Installation by KubeSpray
Refer to the documentation in [automatic installation](./install-guidle/On-premise/automatic%20installation/README.md)

### 2. Manual Kubernetes Installation
Refer to the documentation in [manual installation](./install-guidle/On-premise/manual%20installation/README.md)


### 3. Running Installation Scripts
Run the installation script on the master node:
```bash
bash scripts-install/master.sh
```
Run the installation script on the worker node:
```bash
bash scripts-install/worker.sh
```

## Notes
- Ensure you have `sudo` privileges before running the scripts.
- Check network configuration and firewall settings before deployment.

## Contribution
If you want to contribute, create a Pull Request or open an Issue for discussion.

## Contact
By [Hung Le Minh](https://www.github.com/HungLM1506)