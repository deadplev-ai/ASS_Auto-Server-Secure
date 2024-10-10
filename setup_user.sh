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
sudo ufw limit $desired_port/tcp comment 'Rate limit on SSH attempts'
sudo systemctl restart ssh
sudo ufw enable
sudo ufw status

## YES / NO | SOFTWARE PACKAGES
# Password Complexity Requirements (Installed in install.sh)
#yes_or_no "Enforce Password Complexity Requirements? (For future password updates)" && sudo apt -y install libpam-pwquality cracklib-runtime && sudo sed -i 'password   requisite   pam_pwquality.so retry=3/password   requisite   pam_pwquality.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 gecoscheck=1 reject_username enforce_for_root' /etc/pam.d/common-password && echo && echo "*****************************" && echo "MINIMUM PASSWORD REQUIREMENTS" && echo "Min Length: 8" && echo "Uppercase: 1" && echo "Lowercase: 1" && echo "Numbers: 1" && echo "CANNOT BE USERNAME | CANNOT CONTAIN GECOS INFO" && echo "*****************************" && echo

# Fail2Ban + Email | Anti SSH Brute Force
yes_or_no "Install Fail2ban? (Anti SSH Brute Force)" && sudo apt-get install fail2ban -y && sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local && sudo sed -i "s/port    = ssh\b/port    = ssh \nfilter = sshd \nmaxretry = 5 \nenabled = true \nmode = normal \nbantime = 600 \nfindtime = 600 \naction =%(action_)s/gI" /etc/fail2ban/jail.local && sudo sed -i "s/logpath =.*/logpath = \/var\/log\/auth.log/gI" /etc/fail2ban/jail.local && sudo sed -i "s/backend = .*/backend = systemd/gI" /etc/fail2ban/jail.local && sudo systemctl restart fail2ban && sudo systemctl status fail2ban #&& \
#yes_or_no "Notify by EMail on Security Event?" && apt-get install sendmail -y && 

# ClamAV + Auto File Scan | Antivirus
#yes_or_no "Install ClamAV? (File AntiVirus)" && echo "Install #2. AUTO SCAN, AUTO UPDATE SIGNATURES. DO POST UFW SO YOU CAN ADD RULES"

# Disable Unused Filesystems
#yes_or_no "Disable Unused Filesystems? (Reduce Attack Vectors)" && echo "Install #2"

# Intrusion Detection EMails <Probably not useful YET>
#yes_or_no "Install Advanced Intrusion Detection (AIDE)?" && sudo apt install aide && 

# Harden Kernel Security
#yes_or_no "Harden Kernel Security Paramaters?" && echo "Install #4"

# INSTALL SELINUX FOR OPTIMAL HARDENED KERNEL (NSA DEVELOPED)

# Disable Core Dumps / Logs <NOT FUNCTIONING>
#yes_or_no "Disable Core Dumps? (!!No More Crash Logs!!)" && sudo sed -i "s/# End of file\b/# End of file \n\n* hard core 0 \n* soft core 0/gI" /etc/security/limits.conf && sudo sed -i "s/#kernel.sysrq=43\b/#kernel.sysrq=438 \nhello" /etc/sysctl.conf

# SSH 2FA
yes_or_no "Install SSH 2FA?" && sudo apt install libpam-google-authenticator -y && echo && echo "----------------------------" && echo "SAVE YOUR BACKUP KEYS" && echo "----------------------------" && echo && google-authenticator && sudo sed -i "s/PermitEmptyPasswords no\b/PermitEmptyPasswords no \nChallengeResponseAuthentication yes/gI" /etc/ssh/sshd_config && sudo sed -i "s/@include common-auth\b/@include common-auth \n \n# Two Factor Authentication with Google Authenticator \nauth    required    pam_google_authenticator.so/gI" /etc/pam.d/sshd && sudo systemctl restart ssh


# Remove useless packages
sudo apt-get autoremove 
sudo rm ~/setup_user.sh

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
