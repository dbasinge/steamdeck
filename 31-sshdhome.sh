#!/usr/bin/sh
# 1. Enable root password on steam deck
# 2, Enable NetworkManager Dispatcher Service 
# - systemctl enable --now  NetworkManager-dispatcher
# 3. Find HOME_UUID and change line beloew
# Find the connection UUID with "nmcli con show" in terminal.
# All NetworkManager connection types are supported: wireless, VPN, wired...
# 3. Copy 31-sshdhome.sh to /etc/NetworkManager/dispatcher.d
# 4. Set permission on 31-sshdhome.sh
# - chmod 755 31-sshdhome.sh
# - chown root:root 31-sshdhome.sh

HOME_UUID="xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

if [[ "$CONNECTION_UUID" == "$HOME_UUID" ]]; then

    # Script parameter $1: NetworkManager connection name, not used
    # Script parameter $2: dispatched event

    case "$2" in
        "up")
            systemctl start sshd
            ;;
        "pre-down");&
        "vpn-pre-down")
            systemctl stop sshd >/dev/null
            ;;
    esac
fi
