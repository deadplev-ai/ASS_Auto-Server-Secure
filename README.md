
# Server Setup

Commands shared on every server to apply necessary security measures such as:
- Automatic Updates
- Pub/Priv Key Login
- Non-Root User
- UFW Firewall
- Unique SSH Port


## Installation

### Auto Updates + New User + Key Directory
```bash
  apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && adduser deadplev && usermod -aG sudo deadplev && su deadplev
```
```bash
cd .. && mkdir ~/.ssh && chmod +700 ~/.ssh && read -p "Select Custom SSH Port: " desired_port && sudo sed -i 's/PermitRootLogin yes;/PermitRootLogin no;/g' /etc/ssh/sshd_config && sudo sed -i 's/#Port 22;/Port $desired_port;/g' /etc/ssh/sshd_config && sudo apt install ufw -y && sudo ufw allow $desired_port/tcp && sudo systemctl restart && sudo ufw enable && sudo reboot now
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
