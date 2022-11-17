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

# Replace the xfce with kde-plasma
sudo DEBIAN_FRONTEND=noninteractive apt -y -q install kali-desktop-kde
sudo update-alternatives --config x-session-manager
sudo apt purge --autoremove kali-desktop-xfce

# install tools through apt
printf "Installing software packages through apt\n"
sudo DEBIAN_FRONTEND=noninteractive apt -y -q install rlwrap docker.io mingw-w64 \
virtualenv xrdp flameshot htop joplin jq gobuster krb5-user python3-dev python3-pip python3-pylint-common \
python3-requests python3-scapy python3-venv python3-pip-whl python3-pyftpdlib wine64


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

#### python upload server ####
printf "installing Python3 UploadServer\n"
sudo pip3 install uploadserver

#### Nmap Output Parser ####
printf "Installing Nmap Output Parser\n"
git clone https://github.com/ernw/nmap-parse-output.git
sudo cp ./nmap-parse-output/nmap-parse-output /sbin/nmap-parse-output 
sudo chmod +x /sbin/nmap-parse-output

#### Evil-WinRM
sudo gem install evil-winrm

#### Pspy
printf "installing pspy\n"
sudo mkdir /usr/share/pspy
sudo curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 --output /usr/share/pspy/pspy32
sudo curl https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 --output /usr/share/pspy/pspy64
sudo chmod 755 /usr/share/pspy 
sudo ln -s /usr/share/pspy/pspy32 $WEBSERVER/linux/pspy32
sudo ln -s /usr/share/pspy/pspy64 $WEBSERVER/linux/pspy64

### Web Server Links
printf "Creating additional necessary file links for the webserver\n"
sudo ln -s /bin/nc $WEBSERVER/linux/nc
sudo ln -s /usr/share/windows-binaries $WEBSERVER/windows/tools
chmod -R 777 /var/www/server

### System Configurations

### Set Python3 as default
printf "Configuring Python3 as the default python interpreter"
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

### /etc/hosts
printf "Backing up the /etc/hosts file\n"
sudo cp /etc/hosts /etc/hosts.orig

### Firefox 
### Extensions
# foxyproxy
printf "Installing FoxyProxy with localhost:8080 proxy configuration\n"
sudo curl -L https://addons.mozilla.org/firefox/downloads/file/3616824/foxyproxy_standard-7.5.1-an+fx.xpi --output /usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/foxyproxy@eric.h.jung.xpi
printf "FoxyProxy Installed"

### Configure Firefox
printf "Configuring Firefox\n"
curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/kde-plasma/resources/mozilla_settings.7z --output $SETUPFOLDER/mozilla_settings.7z
7z x $SETUPFOLDER/mozilla_settings.7z -o$HOME/ -aoa

### Configure Burp
# printf "Configuring Burpsuite\n"
# printf "....Intercept will no longer be enabled at startup"
# mkdir -p ~/.config/burpsuite
# curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/kde-plasma/resources/burp_settings.json --output $HOME/.config/burpsuite/burp_settings.json

### Configure Flameshot
printf "Configuring Flameshot\n"
printf ".....'print scr' key to execute flameshot\n"
printf ".....screenshots automatically saved to ~/Pictures/Screenshots folder, and to clipboard\n"
curl -L https://github.com/cyberheisen/kali_cyberheisen_edition/raw/kde-plasma/resources/flameshot_settings.7z --output $SETUPFOLDER/flameshot_settings.7z
7z x $SETUPFOLDER/flameshot_settings.7z -o$HOME/.config -aoa
mkdir -p $HOME/Pictures/Screenshots

### Configure .zshrc
printf "Configuring Zshell\n"
printf "backup original Zshell configuration files\n"
mv $HOME/.zshrc .zshrc.orig.bak
sudo mv /root/.zshrc /root/.zshrc.bak
printf "downloading configuration file\n"
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/kde-plasma/resources/.zshrc --output ~/.zshrc
sudo cp $HOME/.zshrc /root/.zshrc

### Create Dynamic Target File
printf "Creating ~./TARGET file\n"
touch ~/.TARGET

### Configure xfce4
#printf "Configuring xfce4 Settings\n"
#curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/kde-plasma/resources/xfce4_settings.7z --output $SETUPFOLDER/xfce4_settings.7z
#7z x $SETUPFOLDER/xfce4_settings.7z -o$HOME/.config -aoa

### Configure Qterminal
printf "Configuring Qterminal\n"
sed -i "s/UseCWD=false/UseCWD=true/g" ~/.config/qterminal.org/qterminal.ini


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
mkdir -p $HOME/.ssh
ssh-keygen -N "" -f $HOME/.ssh/id_rsa
cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys
printf "ssh keys generated\n"
printf "Removing password based SSH authentication\n"
sudo sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
printf "Cyberheisen configuration complete.\n"
printf "A system restart is required to enable some settings\n."
printf "Make sure to download the private key!!!!\n"
