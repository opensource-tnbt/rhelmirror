#!/usr/bin/env bash
 
## Define variables
MEM_SIZE=8096 # Memory setting in MiB
VCPUS=8      # CPU Cores count
OS_VARIANT="rhel7.0" # List with osinfo-query  os
ISO_FILE="/var/lib/libvirt/images/rhel-7-server-x86_64-latest-dvd1.iso" # Path to ISO file
KS_FILE="/root/ks.cfg"
BRIDGE_NAME="br0"

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
echo -en "Enter virtual disk size : "
read DISK_SIZE
 
sudo virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk size=${DISK_SIZE}  \
#	 --network default
	 --network bridge=${BRIDGE_NAME} \
     --graphics=none \
     --os-variant=${OS_VARIANT} \
     --console pty,target_type=serial \
     --initrd-inject ${KS_FILE} \
	 --extra-args "inst.ks=file:/ks.cfg console=tty0 console=ttyS0,115200n8"