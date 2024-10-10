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

apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && \
sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && \

# Password Complexity Requirements
yes_or_no "Enforce Password Complexity Requirements?" && sudo apt -y install libpam-pwquality cracklib-runtime && sudo sed -i 'password   requisite   pam_pwquality.so retry=3/password   requisite   pam_pwquality.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 gecoscheck=1 reject_username enforce_for_root' /etc/pam.d/common-password && echo && echo "*****************************" && echo "MINIMUM PASSWORD REQUIREMENTS" && echo "Min Length: 8" && echo "Uppercase: 1" && echo "Lowercase: 1" && echo "Numbers: 1" && echo "CANNOT BE USERNAME | CANNOT CONTAIN GECOS INFO" && echo "*****************************" && echo

read -p "New Username: " desired_user && adduser $desired_user && usermod -aG sudo $desired_user && \
echo "$desired_user ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$desired_user && \
cp setup_user.sh /home/$desired_user/ && chown $desired_user:$desired_user /home/$desired_user/setup_user.sh && \
su - $desired_user -c "bash ~/setup_user.sh"

# Auto Cleanup (Remove if break)
rm -rf ASS_Auto-Server-Secure
