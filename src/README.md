# IaC

## Context

Infrastructure as Code used to provision and maintain the homelab.

## Architecture

Ansible playbooks automate Proxmox configuration, virtual machine creation,
firewall rules and application deployment. Additional shell scripts will manage
VM lifecycle operations and keep environment files in sync directly from the
Proxmox host.

## Setup

### Initial setup
1. Edit `ansible/inventory.ini` to list the target hosts.

### Running the playbooks
Run the playbooks in `ansible/playbooks` with `ansible-playbook`.

### Helper scripts
Use the scripts in `scripts/` to deploy new VMs or update existing ones.

## Details

### Documentation
*(add references here)*
