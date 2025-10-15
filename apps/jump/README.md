# jump

## Context

### Overview

Jump server and control node for the homelab infrastructure. This is an infrastructure-only component that provides secure access to the homelab network and includes utility scripts for VM management and connectivity testing.

### Services

- **Jump server**: Secure SSH access point to the homelab network
- **VM management**: Utility scripts for VM IP resolution and connectivity testing
- **Control node**: Central point for homelab administration

## Architecture

### Schema

(To be added)

### Features

- Secure access: Provides controlled entry point to the homelab network
- VM utilities: Scripts for IP resolution and connectivity testing
- Infrastructure-as-code: VM and network configuration defined in YAML and configuration files
- Proxmox deployment: Designed for deployment on Proxmox virtualization platform

### File structure

- `src/`: Utility scripts for VM management
  - `get_vm_ip.sh`: Script to get VM IP addresses
  - `source_vms_ip.sh`: Script to source VM IP environment variables
  - `test_connectivity.sh`: Connectivity testing utilities
- `infra/`: Infrastructure configuration for deployment
  - `local.env.default` & `local.env.template`: Local deployment configuration
  - `proxmox.yml`: Proxmox VM specification for deployment
  - `nftable.conf`: Firewall rules configuration
  - `init.sh`: VM initialization script
- `ansible_vm.sh` & `ssh_vm.sh`: VM connection and management scripts

## Setup

### Deployment

This is an infrastructure-only component that is deployed as a Proxmox VM with management scripts. There are no Docker containers for this stack.

### Environment files

Configuration is managed through:

- `local.env.default` & `local.env.template`: Local deployment settings
- `proxmox.yml`: VM specifications including CPU, memory, network configuration
- Network routing configuration for access to all homelab segments

## Infrastructure

### Role in homelab

The jump server serves as the primary access point and control node for the homelab infrastructure:

- **Security gateway**: Provides secure SSH access to internal networks
- **Management hub**: Central location for running administrative scripts
- **Network bridge**: Configured with routes to all network segments (gateway, DMZ, external, internal)
- **Utility platform**: Hosts scripts for VM IP resolution and connectivity testing

### Network configuration

- Connected to management network (10.10.2.0/24)
- Routes configured to all homelab network segments
- Acts as a controlled entry point for administrative access

## Details

### Use cases

- Secure remote access to homelab infrastructure
- Central management and administration point
- VM connectivity testing and troubleshooting
- Network diagnostics and monitoring

### Documentation

- [SSH Jump Host documentation](https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Proxies_and_Jump_Hosts)
- [Proxmox VE documentation](https://pve.proxmox.com/wiki/Main_Page)

### Troubleshooting

- Check VM logs in Proxmox interface
- Review network configuration in `infra/proxmox.yml`
- Test connectivity using provided scripts in `src/`
- Check VM status and network connectivity
- Verify routing configuration for access to different network segments
