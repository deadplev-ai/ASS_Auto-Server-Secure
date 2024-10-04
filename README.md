
# Server Setup

### Intended OS:
- Debian 11/12
- Ubuntu 22.04+

## One Command Setup
Auto Security Updates | Unique SSH Port | Firewall | Non Root User
```bash
apt update && apt install git -y && git clone https://github.com/deadplev-ai/Auto-Server-Secure.git && cd Auto-Server-Secure && chmod +x install.sh && ./install.sh
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

SSH into New User → Keypair Login ONLY (Optional)
```bash
sudo sed -i 's/PasswordAuthentication yes\b/PasswordAuthentication no/gI' /etc/ssh/sshd_config && sudo systemctl restart ssh && echo && echo "***********************" && echo "Security Setup Complete!" && echo "***********************" && echo
```
