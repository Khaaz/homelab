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

## Infrastructure

### Proxmox VM Configuration

The `infra/proxmox.yml` file defines the VM specifications for Proxmox deployment:

```yaml
specs:
  cores: 1                    # CPU cores allocated to VM
  ram_size: 1024              # RAM in MB (lighter than app VMs)
  disk_size: 8                # Disk size in GB (minimal, no Docker needed)
  additional_disks: []        # Additional disks (empty for this app)
  pci_devices: []             # PCI passthrough devices (empty for this app)

order_tier: 1                 # Deployment order (tier 1 = infrastructure layer)

config:
  docker: false               # NO Docker (infrastructure-only VM)
  router: true                # THIS IS A ROUTER VM (enables IP forwarding)
  routes: []                  # No additional routes needed
  dns_servers: [1.1.1.1, 8.8.8.8]  # DNS servers

nics:                         # Network interface configuration (MULTIPLE NICs)
  - bridge: vmbr2             # Proxmox bridge (mgmt network)
    ipv4: 10.10.2.2/24        # Static IP on management network
    gateway: 10.10.2.1        # Gateway (firewall-gw)
  
  - bridge: vmbr1             # Proxmox bridge (gw network)
    ipv4: 10.10.1.9/24        # Static IP on gateway network (no gateway)
  
  - bridge: vmbr3             # Proxmox bridge (srv network with VLAN trunking)
    trunks:                   # VLAN trunk configuration
      - id: 30                # VLAN 30 (dmz)
        ipv4: 10.10.30.9/24   # IP on DMZ VLAN
      - id: 31                # VLAN 31 (extern)
        ipv4: 10.10.31.9/24   # IP on extern VLAN
      - id: 32                # VLAN 32 (intern)
        ipv4: 10.10.32.9/24   # IP on intern VLAN

nas: null                     # NAS mount configuration (null = not applicable for firewall)
```

**Key concepts:**
- **order_tier**: 1 = infrastructure layer (deployed after core infrastructure)
- **router**: true = enables IP forwarding for SSH access control
- **docker**: false = no Docker installation (pure infrastructure VM)
- **Multiple NICs**: This VM has interfaces on multiple networks to control SSH access
- **VLAN trunks**: Bridge vmbr3 carries multiple VLANs (30, 31, 32) with separate IPs on each

### Network Architecture

This VM is the **management access router** providing SSH access control:

**Interfaces:**
1. **Management network** (vmbr2): 10.10.2.2/24
   - Gateway: 10.10.2.1 (firewall-gw)
   - Purpose: Primary management network interface
   
2. **Gateway network** (vmbr1): 10.10.1.9/24
   - Purpose: SSH access to gateway network VMs
   
3. **Service network with VLANs** (vmbr3):
   - **VLAN 30 (DMZ)**: 10.10.30.9/24 - SSH access to DMZ services
   - **VLAN 31 (extern)**: 10.10.31.9/24 - SSH access to external-facing apps
   - **VLAN 32 (intern)**: 10.10.32.9/24 - SSH access to internal apps

**Routing:**
- Routes SSH traffic from jump server (10.10.2.10) to all other networks
- Provides controlled SSH access point for management operations

### Firewall Rules

The `infra/nftable.conf` file defines nftables firewall rules for this VM:

```nftables
# INPUT chain - incoming traffic TO this firewall VM
chain input {
    policy drop;                        # Default deny all incoming

    iifname lo accept                   # Allow loopback
    ct state established,related accept # Allow established connections
    ct state invalid drop               # Drop invalid packets

    # ICMP
    ip protocol icmp accept             # Allow ping (IPv4)
    ip6 nexthdr icmpv6 accept          # Allow ping (IPv6)

    # SSH Access
    ip saddr 10.10.2.10 tcp dport 22 accept   # Allow SSH from jump server only
}

# FORWARD chain - traffic THROUGH this firewall VM
chain forward {
    policy drop;                        # Default deny all forwarding

    ct state established,related accept # Allow established connections

    # Forward SSH from jump server to all networks
    ip saddr 10.10.2.10 ip daddr 10.10.1.0/24  tcp dport 22 accept   # to gw
    ip saddr 10.10.2.10 ip daddr 10.10.30.0/24 tcp dport 22 accept   # to dmz
    ip saddr 10.10.2.10 ip daddr 10.10.31.0/24 tcp dport 22 accept   # to extern
    ip saddr 10.10.2.10 ip daddr 10.10.32.0/24 tcp dport 22 accept   # to intern
}

# OUTPUT chain - outgoing traffic FROM this firewall VM
chain output {
    policy accept;                      # Allow all outgoing traffic
}

# NAT table for masquerading
table ip nat {
    chain postrouting {
        # Masquerade SSH traffic from jump server to all networks
        ip saddr 10.10.2.10 ip daddr 10.10.1.0/24  masquerade   # gw
        ip saddr 10.10.2.10 ip daddr 10.10.30.0/24 masquerade   # dmz
        ip saddr 10.10.2.10 ip daddr 10.10.31.0/24 masquerade   # extern
        ip saddr 10.10.2.10 ip daddr 10.10.32.0/24 masquerade   # intern
    }
}
```

**Authorized traffic:**
- **SSH (port 22) TO this VM**: Only from jump server (10.10.2.10)
- **SSH (port 22) THROUGH this VM**: Only from jump server (10.10.2.10) to all networks
- **Purpose**: Centralizes SSH access control - all SSH traffic must go through jump server → firewall-mgmt → destination

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
