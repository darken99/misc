curl https://d8vjazrbkazun.cloudfront.net/AWS-DataSync-Agent-KVM.zip -o AWS-DataSync-Agent-KVM.zip
unzip AWS-DataSync-Agent-KVM.zip
dnf install libvirt libvirt-client virt-install  virt-viewer
systemctl enable --now libvirtd
virt-install --name "datasync" --description "AWS DataSync agent" --os-type=generic --ram=32768 --vcpus=4 --disk path=/tmp/datasync-20210211-x86_6
4.qcow2,bus=virtio,size=80 --network default,model=virtio --graphics none --import

