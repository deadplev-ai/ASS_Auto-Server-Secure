
# Server Setup

Commands shared on every server to apply necessary security measures such as:
- Automatic Updates
- Pub/Priv Key Login
- Non-Root User
- UFW Firewall
- Unique SSH Port


## Installation

### Auto Updates + New User
```bash
  apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && useradd deadplev && usermod -aG sudo deadplev && passwd deadplev && logout
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
