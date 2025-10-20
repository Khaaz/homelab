# firewall-srv

## Context

### Overview

Firewall VM for the services network segment. This is an infrastructure-only component that provides network security and routing for the homelab services through nftables rules and VM configuration.

### Services

- **nftables**: Firewall rules and network routing
- **VM infrastructure**: Proxmox VM with network configuration

## Architecture

### Schema

(To be added)

### Features

- Network segmentation: Provides firewall protection for the services network
- Routing configuration: Handles traffic routing between network segments
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

nics:                         # Network interface configuration (VLAN trunking)
  - bridge: vmbr3             # Proxmox bridge (srv network with VLAN trunking)
    trunks:                   # VLAN trunk configuration
      - id: 31                # VLAN 31 (extern)
        ipv4: 10.10.31.2/24   # IP on extern VLAN
        gateway: 10.10.31.1   # Gateway (firewall-gw)
      - id: 32                # VLAN 32 (intern)
        ipv4: 10.10.32.2/24   # IP on intern VLAN

nas: null                     # NAS mount configuration (null = not applicable for firewall)
```

**Key concepts:**
- **order_tier**: 1 = infrastructure layer (deployed after core infrastructure)
- **router**: true = enables IP forwarding between extern and intern VLANs
- **docker**: false = no Docker installation (pure infrastructure VM)
- **VLAN trunks**: Single bridge with two VLANs (31 and 32) for routing between them

### Network Architecture

This VM is the **service network router** routing traffic between extern and intern VLANs:

**Interfaces:**
1. **VLAN 31 (extern)**: 10.10.31.2/24
   - Gateway: 10.10.31.1 (firewall-gw)
   - Purpose: External-facing applications
   
2. **VLAN 32 (intern)**: 10.10.32.2/24
   - Purpose: Internal applications

**Routing:**
- Routes traffic between extern (10.10.31.0/24) and intern (10.10.32.0/24) networks
- Allows inter-VLAN communication for service dependencies
- All applications use this as their route to the other VLAN

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
    ip saddr 10.10.31.9 tcp dport 22 accept   # Allow SSH from firewall-mgmt (extern side)
    ip saddr 10.10.32.9 tcp dport 22 accept   # Allow SSH from firewall-mgmt (intern side)
}

# FORWARD chain - traffic THROUGH this firewall VM
chain forward {
    policy drop;                        # Default deny all forwarding

    ct state established,related accept # Allow established connections

    # Bidirectional routing between extern and intern
    ip saddr 10.10.31.0/24 ip daddr 10.10.32.0/24 accept   # extern → intern
    ip saddr 10.10.32.0/24 ip daddr 10.10.31.0/24 accept   # intern → extern
}

# OUTPUT chain - outgoing traffic FROM this firewall VM
chain output {
    policy accept;                      # Allow all outgoing traffic
}
```

**Authorized traffic:**
- **SSH (port 22)**: From firewall-mgmt on both VLANs (10.10.31.9 and 10.10.32.9)
- **Inter-VLAN routing**: Full bidirectional traffic between extern and intern networks
- **Purpose**: Allows applications on different VLANs to communicate (e.g., reverse-proxy on extern can reach services on intern)

## Details

### Use cases

- Network firewall for services segment
- Traffic routing between network zones
- Security policy enforcement

### Documentation

- [nftables documentation](https://wiki.nftables.org/)
- [Proxmox VE documentation](https://pve.proxmox.com/wiki/Main_Page)

### Troubleshooting

- Check VM logs in Proxmox interface
- Review network configuration in `infra/proxmox.yml`
- Verify firewall rules in `nftable.conf`
- Check VM status and network connectivity
