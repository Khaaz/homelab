# firewall-gw

## Context

### Overview

Gateway firewall VM for the homelab network. This is an infrastructure-only component that provides network security and routing for the gateway segment through nftables rules and VM configuration.

### Services

- **nftables**: Firewall rules and network routing
- **VM infrastructure**: Proxmox VM with network configuration

## Architecture

### Schema

(To be added)

### Features

- Network gateway: Provides firewall protection for the gateway network segment
- Routing configuration: Handles traffic routing between external and internal networks
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

order_tier: 0                 # Deployment order (tier 0 = core infrastructure, deployed FIRST)

config:
  docker: false               # NO Docker (infrastructure-only VM)
  router: true                # THIS IS A ROUTER VM (enables IP forwarding)
  routes: []                  # No additional routes (this VM IS the router)
  dns_servers: [1.1.1.1, 8.8.8.8]  # DNS servers

nics:                         # Network interface configuration (MULTIPLE NICs)
  - bridge: vmbr1             # Proxmox bridge (gw network)
    ipv4: 10.10.1.2/24        # Static IP on gateway network
    gateway: 10.10.1.1        # Gateway to external network
  
  - bridge: vmbr2             # Proxmox bridge (mgmt network)
    ipv4: 10.10.2.1/24        # Static IP on management network (no gateway)
  
  - bridge: vmbr3             # Proxmox bridge (srv network with VLAN trunking)
    trunks:                   # VLAN trunk configuration
      - id: 30                # VLAN 30 (dmz)
        ipv4: 10.10.30.1/24   # IP on DMZ VLAN
      - id: 31                # VLAN 31 (extern)
        ipv4: 10.10.31.1/24   # IP on extern VLAN
      - id: 32                # VLAN 32 (intern)
        ipv4: 10.10.32.1/24   # IP on intern VLAN

nas: null                     # NAS mount configuration (null = not applicable for firewall)
```

**Key concepts:**
- **order_tier**: 0 = core infrastructure (deployed before everything else)
- **router**: true = enables IP forwarding, allowing this VM to route traffic between networks
- **docker**: false = no Docker installation (pure infrastructure VM)
- **Multiple NICs**: This VM has interfaces on multiple networks to route between them
- **VLAN trunks**: Bridge vmbr3 carries multiple VLANs (30, 31, 32) with separate IPs on each

### Network Architecture

This VM is the **central gateway router** connecting all network segments:

**Interfaces:**
1. **Gateway network** (vmbr1): 10.10.1.2/24
   - Gateway: 10.10.1.1 (external network)
   - Purpose: Connection to external network/internet
   
2. **Management network** (vmbr2): 10.10.2.1/24
   - Purpose: Gateway for management VLAN (jump servers, monitoring)
   
3. **Service network with VLANs** (vmbr3):
   - **VLAN 30 (DMZ)**: 10.10.30.1/24 - Gateway for DMZ services (reverse proxy)
   - **VLAN 31 (extern)**: 10.10.31.1/24 - Gateway for external-facing apps
   - **VLAN 32 (intern)**: 10.10.32.1/24 - Gateway for internal apps

**Routing:**
- All VMs use this firewall as their default gateway
- Routes traffic between VLANs according to firewall rules
- Provides NAT for outbound internet access

### Firewall Rules

The `infra/nftable.conf` file defines nftables firewall rules for this VM:

```nftables
# INPUT chain - incoming traffic TO this firewall VM
chain input {
    policy drop;                        # Default deny all incoming

    ct state established,related accept # Allow established connections
    ct state invalid drop               # Drop invalid packets
    iifname "lo" accept                 # Allow loopback

    # ICMP
    ip protocol icmp accept             # Allow ping (IPv4)
    ip6 nexthdr icmpv6 accept          # Allow ping (IPv6)

    # SSH Access
    ip saddr 10.10.1.9 tcp dport 22 accept   # Allow SSH from jump server only
}

# FORWARD chain - traffic THROUGH this firewall VM
chain forward {
    policy drop;                        # Default deny all forwarding

    ct state established,related accept # Allow established connections

    # Forward to reverse proxy (HTTPS)
    ip saddr != 10.10.0.0/16 ip daddr 10.10.30.10 tcp dport 443 accept

    # Forward to jump server (SSH from LAN)
    ip saddr 192.168.1.0/24 ip daddr 10.10.2.10 tcp dport 22 accept

    # Forward to DNS server (from anywhere)
    ip daddr 10.10.1.200 udp dport 53 accept
    ip daddr 10.10.1.200 tcp dport 53 accept

    # Forward to Plex (from LAN only)
    ip saddr 192.168.1.0/24 ip daddr 10.10.31.11 tcp dport 32400 accept
    ip saddr 192.168.1.0/24 ip daddr 10.10.31.11 udp dport 32410-32414 accept

    # Forward to NAS (from LAN only)
    ip saddr 192.168.1.0/24 ip daddr 10.10.32.30 tcp dport 2049 accept   # NFS
    ip saddr 192.168.1.0/24 ip daddr 10.10.32.30 tcp dport 445 accept    # SMB

    # Allow VMs to access internet
    ip saddr {10.10.1.0/24, 10.10.2.0/24, 10.10.30.0/24, 10.10.31.0/24, 10.10.32.0/24} oifname "eth0" accept
}

# OUTPUT chain - outgoing traffic FROM this firewall VM
chain output {
    policy accept;                      # Allow all outgoing traffic
}

# NAT table for DNAT and masquerading
table ip nat {
    chain prerouting {
        # DNAT: External 443 -> Reverse Proxy
        ip saddr != 10.10.0.0/16 tcp dport 443 dnat to 10.10.30.10:443

        # DNAT: External 2222 -> Jump Server SSH
        ip saddr 192.168.1.0/24 tcp dport 2222 dnat to 10.10.2.10:22

        # DNAT: Plex ports (LAN only)
        ip saddr 192.168.1.0/24 tcp dport 32400 dnat to 10.10.31.11:32400
        ip saddr 192.168.1.0/24 udp dport 32410-32414 dnat to 10.10.31.11

        # DNAT: NAS ports (LAN only)
        ip saddr 192.168.1.0/24 tcp dport 2049 dnat to 10.10.32.30:2049
        ip saddr 192.168.1.0/24 tcp dport 445 dnat to 10.10.32.30:445
    }

    chain postrouting {
        # Masquerade outbound traffic from all internal networks
        ip saddr 10.10.30.0/24 ip daddr != 10.10.1.200 oifname "eth0" masquerade  # DMZ
        ip saddr 10.10.31.0/24 ip daddr != 10.10.1.200 oifname "eth0" masquerade  # extern
        ip saddr 10.10.32.0/24 ip daddr != 10.10.1.200 oifname "eth0" masquerade  # intern
        ip saddr 10.10.2.0/24  ip daddr != 10.10.1.200 oifname "eth0" masquerade  # mgmt
    }
}
```

**Authorized traffic:**
- **SSH (port 22)**: Only from jump server (10.10.1.9)
- **HTTPS (port 443)**: Forwarded from external to reverse proxy (10.10.30.10)
- **Jump SSH (port 2222)**: DNAT to jump server from LAN
- **DNS (port 53)**: Forwarded to DNS server (10.10.1.200)
- **Plex ports**: Forwarded to media server (10.10.31.11) from LAN only
- **NAS ports (NFS/SMB)**: Forwarded to NAS (10.10.32.30) from LAN only
- **Internet access**: All internal networks can access internet (with NAT)

## Details

### Use cases

- Network gateway firewall
- External traffic routing and security
- Network segmentation and access control

### Documentation

- [nftables documentation](https://wiki.nftables.org/)
- [Proxmox VE documentation](https://pve.proxmox.com/wiki/Main_Page)

### Troubleshooting

- Check VM logs in Proxmox interface
- Review network configuration in `infra/proxmox.yml`
- Verify firewall rules in `nftable.conf`
- Check VM status and network connectivity
