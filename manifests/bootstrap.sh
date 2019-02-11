#!/bin/bash
sudo apt-get update 
echo "Intalling Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get  -y install docker-ce apt-transport-https ca-certificates curl software-properties-common
echo "Docker installed!"
echo "Intalling node!"
sudo apt-get  -y install nodejs npm
sudo npm install -g serve
echo "Node installed!"
echo "Intalling puppet!"
sudo apt-get update
sudo apt-get update && apt-get -y install puppet
puppet module install puppetlabs-apache
echo "Puppet installed!"
