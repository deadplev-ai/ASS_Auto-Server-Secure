
# Server Setup

### Intended OS:
- Debian 11/12
- Ubuntu 22.04+

## Current Features

- Automatic Security Updates
- Custom Non-Root Sudo User
- Root Login Block
- Custom SSH Port
- Strict UFW Config (Auto SSH Allow + Rate Limit)
- [Y/N] Future Password Complexity Requirements
- [Y/N] SSH 2FA
- Auto Package Cleanup
- More to come...
<br />

## One Command Setup
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
<br />

## Coming Soon

- Y/N Software Packages (Optional)
- Anti SSH Brute Force (Fail2Ban)
- Anti FTP Brute Force (Fail2Ban Mail)
- Auto Scan Anti Virus (ClamAV + Config)
- Disable Unused Filesystems
- Advanced Intrusion Detection (AIDE)
- Sysctl Kernel Security Paramaters
- Disable Core Dumps
- SELinux (NSA Developed Kernel Security)
- Post Quantum Cryptography SSH (OpenSSH 9.0+)
- Automatic IP Access Limiting (Optional, used for non VPN servers) ["Would you like to limit SSH access to a certain domain or IP?"]
- DDOS Protection (UFW Rate limiting + NGINX)

- Auto Clean-up (Remove install.sh & user_setup.sh)
