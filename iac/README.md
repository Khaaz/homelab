# iac

## Context

### Overview

Infrastructure as Code stack for provisioning and maintaining the homelab. Uses Ansible to automate Proxmox installation, VM creation, and application deployment.

### Services

- **Proxmox**: Virtualization platform for homelab infrastructure
- **Ansible**: Automation for installation, configuration, and deployment

## Architecture

### Features

- Automated Proxmox installation and configuration
- VM creation and network setup
- Application deployment via Ansible roles
- Network bridges for public and private traffic
- Modular playbooks and templates for easy customization

### File structure

- `ansible/`: Playbooks, roles, templates for provisioning and configuration
  - `logs/`: ansible logs
  - `playbooks/`: ansible playbook
    - `proxmox-setup.playbook.yml`: Setup proxmox on a debian server
    - `test.playbook.yml`: Test ansible connection
  - `roles/`: reusable tasks
  - `templates/`: jinja files
  - `ansible.cfg`
  - `inventory.ini`

## Network

Templates define network interfaces:

- `vmbr0`: Public bridge (Proxmox, reverse proxy)
- `vmbr1`: Private network `10.10.1.0/24`
- `vmbr2`: Private network `10.10.2.0/24`

## Setup

### Initial setup

1. Install Ansible:
   ```bash
   sudo apt-get update && sudo apt-get install -y ansible
   ```
   Or with pip:
   ```bash
   python3 -m pip install --user ansible
   ```
   Upgrade:
   ```bash
   python3 -m pip install --upgrade --user ansible
   ```
2. Edit `ansible/inventory.ini` to list target hosts.

### Running IaC

Check ansible connection:

```bash
ansible-playbook playbooks/test.playbook.yml
```

Run the Proxmox setup playbook:

```bash
ansible-playbook playbooks/proxmox-setup.playbook.yml
```

## Details

### Documentation

- <https://pve.proxmox.com/wiki/Unattended_installation_of_Proxmox>
- <https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm>
- <https://pve.proxmox.com/wiki/Network_Configuration#_default_configuration_using_a_bridge>
- <https://github.com/YosefCohen877/USB-Unattended-Proxmox>

### Utilities

- Check network info: `ip addr`, `netstat -rn`
