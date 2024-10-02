
## Installation

Apply Automatic Updates
```bash
  apt get update && apt get upgrade -y && apt install unattended-upgrades -y && dpkg-reconfigure --priority=low unattended-upgrades
```
Add New User
```bash
adduser deadplev
```
```bash
usermod -aG sudo deadplev && logout
```

SSH into New User + Key Directory
```bash
ssh deadplev@IP
```
```bash
mkdir ~/.ssh && chmod +700 ~/.ssh && logout
```

Generate SSH Key Pair
```bash
ssh-keygen-b 4096
```
```bash
cd ~/.ssh
```
```bash
scp YOUR_KEY.pub deadplev@IP:~/.ssh/authorized_keys
```
