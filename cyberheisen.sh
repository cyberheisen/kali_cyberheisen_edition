#!/bin/bash

################

###### Initial Setup ######
SETUPFOLDER="~/cyberheisen"

# We need to create a few folders
printf "Creating setup folder in: %s\n" "$SETUPFOLDER"
mkdir $SETUPFOLDER

# Update apt repository
printf "Updating local apt cache and upgrading existing installations\n"
sudo apt update
printf "Upgrading packages\n"
sudo apt -y upgrade

# install tools through apt
printf "Installing software packages through apt\n"
sudo apt -y install rlwrap docker.io mingw-w64 virtualenv xrdp

### install other tools
# foxyproxy
printf "Installing FoxyProxy\n"
curl -L https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-7.5.1-an+fx.xpi --output $SETUPFOLDER/foxyproxy.xpi
firefox -install-global-extension $SETUPFOLDER/foxyproxy.xpi

#### The Peas ####


#### Penelope Shell Handler ####

### configure ssh
printf "Configuring SSH\n"
printf "Creating SSH keys\n"
ssh-keygen -N ""
mv ~/.ssh/id_rsa.pub authorized_keys
printf "ssh keys generated - make sure to download and secure the private key\n"
printf "Removing password based SSH authentication\n"
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

# update .zshrc
printf Configuring Zshell
printf "backup original Zshell configuration files\n"
mv ~/.zshrc .zshrc.orig.bak
sudo mv /root/.zshrc /root/.zshrc.bak
printf "downloading configuration file\n"
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/main/.zshrc --output ~/.zshrc
sudo cp ~/.zshrc /root/.zshrc

printf "Cyberheisen configuration complete.\n"
printf "Make sure to download the private key\n"
