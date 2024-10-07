apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && \
sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && \
sudo apt -y install libpam-pwquality cracklib-runtime
sed -i 'password   requisite   pam_pwquality.so retry=3/password   requisite   pam_pwquality.so minlen=8 ucredit=-1 lcredit=-1 dcredit=-1 gecoscheck=1 reject_username enforce_for_root' /etc/pam.d/common-password

echo
echo "*****************************"
echo "MINIMUM PASSWORD REQUIREMENTS"
echo "Min Length: 8"
echo "Uppercase: 1"
echo "Lowercase: 1"
echo "Numbers: 1"
echo "CANNOT BE USERNAME | CANNOT CONTAIN GECOS INFO"
echo "*****************************"
echo

read -p "New Username: " desired_user && adduser $desired_user && usermod -aG sudo $desired_user && \
echo "$desired_user ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$desired_user && \
cp setup_user.sh /home/$desired_user/ && chown $desired_user:$desired_user /home/$desired_user/setup_user.sh && \
su - $desired_user -c "bash ~/setup_user.sh"

# ADDING PASSWORD RULES. EXPLAIN THEM IN ECHO. Use SED to write requirements in

# Auto Cleanup (Remove if break)
rm ~/ASS_Auto-Server-Secure/*
rmdir ~/ASS_Auto-Server-Secure
