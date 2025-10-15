# firewall-mgmt

## Context

### Overview

Management firewall VM for the homelab network. This is an infrastructure-only component that provides network security and routing for the management segment through nftables rules and VM configuration.

### Services

- **nftables**: Firewall rules and network routing
- **VM infrastructure**: Proxmox VM with network configuration

## Architecture

### Schema

(To be added)

### Features

- Management network security: Provides firewall protection for the management network segment
- Routing configuration: Handles traffic routing for management interfaces and access
- Infrastructure-as-code: VM and network configuration defined in YAML and configuration files
- Proxmox deployment: Designed for deployment on Proxmox virtualization platform

### File structure

- `infra/`: Infrastructure configuration for deployment.
  - `local.env.default` & `local.env.template`: Local deployment configuration
  - `proxmox.yml`: Proxmox VM specification for deployment
  - `nftable.conf`: Firewall rules configuration
  - `app-infra.template.toml`: Infrastructure configuration template

## Setup

### Deployment

This is an infrastructure-only component that is deployed as a Proxmox VM with firewall configuration. There are no Docker containers for this stack.

### Environment files

Configuration is managed through:

- `local.env.default` & `local.env.template`: Local deployment settings
- `proxmox.yml`: VM specifications including CPU, memory, network configuration
- `nftable.conf`: Firewall rules and routing configuration

## Details

### Use cases

- Management network firewall
- Administrative access control
- Network monitoring and management traffic security

### Documentation

- [nftables documentation](https://wiki.nftables.org/)
- [Proxmox VE documentation](https://pve.proxmox.com/wiki/Main_Page)

### Troubleshooting

- Check VM logs in Proxmox interface
- Review network configuration in `infra/proxmox.yml`
- Verify firewall rules in `nftable.conf`
- Check VM status and network connectivity
