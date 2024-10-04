function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) return  1 ;;
        esac
    done
}

yes_or_no "Install Fail2ban? (Anti SSH Brute Force)" && apt-get install fail2ban -y
# MENTION MAIL VERSION FOR MAIL SERVER

yes_or_no "Install ClamAV? (File AntiVirus)" && echo "Install #2. AUTO SCAN, AUTO UPDATE SIGNATURES. DO POST UFW SO YOU CAN ADD RULES"

yes_or_no "Disable Unused Filesystems? (Reduce Attack Vectors)" && echo "Install #2"

yes_or_no "Install Advanced Intrusion Detection (AID)?" && echo "Install #3"

yes_or_no "Harden Kernel Security Paramaters?" && echo "Install #4"

yes_or_no "Disable Core Dumps? (!!No More Crash Logs!!)" && echo "Install #5"

#App Armor config in future
