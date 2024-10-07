#!/bin/bash

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
yes_or_no "Enforce Password Complexity Requirements? (For future password updates) && sudo apt -y install libpam-pwquality cracklib-runtime && sed -i 'password   requisite   pam_pwquality.so retry=3/password   requisite   pam_pwquality.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 gecoscheck=1 reject_username enforce_for_root' /etc/pam.d/common-password && echo && echo "*****************************" && echo "MINIMUM PASSWORD REQUIREMENTS" && echo "Min Length: 8" && echo "Uppercase: 1" && echo "Lowercase: 1" && echo "Numbers: 1" && echo "CANNOT BE USERNAME | CANNOT CONTAIN GECOS INFO" && echo "*****************************" && echo

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
