
# Server Setup

Commands shared on every server to apply necessary security measures such as:
- Automatic Updates
- Pub/Priv Key Login
- Non-Root User
- UFW Firewall
- Unique SSH Port


## Installation

### Simple Security Config
Auto Security Updates | Unique SSH Port | Firewall | Non Root User
```bash
apt-get update && apt-get upgrade -y && apt install unattended-upgrades -y && sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/g' /etc/apt/apt.conf.d/20auto-upgrades && read -p "New Username: " desired_user && adduser $desired_user && usermod -aG sudo $desired_user && su $desired_user
```
```bash
cd .. && mkdir ~/.ssh && chmod +700 ~/.ssh && read -p "Select Custom SSH Port: " desired_port && sudo sed -i "s/PermitRootLogin yes\b/PermitRootLogin no/gI" /etc/ssh/sshd_config /etc/ssh/sshd_config && sudo sed -i "s/#Port 22\b/Port $desired_port/gI" /etc/ssh/sshd_config && sudo apt install ufw -y && sudo ufw allow $desired_port/tcp && sudo systemctl restart ssh && sudo ufw enable && sudo ufw status && export myIP=$(curl ipinfo.io/ip) && echo "ssh ($whoami)@($myIP) -p ($desired_port)" && sudo reboot now
```

### Generate SSH Key Pair
```bash
cd ~/.ssh && ssh-keygen -b 4096
```
```bash
scp KEY.pub deadplev@IP:~/.ssh/authorized_keys
```

### SSH into New User
Block Password Login
```bash
sudo sed -i 's/PasswordAuthentication yes\b/PasswordAuthentication no/gI' /etc/ssh/sshd_config && sudo systemctl restart ssh
```
