#!/bin/bash

function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) return  1 ;;
        esac
    done
}

cd ~
mkdir ~/.ssh
chmod 700 ~/.ssh

echo "***********************"
read -p "Select Custom SSH Port: " desired_port

sudo sed -i "s/PermitRootLogin yes\b/PermitRootLogin no/gI" /etc/ssh/sshd_config
sudo sed -i "s/#Port 22\b/Port $desired_port/gI" /etc/ssh/sshd_config

sudo apt install ufw -y
sudo ufw allow $desired_port/tcp
sudo systemctl restart ssh
sudo ufw enable
sudo ufw status

## YES / NO | SOFTWARE PACKAGES
# Password Complexity Requirements
yes_or_no "Enforce Password Complexity Requirements? (For future password updates)" && sudo apt -y install libpam-pwquality cracklib-runtime && sed -i 'password   requisite   pam_pwquality.so retry=3/password   requisite   pam_pwquality.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 gecoscheck=1 reject_username enforce_for_root' /etc/pam.d/common-password && echo && echo "*****************************" && echo "MINIMUM PASSWORD REQUIREMENTS" && echo "Min Length: 8" && echo "Uppercase: 1" && echo "Lowercase: 1" && echo "Numbers: 1" && echo "CANNOT BE USERNAME | CANNOT CONTAIN GECOS INFO" && echo "*****************************" && echo

# Fail2Ban + Email | Anti SSH Brute Force
#yes_or_no "Install Fail2ban? (Anti SSH Brute Force)" && apt-get install fail2ban -y && yes_or_no "Notify by EMail on Security Event?" && apt install sendmail-bin sendmail

# ClamAV + Auto File Scan | Antivirus
#yes_or_no "Install ClamAV? (File AntiVirus)" && echo "Install #2. AUTO SCAN, AUTO UPDATE SIGNATURES. DO POST UFW SO YOU CAN ADD RULES"

# Disable Unused Filesystems
#yes_or_no "Disable Unused Filesystems? (Reduce Attack Vectors)" && echo "Install #2"

# Intrusion Detection EMails <Probably not useful YET>
#yes_or_no "Install Advanced Intrusion Detection (AIDE)?" && sudo apt install aide && 

# Harden Kernel Security
#yes_or_no "Harden Kernel Security Paramaters?" && echo "Install #4"

# Disable Core Dumps / Logs
#yes_or_no "Disable Core Dumps? (!!No More Crash Logs!!)" && echo "Install #5"

# SSH 2FA
yes_or_no "Install SSH 2FA?" && apt install libpam-google-authenticator && echo && echo "----------------------------" && echo "SAVE YOUR BACKUP KEYS" && echo "----------------------------" && echo && google-authenticator && sudo sed -i "s/PermitEmptyPasswords no\b/PermitEmptyPasswords no \nChallengeResponseAuthentication yes/gI" /etc/ssh/sshd_config && sudo sed -i "s/@include common-auth\b/@include common-auth \n \n# Two Factor Authentication with Google Authenticator \nauth    required    pam_google_authenticator.so/gI" /etc/pam.d/sshd && sudo systemctl restart ssh


# Remove useless packages
sudo apt-get autoremove 

# Remove passwordless sudo entry
sudo rm /etc/sudoers.d/$USER

myIP=$(curl -s ipinfo.io/ip)
echo
echo "----------------------------"
echo "ssh $USER@$myIP -p $desired_port"
echo "----------------------------"
echo

echo
echo "*****************************"
echo "Enter: sudo reboot now"
echo "*****************************"
echo
