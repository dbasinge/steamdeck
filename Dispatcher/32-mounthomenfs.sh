#!/usr/bin/sh
# 1. Enable root password on steam deck
# 2. Create mount directories
# 3. Enable NetworkManager Dispatcher Service 
# - systemctl enable --now  NetworkManager-dispatcher
# 4. Find HOME_UUID and change line beloew
# Find the connection UUID with "nmcli con show" in terminal.
# All NetworkManager connection types are supported: wireless, VPN, wired...
# 5. Copy 32-mounthomenfs.sh to /etc/NetworkManager/dispatcher.d
# 6. Set permission on 32-mounthomenfs.sh
# - chmod 755 32-mounthomenfs.sh
# - chown root:root 32-mounthomenfs.sh
# Note: Change the nfs-server-ip-addr, nfs-server/share-directory, deck-mount-directory
# Example: 192.168.1.5:/volume1/music /home/deck/music

HOME_UUID="xxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

if [[ "$CONNECTION_UUID" == "$HOME_UUID" ]]; then

    # Script parameter $1: NetworkManager connection name, not used
    # Script parameter $2: dispatched event

    case "$2" in
        "up")
            /usr/bin/mount -t nfs -o rsize=8192,wsize=8192,timeo=14 nfs-server-ip-addr:/nfs-server/share-directory /deck-mount-directory
            ;;
        "pre-down");&
        "vpn-pre-down")
            /usr/bin/umount -l -a -t -f nfs4,nfs >/dev/null
            ;;
    esac
fi
