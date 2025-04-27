
# preseeding

## Context

## Architecture

![architecture](../../assets/reverse-proxy/architecture.png)

### Workflow

Phase 1:

![reverse-proxy-phase1](../../assets/reverse-proxy/reverse-proxy-phase1.png)

Phase 2:

![reverse-proxy-phase2](../../assets/reverse-proxy/reverse-proxy-phase2.png)

## Setup

https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm

https://github.com/YosefCohen877/USB-Unattended-Proxmox/tree/main
https://pve.proxmox.com/wiki/Automated_Installation
https://github.com/sergelogvinov/ansible-role-debian-boot / https://dev.to/sergelogvinov/install-proxmox-on-any-bare-metal-server-2bcn
https://pve.proxmox.com/wiki/Unattended_installation_of_Proxmox
https://forum.proxmox.com/threads/unattended-install.93005/


https://github.com/dsgnr/ubuntu-16.04-unattended-install/blob/master/README.md
https://www.debian.org/releases/bookworm/example-preseed.txt
https://gist.githubusercontent.com/zyra83/fd9409d618944ecb71269a86830805b6/raw/8049c3aa3bbd8a7951e579d44892150b77171ad1/amd64-main-full.txt
https://github.com/yannbreizh/debian-installer/blob/master/preseed-creator.sh
https://github.com/Tontonjo/debian/blob/master/preseed/jo/preseed.cfg

Sources:
https://www.debian.org/releases/bookworm/example-preseed.txt
https://gist.githubusercontent.com/zyra83/fd9409d618944ecb71269a86830805b6/raw/8049c3aa3bbd8a7951e579d44892150b77171ad1/amd64-main-full.txt
https://github.com/yannbreizh/debian-installer/blob/master/preseed-192.168.10.35.cfg
https://github.com/Tontonjo/debian/blob/master/preseed/jo/preseed.cfg


config/
boot/ => UEFI setup
isolinux/ => Legacy/BIOS mode

in wsl, as root
`./create_preseeded_iso.sh`

with rufus => write the debian_preseed iso on the key
insert key in USB 2.0 port
start the server, it should auto install

TODO:
- check network config? (if we even want to do that)
- check how to "reset" server easily

Remove current authorized key
`ssh-keygen -R 192.168.1.109`

`ssh-keygen -t rsa -b 4096 -f ../config/ssh/ansible/ansible_key`

```
sudo efibootmgr --create --disk "/dev/sda" --part "1" --loader "\EFI\Boot\bootx64.efi" --label "USB_installer"
efibootmgr --bootnext "0000"
sudo reboot
```


TODO:
add root password as env var or as param in the command line
sed preseed to replace the value with the root password
sed preseed to replace network config
make network config work (?)