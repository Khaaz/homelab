# Preseed

## Context

### Overview

Automated installation of Debian using a preseed configuration. This enables unattended server provisioning and prepares the system for further automation.

## Architecture

## Features

Automates Debian installation with:

- Unattended setup using preseed configuration
- Custom locale, timezone, and network settings
- Disk partitioning (default: /dev/sda, configurable)
- Automatic installation of essential packages (`sudo`, `curl`, `vim`, network tools)
- Root SSH login enabled
- Creation of `homelab` user (sudo privileges, custom password)
- Creation of `ansible` user with SSH key for automation
- Deployment of helper scripts (e.g. `reset_server.sh` for EFI boot management)
- Post-install reboot
- Flexible configuration via environment file and template

## File structure

This folder contains the preseed configuration and scripts to build a bootable ISO image:

- `config/` – final preseed and bootloader files
  - `custom/` – helper scripts and SSH keys copied during install
- `iso/` – output directory for the generated ISO
- `log/` – logs and generated files for debugging
- `src/`
  - `create_preseeded_iso.sh` – utility script to build the ISO
  - `generate_preseed_cfg.sh` – builds `config/preseed.cfg` from the template

### Preseed contents

`config/preseed.cfg` answers Debian installer questions automatically and executes a post-install script. Key actions:

- Set locale and timezone
- Partition `/dev/sda` (adjust in the file for other disks)
- Install base packages: `sudo`, `curl`, `vim`, network tools
- Enable root SSH login
- Create `homelab` user (default password: `homelab!`)
- Create `ansible` user with your SSH key
- Copy helper scripts (e.g. `reset_server.sh`) to `/root/bin`
- Reboot automatically after installation

After install, both `homelab` and `ansible` users are available. `ansible` user can SSH direclty with the SSH key configured. `homelab` user is in the sudoers users.  
The helper script `reset_server.sh` can be run to adjust EFI boot order and reboot from USB installer:

```bash
sudo /root/bin/reset_server.sh /dev/sdX
```

## Setup

### Initial setup

1. Download the official Debian netinst ISO referenced in `create_preseeded_iso.sh` (default: `debian-12.9.0-amd64-netinst.iso`) and place it in the `iso/` directory:
   ```bash
   curl -L -o iso/debian-12.9.0-amd64-netinst.iso \
     https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso
   ```
   Adjust the filename/version in the script if needed.
2. Ensure you have a Linux or WSL environment with root privileges.
3. Install required tooling:
   ```bash
   sudo apt-get update && sudo apt-get install -y xorriso
   ```

### Environment files

Copy `src/config/template.env` to `src/config/.env` and edit values:

- `DOMAIN` – domain appended to `HOSTNAME`
- `HOSTNAME` – machine hostname
- `IP_GATEWAY` – default gateway
- `IP_NAMESERVER` – DNS server
- `IP_SERVER` – static IP address assigned during install
- `DISK` – installation disk (e.g. `/dev/sda`)
- `ROOT_PASSWORD_CRYPTED` – hashed root password (`openssl passwd -6 'pass'`)
- `USER_PASSWORD_CRYPTED` – hashed password for the `homelab` user

### Running preseed

1. Adjust `config/preseed.cfg` if you need to change language, network, or disk target. The file uses `/dev/sda` by default; replace with `/dev/nvme0n1` or another drive as needed. Running the script with `--preseed-cfg` fills the template using values from `src/config/.env`. If omitted, the default `config/preseed.cfg` is used unchanged.
2. Generate the installer ISO in `iso/<image>_preseed.iso`:
   ```bash
   sudo ./create_preseeded_iso.sh --preseed-cfg
   ```
3. Flash the ISO to a USB key:
   ```bash
   sudo dd if=iso/debian-12.9.0-amd64-netinst_preseed.iso of=/dev/sdX bs=4M status=progress && sync
   ```
   On Windows, use Rufus. 
4. Boot the target machine from the USB drive. Installation runs automatically. Insert the drive in a USB 2.0 port for best compatibility.

## Details

### Documentation

- <https://www.debian.org/releases/bookworm/example-preseed.txt>
- <https://gist.githubusercontent.com/zyra83/fd9409d618944ecb71269a86830805b6/raw/8049c3aa3bbd8a7951e579d44892150b77171ad1/amd64-main-full.txt>
- <https://github.com/yannbreizh/debian-installer/blob/master/preseed-192.168.10.35.cfg>
- <https://github.com/Tontonjo/debian/blob/master/preseed/jo/preseed.cfg>

### Utilities

- Check network info: `netstat -rn` or `ip addr`
- Remove saved SSH host keys: `ssh-keygen -R <ip>` (if server reinstalled)
- Generate a fresh Ansible key pair:
  ```bash
  ssh-keygen -t rsa -b 4096 -f ../config/ssh/ansible/ansible_key
  ```
- The preseeded system includes `reset_server.sh` under `/root/bin`. Run it to reboot from the USB installer:
  ```bash
  sudo /root/bin/reset_server.sh /dev/sda
  ```
