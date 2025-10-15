# notes

## Context

### Overview

Note-taking and documentation stack for the homelab. This stack provides a self-hosted note management solution with markdown support and web interface.

### Services

- **Notes Application**: Self-hosted note-taking service (to be implemented)

## Architecture

### Schema

(To be added)

### Features

- Container deployment: Runs application in a dedicated Docker container on an isolated Docker network for security and reliability
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains
- Extensible: Add functionality with integrations, add-ons, and custom scripts

### File structure

- `apps/`: Contains all apps for this stack
  - Application directories (to be configured)
- `src/`: Docker Compose file and configuration templates
  - `docker-compose.yaml`
- `config/`: Stores environment files and configuration templates
  - `.env.default` - Default environment variables
  - `.env.template` - Template for custom environment variables
  - `networking.env.default` - Default networking configuration
  - `networking.env.template` - Template for custom networking configuration
  - `proxmox.env` - Additional Proxmox-specific variables (when using --proxmox)
- `infra/`: Infrastructure configuration for deployment
  - `local.env.default` & `local.env.template`: Local deployment configuration
  - `proxmox.yml`: Proxmox VM specification for deployment
  - `nftable.conf`: Firewall rules configuration
- `compose.sh`: Main script to start the stack

### _setup directory

A `_setup` directory can be added in each app in the stack to help automating the setup of the app.

Configuration templates stored in `_setup` are automatically applied the first time the container is started, ensuring a consistent initial setup.

- SQL files in `_setup/sql` are executed against the database (if any)
- Template files in `_setup/templates` are parsed and filled with environment variable values

These operations are handled via the `post_start` hook in the Docker Compose configuration, using scripts located in `src/app-bootstrap` at the root of the monorepo.

## Setup

### Initial setup

1. Copy the networking environment template:
   ```bash
   cp config/networking.env.template config/networking.env
   ```
   Adjust the environment variables, see next section.
   
2. Copy the main environment template:
   ```bash
   cp config/.env.template config/.env
   ```
   Adjust the environment variables, see next section.

### Environment files

This stack uses a layered environment configuration system with the following priority (later files override earlier ones):

1. `config/.env.default` - Default values for all variables
2. `config/networking.env.default` - Default networking configuration  
3. `config/networking.env` - Custom networking overrides (copied from template)
4. `config/proxmox.env` - Proxmox-specific variables (only when using --proxmox flag)
5. `config/.env` - Custom application overrides (copied from template)

**networking.env**: Used to configure network settings for the stack (see `networking.env.template`).

| Variable            | Description                                 | Example       |
|---------------------|---------------------------------------------|---------------|
| NOTES_DOCKER_SUBNET | Docker subnet used for this compose network | 172.30.3      |
| PORT_UI_*           | Exposed ports for UI access                 | 8123          |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

You may override any other environment variable as needed in either file.

### Deployment options

The `compose.sh` script supports two deployment modes:

**Local development:**
```bash
./compose.sh up -d
```
Uses IP from `infra/local.env` files for local development.

**Proxmox deployment:**
```bash
./compose.sh --proxmox up -d
```
Uses IP from `infra/proxmox.yml` and includes `config/proxmox.env` for Proxmox-specific variables.

**Available compose commands:**
```bash
./compose.sh [--proxmox] <compose-command> [options]
```
Examples:
- `./compose.sh up -d` - Start containers in detached mode
- `./compose.sh down` - Stop and remove containers
- `./compose.sh restart` - Restart containers
- `./compose.sh logs -f` - Follow container logs
- `./compose.sh ps` - List containers

### Accessing service

- **URL:** `http://127.0.0.1:PORT` (or via reverse proxy)
- **Default port:** (to be configured)

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

order_tier: 3                 # Deployment order (tier 3 = application layer)

config:
  docker: true                # Enable Docker installation
  router: false               # Not a routing VM
  routes:                     # Static routes for inter-VLAN communication
    - network: 10.10.32.0/24  # Route to intern network
      via: 10.10.31.2         # via firewall-srv
  dns_servers: [1.1.1.1, 8.8.8.8]  # DNS servers

nics:                         # Network interface configuration
  - bridge: vmbr3             # Proxmox bridge (srv network)
    vlan: 31                  # VLAN ID (extern)
    ipv4: 10.10.31.13/24      # Static IP address
    gateway: 10.10.31.1       # Default gateway

nas: null                     # NAS mount configuration (null = not using NAS)
```

**Key concepts:**
- **order_tier**: Controls deployment order (1=infrastructure, 2=management, 3=applications)
- **docker**: Enables automatic Docker installation via cloud-init
- **routes**: Required for communication between VLANs (extern ↔ intern)
- **nas**: Optional NFS mount configuration for shared storage

### Network Architecture

This VM is deployed on the **extern network** (VLAN 31):
- **Network**: 10.10.31.0/24
- **VM IP**: 10.10.31.13
- **Gateway**: 10.10.31.1 (firewall-srv)
- **Access**: Reachable from reverse-proxy (10.10.31.10) and intern network (10.10.32.0/24)

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
    ip saddr 10.10.31.9 tcp dport 22 accept   # Allow SSH from jump server
    tcp dport 22 drop                          # Block SSH from everywhere else

    # Application Access
    ip saddr 10.10.31.10 accept        # Allow all ports from reverse-proxy
    ip saddr 10.10.32.0/24 accept      # Allow all ports from intern network
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
- **SSH (port 22)**: Only from jump server (10.10.31.9)
- **All ports**: From reverse-proxy (10.10.31.10) and intern network (10.10.32.0/24)
- **Docker**: Full container networking enabled
- **Outgoing**: All outgoing connections allowed

## Details

### Services and ports

- Notes Application - (to be configured)

### Use cases

- Self-hosted note management
- Documentation and knowledge base
- Markdown editing and preview

### Documentation

- (Application-specific documentation to be added)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
- Test connectivity: `ping 10.10.31.13` from jump server or intern network
- Check firewall rules: `nft list ruleset` on the VM
