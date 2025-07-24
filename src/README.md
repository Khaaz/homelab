# IaC

## Context

Infrastructure as Code used to provision and maintain the homelab.

## Architecture

Ansible playbooks located under `iac/ansible` install Proxmox, create virtual machines and deploy applications. Helper shell scripts in `scripts/` handle tasks such as parsing configuration files or running SQL statements.

Directory layout:

- `iac/ansible/` – playbooks, roles and templates
- `scripts/` – reusable shell utilities

### Scripts

Collection of scripts used throughout the repository:

- `execute-sql.sh` – run SQL files against a specified database
  ```bash
  ./scripts/execute-sql.sh <path_to_db> [path_to_sql_script]
  ```
- `parse-file.sh` – expand environment variables in one file and write the result elsewhere
  ```bash
  ./scripts/parse-file.sh <input-file> <output-file>
  ```
- `parse-folder.sh` – apply `parse-file.sh` recursively to a directory
  ```bash
  ./scripts/parse-folder.sh <input-directory> <output-directory>
  ```

### Ansible

Roles configure the Proxmox host and each VM. Templates define the network interfaces with the following bridges:

- `vmbr0` – public bridge used by Proxmox and the reverse proxy
- `vmbr1` – private network `10.10.1.0/24`
- `vmbr2` – private network `10.10.2.0/24`

The `setup_proxmox.playbook.yml` playbook installs Proxmox, applies the network configuration above and reboots the system. Once complete, the management UI is available at `https://<host-ip>:8006/` and you can log in as `root`.

## Setup

### Ansible

#### Initial setup

1. Install `ansible`:
   ```bash
   sudo apt-get update && sudo apt-get install -y ansible
   ```
   Or install with `pip` if you prefer:
   ```bash
   python3 -m pip install --user ansible
   ```
   To upgrade later on:
   ```bash
   python3 -m pip install --upgrade --user ansible
   ```
2. Edit `ansible/inventory.ini` to list the target hosts.

#### Running the playbooks

Run the Proxmox setup playbook with:

```bash
ansible-playbook -i inventory.ini setup_proxmox.playbook.yml
```

## Details

### Documentation

- <https://pve.proxmox.com/wiki/Unattended_installation_of_Proxmox>
- <https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm>
- <https://pve.proxmox.com/wiki/Network_Configuration#_default_configuration_using_a_bridge>
- <https://github.com/YosefCohen877/USB-Unattended-Proxmox>
