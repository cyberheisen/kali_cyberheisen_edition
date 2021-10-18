# kali_cyberheisen_edition
A custom script for preparing a newly installed Kali Linux instance for CTF and pentesting.  The script should be executed after the default installation of Kali finishes.

### Installation ### 
Simply copy, paste, and execute the command below.  
```
curl https://raw.githubusercontent.com/cyberheisen/kali_cyberheisen_edition/main/cyberheisen.sh --output ~/Downloads/cyberheisen.sh && sudo chmod +x ~/Downloads/cyberheisen.sh && sudo ~/Downloads/cyberheisen.sh  
```
### RELEASE NOTES ###

## Features ## 
* The shell prompt contains a date and timestamp.  It has also been modified with coloring to differentiate from user and host names.    

* Web server root created in `/var/www/server`   
  ```
  ./linux - includes links to commonly used Linux tools  
      /LinPEAS  
      ./nc  
  ./windows - includes links to commonly used Windows tools  
      /usr/share/windows-binaries
  ./transfer - empty folder used to transfer loot
  ```

* The Firefox FoxyProxy extension is installed and configured for Burp on localhost:8080  
* The Firefox bookmarks toolbar is configured with relevant bookmarks  
* BurpSuite is configured to start WITHOUT the proxy intercept enabled   
* Flameshot is installed and configured for use with the 'prt screen' key  
    * Screenshots are automatically stored in `~/Pictures/Screenshots`  
    * Screenshots are automatically placed on the clipboard      
* Burpsuite and Joplin shortcuts added to the xfce4 panel    
* The rockyou.txt workdlist is uncompresssed  
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
* **here**: opens the current directory in the xfce4 file manager from the terminal     
* **in_ip**: Provides the current IP address for the eth0 interface  
* **lll**: directory listing with hidden files and access permissions, displayed in long listing format and sorted by time (newest to oldest)    
* **nano**: starts nano with mouse support  
* **out_ip**: Provides your public IP address  
* **record**: enables terminal logging through the script command.  Logs are saved with date and timestamps in the home directory.    
* **refresh**: reloads the .zshrc file  
* **smbserver**: shares the web server through smb  
* **smbserverhere**: shares the local directory through smb  
* **webserver**: shares the web server through port 8080 by default.  The command can be executed as webserver <port> to specify a port.  
* **webserverhere**: shares the local directory through port 8080 by default.  The command can be executed as webserver <port> to specify a port.    
  
  ### Additional Tools Installed ###

* docker  
* Evil-WinRM  
* flameshot  
* FoxyProxy  
* gobuster  
* htop  
* Joplin   
* jq  
* krb5-user  
* LinPEAS  
* mingw-w64  
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


  
