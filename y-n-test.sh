function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) return  1 ;;
        esac
    done
}

# Fail2Ban + Email | Anti SSH Brute Force
yes_or_no "Install Fail2ban? (Anti SSH Brute Force)" && apt-get install fail2ban -y && yes_or_no "Send EMail Notifcations on protection event?" && echo "AIGHT"

# ClamAV Auto Filescan
yes_or_no "Install ClamAV? (File AntiVirus)" && echo "Install #2. AUTO SCAN, AUTO UPDATE SIGNATURES. DO POST UFW SO YOU CAN ADD RULES"

# Disable Unused Filesystems
yes_or_no "Disable Unused Filesystems? (Reduce Attack Vectors)" && echo "Install #2"

# Intrusion Detection Notifications
yes_or_no "Install Advanced Intrusion Detection (AID)?" && echo "Install #3"

# Harden Kernel Security
yes_or_no "Harden Kernel Security Paramaters?" && echo "Install #4"

# Disable Core Dumps / Logs
yes_or_no "Disable Core Dumps? (!!No More Crash Logs!!)" && echo "Install #5"

# SSH 2FA
yes_or_no "Install 2FA?" && echo "Install #6"

#App Armor config in future
