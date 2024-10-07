
# Server Setup

### Intended OS:
- Debian 11/12
- Ubuntu 22.04+

## One Command Setup
Auto Security Updates | Unique SSH Port | Firewall | Non Root User
```bash
apt update && apt install git -y && git clone https://github.com/deadplev-ai/ASS_Auto-Server-Secure.git && cd ASS_Auto-Server-Secure && chmod +x install.sh && ./install.sh
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

## Coming Soon

- Y/N Software Packages (Optional)
- Anti SSH Brute Force (Fail2Ban)
- Anti FTP Brute Force (Fail2Ban Mail)
- Auto Scan Anti Virus (ClamAV + Config)
- Disable Unused Filesystems
- Advanced Intrusion Detection (AIDE)
- Sysctl Kernel Security Paramaters
- Disable Core Dumps
- SSH 2FA
- Password Complexity requirements

- Auto Clean-up (Remove install.sh & user_setup.sh)
