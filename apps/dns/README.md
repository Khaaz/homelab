# dns

## Context

### Overview

Local DNS resolution service for the homelab infrastructure. This stack provides DNS resolution using Unbound, handling both recursive DNS queries and local zone resolution for internal homelab services.

### Services

- **Unbound**: Local DNS resolver for recursive lookups and local zones
- **Pre-start setup**: Configuration generator for Unbound

## Architecture

### Schema

(To be added)

### Features

- DNS server: Unbound provides both recursive DNS lookups and local zone resolution
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start
- Local zone support: Resolves homelab services to their local IP addresses
- Template-driven config: Dynamic configuration generation based on environment variables
- Extensible: Add functionality with integrations, add-ons, and custom scripts

### File structure

- `apps/`: Contains all apps for this stack.
  - `unbound/`
- `src/`: Docker Compose file and configuration templates.
  - `docker-compose.yaml`
  - `config/`: Stores environment files and configuration templates.
- `infra/`: Infrastructure configuration for deployment.
  - `local.env.default` & `local.env.template`: Local deployment configuration
  - `proxmox.yml`: Proxmox VM specification for deployment
- `compose.sh`: Main script to start the stack

### _setup directory

A `_setup` directory can be added in each app in the stack to help automating the setup of the app.

Configuration templates stored in `_setup` are automatically applied the first time the container is started, ensuring a consistent initial setup. 

- SQL files in `_setup/sql` are executed against the database (if any)
- Template files in `_setup/templates` are parsed and filled with environment variable values. 

These operations are handled via the `post_start` hook in the Docker Compose configuration, using scripts located in `src/app-bootstrap` at the root of the monorepo.

A setup directory look like this:

- `_setup/`: Initial configuration templates applied on first container start.
  - `_setup/sql/`: SQL files to be executed against the database (if any).
  - `_setup/templates/`: Template files parsed and filled with environment variable values.

### DNS server

`unbound` provides both recursive DNS lookups and local zone resolution. The domain `${INTERNAL_DOMAIN}` resolves to the reverse proxy while other homelab services are mapped to their designated IPs as defined in the environment configuration. To use these DNS records, set your devices' DNS server to this DNS server's IP address:

- **Windows** – Control Panel → Network → Adapter Settings → set the DNS server to the DNS VM IP
- **macOS** – System Settings → Network → DNS
- **Linux** – edit `/etc/resolv.conf` or your network manager configuration

The DNS server dynamically generates configuration for all homelab services based on environment variables, providing seamless resolution for the internal domain.

## Setup

### Initial setup

1. Copy the networking environment template:
   ```bash
   cp src/config/networking.env.template src/config/networking.env
   ```
   Adjust the environment variables, see next section.
2. Copy the main environment template:
   ```bash
   cp src/config/.env.template src/config/.env
   ```
   Adjust the environment variables, see next section.

### Environment files

This stack uses a layered environment configuration system with the following priority (later files override earlier ones):

1. `.env.default` - Default values for all variables
2. `networking.env.default` - Default networking configuration  
3. `networking.env` - Custom networking overrides (copied from template)
4. `.env` - Custom application overrides (copied from template)

**networking.env**: Used to configure network settings for the stack (see `networking.env.template`).

| Variable               | Description                                 | Example         |
|------------------------|---------------------------------------------|-----------------|
| DNS_HOST_IP           | IP of the machine that hosts this stack     | 192.168.1.105   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable             | Description                                                | Example     |
|----------------------|------------------------------------------------------------|-------------|
| INTERNAL_DOMAIN      | Internal domain for DNS resolution                         | l.ab        |
| HOST_LAN_IP          | Host LAN IP address                                        | 192.168.1.1 |

You may override any other environment variable as needed in either file. The DNS stack requires numerous service IP variables to generate proper DNS records for all homelab services.

### Deployment options

**Local development:**
```bash
./compose.sh up -d
```

**Proxmox deployment:**
```bash
./compose.sh --proxmox up -d
```

The `--proxmox` flag uses the IP configuration from `infra/proxmox.yml` instead of local settings.

This will launch the Unbound DNS server and apply configuration templates from `_setup` on first start.

### Accessing service

- **Service:** DNS resolution on port 53 (TCP/UDP)
- **Configuration:** Set device DNS to this server's IP

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

order_tier: 1                 # Deployment order (tier 1 = infrastructure layer)

config:
  docker: true                # Enable Docker installation
  router: false               # Not a routing VM
  routes: []                  # No additional routes needed (on gateway network)
  dns_servers: [1.1.1.1, 8.8.8.8]  # Upstream DNS servers

nics:                         # Network interface configuration
  - bridge: vmbr1             # Proxmox bridge (gw network)
    ipv4: 10.10.1.200/24      # Static IP address
    gateway: 10.10.1.2        # Default gateway (firewall-gw)

nas: null                     # NAS mount configuration (null = not using NAS)
```

**Key concepts:**
- **order_tier**: 1 = infrastructure layer (deployed first, before management and apps)
- **docker**: Enables automatic Docker installation for running Unbound container
- **routes**: Empty because DNS is on gateway network with direct access everywhere
- **nas**: Not applicable for DNS service

### Network Architecture

This VM is deployed on the **gateway network** (no VLAN):
- **Network**: 10.10.1.0/24
- **VM IP**: 10.10.1.200
- **Gateway**: 10.10.1.2 (firewall-gw)
- **Access**: Accessible from all networks (provides DNS for entire homelab)

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
    ip saddr 10.10.1.9 tcp dport 22 accept   # Allow SSH from jump server

    # DNS Service
    tcp dport 53 accept                 # Allow DNS queries (TCP) from anywhere
    udp dport 53 accept                 # Allow DNS queries (UDP) from anywhere
}

# FORWARD chain - traffic routed through this VM
chain forward {
    policy drop;                        # Default deny forwarding
    
    # Docker networking
    ip saddr 172.17.0.0/12 accept      # Allow Docker container traffic
    ip daddr 172.17.0.0/12 accept      # Allow traffic to Docker containers
}

# OUTPUT chain - outgoing traffic from this VM
chain output {
    policy accept;                      # Allow all outgoing traffic
}
```

**Authorized traffic:**
- **SSH (port 22)**: Only from jump server (10.10.1.9)
- **DNS (port 53 TCP/UDP)**: From any source (required for DNS service)
- **Docker**: Full container networking enabled
- **Outgoing**: All outgoing connections allowed (for upstream DNS queries)

## Details

### Services and ports

- Unbound - `53` (TCP/UDP)
- Pre-start setup - internal only

### DNS zones resolved

The DNS server resolves the following zones based on environment configuration:

- `${INTERNAL_DOMAIN}` - Points to reverse proxy
- Individual service subdomains - Point to their respective service IPs

### Use cases

- Local DNS resolution for homelab services
- Recursive DNS lookups for external domains
- Internal domain resolution

### Documentation

- [Unbound Documentation](https://nlnetlabs.nl/projects/unbound/)
- [Unbound Configuration](https://nlnetlabs.nl/documentation/unbound/unbound.conf/)
- [DNS Server Comparison](https://en.wikipedia.org/wiki/Comparison_of_DNS_server_software)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For DNS resolution issues, verify the `_setup/templates/unbound.conf` file
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
- Test DNS resolution with `nslookup` or `dig` commands
