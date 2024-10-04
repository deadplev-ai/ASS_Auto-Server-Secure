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

myIP=$(curl -s ipinfo.io/ip)
echo
echo "----------------------------"
echo "ssh $USER@$myIP -p $desired_port"
echo "----------------------------"
echo

sudo reboot now
