#!/bin/bash

################

###### Initial Setup ######
export USER="kali"
export HOME="/home/$USER"
export SETUPFOLDER="$HOME/Downloads/cyberheisen"
export WEBSERVER="/var/www/server"


# We need to create a few folders
printf "Creating setup folder in: %s\n" "$SETUPFOLDER"
mkdir $SETUPFOLDER && cd $SETUPFOLDER

# Update apt repository
printf "Updating local apt cache and upgrading existing installations\n"
sudo apt update
printf "Upgrading packages\n"
sudo DEBIAN_FRONTEND=noninteractive apt -y -q upgrade

# install tools through apt
printf "Installing software packages through apt\n"
sudo DEBIAN_FRONTEND=noninteractive apt -y -q install rlwrap docker.io mingw-w64 \
virtualenv xrdp flameshot htop joplin jq gobuster krb5-user python3-pip python3-pylint-common \
python3-requests python3-scapy python3-venv python-pip-whl python3-pyftpdlib wine64

### Webserver/FTPserver 
printf "Creating webserver/ftp server folder structure\n"
sudo mkdir -p $WEBSERVER $WEBSERVER/linux $WEBSERVER/windows $WEBSERVER/transfer

### install other tools

#### The Peas ####
printf "Downloading WinPEAS\n"
sudo curl -L https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe -o /usr/share/windows-binaries/winPEASx64.exe
sudo curl -L https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/x86/Release/winPEASx86.exe -o /usr/share/windows-binaries/winPEASx86.exe
sudo mkdir /usr/share/linPEAS
sudo curl -L https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/linPEAS/linpeas.sh -o /usr/share/linPEAS/linpeas.sh
sudo chmod +x /usr/share/linPEAS
# Create links to the webserver
sudo ln -s /usr/share/linPEAS/linpeas.sh /var/www/server/linux/linpeas.sh


#### Penelope Shell Handler ####
printf "Installing Penelope Shell Handler\n"
git clone https://github.com/brightio/penelope.git
sudo cp ./penelope/penelope.py /sbin/penelope 
sudo chmod +x /sbin/penelope

#### Evil-WinRM
sudo gem install evil-winrm

### Web Server Links
printf "Creating additional necessary file links for the webserver\n"
sudo ln -s /bin/nc $WEBSERVER/linux/nc
sudo ln -s /usr/share/windows-binaries $WEBSERVER/windows/tools

### System Configurations

### Firefox 
### Extensions
# foxyproxy
printf "Installing FoxyProxy with localhost:8080 proxy configuration\n"
sudo curl -L https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-7.5.1-an+fx.xpi --output /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/foxyproxy@eric.h.jung.xpi
printf "FoxyProxy Installed"

### Configure Firefox
printf "Configuring Firefox\n"
curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/main/resources/mozilla_settings.7z --output $SETUPFOLDER/mozilla_settings.7z
7z x $SETUPFOLDER/mozilla_settings.7z -o$HOME/ -aoa

### Configure Burp
printf "Configuring Burpsuite\n"
printf "....Intercept will no longer be enabled at startup"
curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/main/resources/burp_settings.json --output $HOME/.config/burpsuite/burp_settings.json

### Configure Flameshot
printf "Configuring Flameshot\n"
printf ".....'print scr' key to execute flameshot\n"
printf ".....screenshots automatically saved to ~/Pictures/Screenshots folder, and to clipboard\n"
curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/main/resources/flameshot_settings.7z --output $SETUPFOLDER/flameshot_settings.7z
7z x $SETUPFOLDER/flameshot_settings.7z -o$HOME/.config -aoa
mkdir -p $HOME/Pictures/Screenshots

### Configure .zshrc
printf "Configuring Zshell\n"
printf "backup original Zshell configuration files\n"
mv $HOME/.zshrc .zshrc.orig.bak
sudo mv /root/.zshrc /root/.zshrc.bak
printf "downloading configuration file\n"
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/main/resources/.zshrc --output ~/.zshrc
source $HOME/.zshrc
sudo cp $HOME/.zshrc /root/.zshrc

### Configure xfce4
printf "Configuring xfce4 Settings\n"
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/main/resources/xfce4_settings.7z --output $SETUPFOLDER/xfce4_settings.7z
7z x $SETUPFOLDER/xfce4_settings.7z -o$HOME/.config -aoa

### Wordlists
# unzip rockyou.txt
printf "Unzipping rockyou.txt\n"
sudo gunzip /usr/share/wordlists/rockyou.txt.gz

# OneRuletoRuleThemAll
printf "Downloading One Rule to Rule them All\n"
sudo curl -L https://raw.githubusercontent.com/NotSoSecure/password_cracking_rules/master/OneRuleToRuleThemAll.rule -o /usr/share/hashcat/rules/OneRuleToRuleThemAll.rule

### configure ssh
printf "Configuring SSH\n"
printf "Creating SSH keys\n"
ssh-keygen -N "" -f $HOME/.ssh/id_rsa
cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys
printf "ssh keys generated\n"
printf "Removing password based SSH authentication\n"
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
printf "Cyberheisen configuration complete.\n"
printf "Make sure to download the private key!!!!\n"
