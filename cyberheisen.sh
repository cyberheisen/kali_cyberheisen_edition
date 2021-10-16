#!/bin/bash

################

###### Initial Setup ######
SETUPFOLDER="~/Downloads/cyberheisen"

# We need to create a few folders
printf "Creating setup folder in: %s\n" "$SETUPFOLDER"
mkdir $SETUPFOLDER && cd $SETUPFOLDER

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
curl -L https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-7.5.1-an+fx.xpi --output /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/foxyproxy_standard-7.5.1-an+fx.xpi

#firefox -install-global-extension $SETUPFOLDER/foxyproxy.xpi

#### The Peas ####
printf "Downloading WinPEAS\n"
sudo curl -L https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe -o /usr/share/windows-binaries/winPEASx64.exe
sudo curl -L https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/x86/Release/winPEASx86.exe -o /usr/share/windows-binaries/winPEASx86.exe
sudo mkdir /usr/share/linPEAS
sudo curl -L https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/linPEAS/linpeas.sh -o /usr/share/linPEAS/linpeas.sh
sudo chmod +x /usr/share/LinPEAS



#### Penelope Shell Handler ####
printf "Installing Penelope Shell Handler\n"
git clone https://github.com/brightio/penelope.git
sudo cp ./penelope/penelope.py /sbin 
chmod +x /sbin/penelope.py


### configure ssh
printf "Configuring SSH\n"
printf "Creating SSH keys\n"
ssh-keygen -N "" -f ~/.ssh/id_rsa
cp ~/.ssh/id_rsa.pub authorized_keys
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
source ~/.zshrc

printf "Cyberheisen configuration complete.\n"
printf "Make sure to download the private key\n"
