
# Server Setup

### Intended OS:
- Debian 11/12
- Ubuntu 22.04+

### Features

- Automatic Security Updates
- Modular UFW Firewall
- Unique SSH Port
- Non-Root User

- OPTIONAL: Secure Keypair Login
<br />

## Simple Security Setup
Auto Security Updates | Unique SSH Port | Firewall | Non Root User
```bash
apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && read -p "New Username: " desired_user && adduser $desired_user && usermod -aG sudo $desired_user && su $desired_user
```
```bash
cd .. && mkdir ~/.ssh && chmod +700 ~/.ssh && echo && echo "***********************" && read -p "Select Custom SSH Port: " desired_port && sudo sed -i "s/PermitRootLogin yes\b/PermitRootLogin no/gI" /etc/ssh/sshd_config /etc/ssh/sshd_config && sudo sed -i "s/#Port 22\b/Port $desired_port/gI" /etc/ssh/sshd_config && sudo apt install ufw -y && sudo ufw allow $desired_port/tcp && sudo systemctl restart ssh && sudo ufw enable && sudo ufw status && export myIP=$(curl ipinfo.io/ip) && echo && echo && echo ---------------------------- && echo "ssh $USER@$myIP -p $desired_port" && echo ---------------------------- && echo && echo && sudo reboot now
```
<br />

## OPTIONAL: SSH Keypair
```bash
cd ~/.ssh && ssh-keygen -b 4096
```
```bash
scp KEY.pub USER@IP:~/.ssh/authorized_keys
```
<br />

SSH into New User → Block Password Login
```bash
sudo sed -i 's/PasswordAuthentication yes\b/PasswordAuthentication no/gI' /etc/ssh/sshd_config && sudo systemctl restart ssh && echo && echo "***********************" && echo "Security Setup Complete!" && echo "***********************" && echo
```
