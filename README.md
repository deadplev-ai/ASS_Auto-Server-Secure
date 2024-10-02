
# Server Setup

Commands shared on every server to apply necessary security measures such as:
- Automatic Updates
- Pub/Priv Key Login
- Non-Root User
- UFW Firewall
- Unique SSH Port


## Installation

### Apply Automatic Updates
```bash
  apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && dpkg-reconfigure --priority=low unattended-upgrades
```
### Add New User
```bash
adduser deadplev
```
```bash
usermod -aG sudo deadplev && logout
```

### SSH into New User + Key Directory
```bash
ssh deadplev@IP
```
```bash
mkdir ~/.ssh && chmod +700 ~/.ssh && logout
```

### Generate SSH Key Pair
```bash
ssh-keygen -b 4096
```
```bash
cd ~/.ssh
```
```bash
scp YOUR_KEY.pub deadplev@IP:~/.ssh/authorized_keys
```

### SSH into New User + Security Config
Unique SSH Port | Block Root Login | Block Password Login
```bash
ssh deadplev@IP
```
```bash
sudo nano /etc/ssh/sshd_config
```
```bash
sudo systemctl restart ssh
```
Login with new Terminal to check you can still login

### Install UFW Firewall
```bash
sudo apt install ufw -y && sudo ufw allow SSH_PORT/tcp && sudo ufw enable
```
