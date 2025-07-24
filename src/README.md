# IaC

## Context

Infrastructure as Code used to provision and maintain the homelab.

## Architecture

Ansible playbooks automate Proxmox configuration, virtual machine creation,
firewall rules and application deployment. Additional shell scripts will manage
VM lifecycle operations and keep environment files in sync directly from the
Proxmox host.

- iac
  - ansible
- scripts

### Scripts

Collection of scripts used everywhere to help automate different things

- execute-sql
- parse-file
- parse-folder

### Ansible

roles folder, 
templates with network interfaces setup
=> interface details

inventory
playbooks

## Setup

### Ansible 

#### Initial setup

On a unix setup

1. Install ansible
2. Edit `ansible/inventory.ini` to list the target hosts.

#### Running the playbooks

Run the playbooks in `ansible/playbooks` with `ansible-playbook`.

```
ansible-playbook -i inventory.ini setup_proxmox.playbook.yml
```

## Details

### Documentation

- <https://pve.proxmox.com/wiki/Unattended_installation_of_Proxmox>
- <https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm>
- <https://pve.proxmox.com/wiki/Network_Configuration#_default_configuration_using_a_bridge>
- <https://github.com/YosefCohen877/USB-Unattended-Proxmox>
