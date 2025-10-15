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

## Infrastructure

### Proxmox VM Configuration

The `infra/proxmox.yml` file defines the VM specifications for Proxmox deployment:

```yaml
specs:
  cores: 1                    # CPU cores allocated to VM
  ram_size: 2048              # RAM in MB
  disk_size: 10               # Disk size in GB
  additional_disks: []        # Additional disks (empty for this app)
  pci_devices: []             # PCI passthrough devices (empty for this app)

order_tier: 2                 # Deployment order (tier 2 = management layer)

config:
  docker: false               # NO Docker (infrastructure VM for SSH access)
  router: false               # Not a routing VM
  routes:                     # Static routes for SSH access to all networks
    - network: 10.10.1.0/24   # Route to gw network
      via: 10.10.2.2          # via firewall-mgmt
    - network: 10.10.30.0/24  # Route to dmz network
      via: 10.10.2.2          # via firewall-mgmt
    - network: 10.10.31.0/24  # Route to extern network
      via: 10.10.2.2          # via firewall-mgmt
    - network: 10.10.32.0/24  # Route to intern network
      via: 10.10.2.2          # via firewall-mgmt
  dns_servers: [1.1.1.1, 8.8.8.8]  # DNS servers

nics:                         # Network interface configuration
  - bridge: vmbr2             # Proxmox bridge (mgmt network)
    ipv4: 10.10.2.10/24       # Static IP address
    gateway: 10.10.2.1        # Default gateway (firewall-gw)

nas: null                     # NAS mount configuration (null = not using NAS)
```

**Key concepts:**
- **order_tier**: 2 = management layer (deployed after infrastructure, before applications)
- **docker**: false = no Docker (pure SSH jump server)
- **routes**: Multiple routes through firewall-mgmt to reach all networks
- **Purpose**: Central SSH access point - all SSH connections go through this server first

### Network Architecture

This VM is deployed on the **management network** (vmbr2):
- **Network**: 10.10.2.0/24
- **VM IP**: 10.10.2.10
- **Gateway**: 10.10.2.1 (firewall-gw)
- **Access**: Accessible from LAN (192.168.1.0/24), can SSH to all other networks via firewall-mgmt

### Firewall Rules

The `infra/nftable.conf` file defines nftables firewall rules for this VM:

```nftables
# INPUT chain - incoming traffic to this VM
chain input {
    policy drop;                        # Default deny all incoming

    iifname lo accept                   # Allow loopback
    ct state established,related accept # Allow established connections
    ct state invalid drop               # Drop invalid packets

    # ICMP
    ip protocol icmp accept             # Allow ping (IPv4)
    ip6 nexthdr icmpv6 accept          # Allow ping (IPv6)

    # SSH Access
    ip saddr 192.168.1.0/24 tcp dport 22 accept   # Allow SSH from LAN only
}

# OUTPUT chain - outgoing traffic from this VM
chain output {
    policy accept;                      # Allow all outgoing traffic
}
```

**Authorized traffic:**
- **SSH (port 22)**: Only from LAN (192.168.1.0/24)
- **Outgoing SSH**: Can SSH to all other VMs via firewall-mgmt routes
- **Purpose**: Secure entry point - must connect to jump server before accessing other VMs

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
