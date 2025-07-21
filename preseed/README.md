# preseeding

## Context

Automated installation of Debian using a preseed configuration. This allows the
server to be provisioned without manual input and prepares it for subsequent
automation.

## Architecture

The folder contains the preseed configuration and a script to build a bootable
ISO image.

- `config/` – preseed files and bootloader configuration
- `custom/` – additional scripts executed during install
- `iso/` – output directory for the generated ISO
- `create_preseeded_iso.sh` – utility script to build the ISO

### Preseed contents

`config/preseed.cfg` answers the Debian installer questions automatically and
executes a small post-install script. Key actions include:

- setting the locale and timezone
- partitioning `/dev/sda` using a simple layout (adjust in the file if your
  disk is `/dev/nvme0n1` or other)
- installing base packages such as `sudo`, `curl`, `vim` and network utilities
- enabling root SSH login
- creating a `homelab` user with password `homelab!`
- creating an `ansible` user with your public SSH key
  - copying helper scripts, including `reset_server.sh`, to `/root/bin`. The
    `reset_server.sh` script adjusts the EFI boot order so the machine can boot
    again from the USB installer when needed
- rebooting automatically once installation completes

## Setup

### Prerequisites

- Download the official Debian netinst ISO referenced in `create_preseeded_iso.sh`
  (by default `debian-12.9.0-amd64-netinst.iso`) and place it in the `iso/`
  directory. The image can be fetched directly with:
  ```bash
  curl -L -o iso/debian-12.9.0-amd64-netinst.iso \
    https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso
  ```
  You may adjust the file name and version in the script if needed.
- Ensure you have a Linux or WSL environment with root privileges.
- Install the required tooling:
  ```bash
  sudo apt-get update && sudo apt-get install -y xorriso
  ```

1. Adjust `config/preseed.cfg` if you need to change the language, network
   configuration or disk target. The file uses `/dev/sda` by default but you can
   replace it with `/dev/nvme0n1` or another drive.
2. Execute `sudo ./create_preseeded_iso.sh` to generate the installer ISO in
   `iso/<image>_preseed.iso`.
3. Flash the ISO to a USB key, e.g.:
   ```bash
   sudo dd if=iso/debian-12.9.0-amd64-netinst_preseed.iso of=/dev/sdX bs=4M status=progress && sync
   ```
   On Windows you can use Rufus instead. Insert the drive in a USB 2.0 port for
   best compatibility.
4. Boot the target machine from the USB drive and the installation will run
   automatically.

## Details

### Documentation
- <https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm>
- <https://pve.proxmox.com/wiki/Unattended_installation_of_Proxmox>
