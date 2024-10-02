
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
echo -e "Imp0ssibl£42!\Imp0ssibl£42!\n\n\n\n\n\n\n\n"|adduser deadplev && usermod -aG sudo deadplev && logout
```

### SSH into New User + Key Directory
SSH into new user
```bash
mkdir ~/.ssh && chmod +700 ~/.ssh && logout
```

### Generate SSH Key Pair
```bash
cd ~/.ssh && ssh-keygen -b 4096
```
```bash
scp KEY.pub deadplev@IP:~/.ssh/authorized_keys
```

### SSH into New User + Security Config
Unique SSH Port | Block Root Login | Block Password Login
SSH into user
```bash
sudo nano /etc/ssh/sshd_config
```
```bash
sudo systemctl restart ssh
```

### Install UFW Firewall
```bash
sudo apt install ufw -y && sudo ufw allow PORT/tcp && sudo ufw enable
```
