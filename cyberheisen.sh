#!/bin/bash

################

# Update apt repository
sudo apt update && apt upgrade -y

# install tools through apt
sudo apt install rlwrap docker.io mingw-w64 virtualenv xrdp

# configure ssh
echo "Configuring SSH"
echo "Creating SSH keys"
ssh-keygen -N ""
mv ~/.ssh/id_rsa.pub authorized_keys
echo "ssh keys generated - make sure to download and secure the private key"
echo "Removing password based SSH authentication"
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# update .zshrc
echo Configuring Zshell
echo "backup original Zshell configuraiton files"
mv ~/.zshrc .zshrc.orig.bak
sudo mv /root/.zshrc /root/.zshrc.bak
echo "downloading configuration file"
curl https://raw.githubusercontent.com/cyberheisen/Penetration-Testing-Notes/main/configurations/.zshrc --output ~/.zshrc
sudo cp ~/.zshrc /root/.zshrc

echo "Cyberheisen configuration complete."
echo "Make sure to download the private key"
