# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos_6.5_64"
  config.vm.network "private_network", ip: "192.168.33.3"
  
  config.vm.provision "shell", inline: <<SCRIPT
echo "provisioning..."

echo "installing wget ..."
yum -y install wget

echo "installing epel repository ..."
wget http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -ivh epel-release-6-8.noarch.rpm

echo "installing docker ..."
yum -y install docker-io
chkconfig docker on
service docker start

echo "docker pull base image (centos:centos6) ..."
docker pull centos:centos6

SCRIPT
end
