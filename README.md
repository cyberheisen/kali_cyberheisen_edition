# kali_cyberheisen_edition
A custom script for preparing a newly installed Kali Linux instance for CTF and pentesting.  The script should be executed after the default installation of Kali finishes.

### Installation ### 
Simply copy, paste, and execute the command below.  
**For xfce4**  
```
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/main/cyberheisen.sh --output ~/Downloads/cyberheisen.sh && sudo chmod +x ~/Downloads/cyberheisen.sh && ~/Downloads/cyberheisen.sh  
```
**For kde-plasma**  
```
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/kde-plasma/cyberheisen.sh --output ~/Downloads/cyberheisen.sh && sudo chmod +x ~/Downloads/cyberheisen.sh && ~/Downloads/cyberheisen.sh  
```

### RELEASE NOTES ###

## Features ## 
* The shell prompt has been modified with coloring to differentiate from user and host names.  It also displays the targeted host and has optional date and time stamps.  

* Web server root created in `/var/www/server`   
  ```
  ./linux - includes links to commonly used Linux tools  
      /LinPEAS  
      ./nc  
      ./pspy32
      ./pspy64
  ./windows - includes links to commonly used Windows tools  
      /usr/share/windows-binaries
  ./transfer - empty folder used to transfer loot
  ```
* Qterminal tabs will open in the current working directory
* The Firefox FoxyProxy extension is installed and configured for Burp on localhost:8080  
* The Firefox bookmarks toolbar is configured with relevant bookmarks  
* Flameshot is installed and configured for use with the 'prt screen' key  
    * Screenshots are automatically stored in `~/Pictures/Screenshots`  
    * Screenshots are automatically placed on the clipboard      
* Burpsuite and Joplin shortcuts added to the xfce4 panel    
* The rockyou.txt wordlist is uncompresssed  
* OneRuletoRuleThemAll is downloaded to the `/usr/share/haschat/rules` folder  
* SSH keys are generated and SSH password authentication disabled  

## Custom Commands  
* **add_host**: Adds a hostname record to the host file 
* **create_folders**: Creates a default folder structure in the home directory to store information regarding a particular target. 
```
/home/<user>  
    ./Targets  
        ./<target name>  
            ./loot  
            ./exploits  
            ./scans  
            ./ssh_keys   
```
* **downloads**: changes to the ~/Downloads directory  
* **exploits**: changes to the $TARGET/exploits folder
* **flush_hosts**: removes any added host entries in the the /etc/hosts file by returning it back to it's original install state.
* **here**: opens the current directory in the xfce4 file manager from the terminal     
* **in_ip**: Provides the current IP address for the eth0 interface  
* **lll**: directory listing with hidden files and access permissions, displayed in long listing format and sorted by time (newest to oldest)    
* **loot**: changes to the $TARGET/loot folder.
* **nano**: starts nano with mouse support.  
* **ports**: if an nmap scan results xml exists in the Target's scan folder, this command will display the open ports.
* **prompt_time**: Enables the date and time stamp at the terminal prompt.  To disable, execute the command with the "off" argument.
* **out_ip**: Provides your public IP address.  
* **record**: enables terminal logging through the script command.  Logs are saved with date and timestamps in the home directory.    
* **refresh**: reloads the .zshrc file.  
* **scan**: Performs a full TCP port nmap -A scan on the target host and outputs results to the target's scan folder.
* **scans**: changes to the $TARGET/scans folder.
* **set_target**: Set the TARGET variable.  Used as `set_target <host>`
* **ssh_keys**: changes to the $TARGET/ssh_keys folder.
* **smbserver**: shares the web server through smb.  
* **smbserverhere**: shares the local directory through smb.
* **tun_ip**: Provides the current IP address for the tun0 interface
* **virtualenv2**: creates and starts a python2 virtual environment in the current folder.
* **virtualenv3**: creates and starts a python3 virtual environment in the current folder.
* **webserver**: shares the web server through port 8080 by default.  The command can be executed as webserver <port> to specify a port.  
* **webserverhere**: shares the local directory through port 8080 by default.  The command can be executed as webserver <port> to specify a port.    
  
  ### Additional Tools Installed ###

* docker  
* Evil-WinRM  
* flameshot  
* FoxyProxy  
* gobuster  
* htop  
* jd-gui  
* Joplin   
* jq  
* krb5-user  
* LinPEAS  
* mingw-w64  
* pspy32
* pspy64
* python-pip-whl  
* python3-pip  
* python3-requests  
* python3-pyftpdlib  
* python3-pylint-common  
* python3-scapy  
* python3-venv  
* rlwrap  
* Penelope Shell Handler  
* virtualenv  
* xrdp  
* wine64  
* WinPEAS  
* Visual Studio Code


  
