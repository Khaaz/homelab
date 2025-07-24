# preseeding

## Context

Automated installation of Debian using a preseed configuration. This allows the
server to be provisioned without manual input and prepares it for subsequent
automation.

## Architecture

The folder contains the preseed configuration and scripts used to build a
bootable ISO image.

- `config/` – final preseed and bootloader files
- `config/custom/` – helper scripts and SSH keys copied during install
- `iso/` – output directory for the generated ISO
- `log/` – logs and generated files for debugging
- `create_preseeded_iso.sh` – utility script to build the ISO
- `generate_preseed_cfg.sh` – builds `config/preseed.cfg` from the template

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

After installation the system provides both the `homelab` account and an
`ansible` user configured with your SSH key. The helper script `reset_server.sh`
can be executed on the server to adjust the EFI boot order and reboot from the
USB installer when required:

```bash
sudo /root/bin/reset_server.sh /dev/sdX
```

## Setup

### Initial setup

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

### Environment files

Copy `src/config/.env.template` to `src/config/.env` and edit the values:

- `DOMAIN` – domain appended to `HOSTNAME`
- `HOSTNAME` – machine hostname
- `IP_GATEWAY` – default gateway
- `IP_NAMESERVER` – DNS server
- `IP_SERVER` – static IP address assigned during install
- `DISK` – installation disk (e.g. `/dev/sda`)
- `ROOT_PASSWORD_CRYPTED` – hashed root password (`openssl passwd -6 'pass'`)
- `USER_PASSWORD_CRYPTED` – hashed password for the `homelab` user

### Running

1. Adjust `config/preseed.cfg` if you need to change the language, network
   configuration or disk target. The file uses `/dev/sda` by default but you can
   replace it with `/dev/nvme0n1` or another drive. Running the script with
   `--preseed-cfg` automatically fills the template using values from
   `src/config/.env`. If omitted, the default `config/preseed.cfg` is used
   unchanged.
2. Generate the installer ISO in `iso/<image>_preseed.iso`:
   ```bash
   sudo ./create_preseeded_iso.sh --preseed-cfg
   ```
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

- <https://www.debian.org/releases/bookworm/example-preseed.txt>
- <https://gist.githubusercontent.com/zyra83/fd9409d618944ecb71269a86830805b6/raw/8049c3aa3bbd8a7951e579d44892150b77171ad1/amd64-main-full.txt>
- <https://github.com/yannbreizh/debian-installer/blob/master/preseed-192.168.10.35.cfg>
- <https://github.com/Tontonjo/debian/blob/master/preseed/jo/preseed.cfg>

### Utilities

Check network information with `netstat -rn` (or `ip addr`).
Remove saved SSH host keys with `ssh-keygen -R <ip>` if the server has been reinstalled.
Generate a fresh Ansible key pair:

```bash
ssh-keygen -t rsa -b 4096 -f ../config/ssh/ansible/ansible_key
```

The preseeded system includes `reset_server.sh` under `/root/bin`.
Run it on the server to reboot from the USB installer again:

```bash
sudo /root/bin/reset_server.sh /dev/sda
```
