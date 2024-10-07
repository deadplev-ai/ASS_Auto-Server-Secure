apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && \
sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && \
read -p "New Username: " desired_user && adduser $desired_user && usermod -aG sudo $desired_user && \
echo "$desired_user ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$desired_user && \
cp setup_user.sh /home/$desired_user/ && chown $desired_user:$desired_user /home/$desired_user/setup_user.sh && \
su - $desired_user -c "bash ~/setup_user.sh"

# Auto Cleanup (Remove if break)
rm ~/ASS_Auto-Server-Secure/*
rmdir ~/ASS_Auto-Server-Secure
