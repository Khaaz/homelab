# immich

## Context

### Overview

Self-hosted photo and video backup solution built around the Immich project. This stack provides secure, private media storage and automatic backup for photos and videos, with face/object detection and a modern web UI.

### Services

- **Immich server**: Main application for media management and backup.
- **Machine learning module**: Face and object detection for media.
- **PostgreSQL**: Metadata database for Immich.
- **Redis**: Job queue for background tasks.

## Architecture

### Schema

(To be added)

### Features

- Single-container deployment: Runs Immich in a dedicated Docker container on its own isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- Auto-discovery: Immich will auto-discover supported devices and allow you to set up automations via its web UI.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `immich/`
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

- SQL files in `_setup/sql` are executed against the database
- Template files in `_setup/templates` are parsed and filled with environment variable values. 

These operations are handled via the `post_start` hook in the Docker Compose configuration, using scripts located in `src/app-bootstrap` at the root of the monorepo.

A setup directory look like this:

- `_setup/`: Initial configuration templates applied on first container start.
  - `_setup/sql/`: SQL files to be executed against the database (if any).
  - `_setup/templates/`: Template files parsed and filled with environment variable values.

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

| Variable        | Description                                 | Example         |
|-----------------|---------------------------------------------|-----------------|
| IMMICH_HOST_IP  | IP of the machine that hosts this stack     | 192.168.1.101   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable     | Description                                 | Example           |
|--------------|---------------------------------------------|-------------------|
| DB_PASSWORD  | PostgreSQL database password                 | longpassword123   |

You may override any other environment variable as needed in either file.

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

This will launch the Immich containers and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:2283` (or `https://immich.l.ab` with reverse proxy setup)
- **Default port:** `2283`

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
    ipv4: 10.10.31.12/24      # Static IP address
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
- **VM IP**: 10.10.31.12
- **Gateway**: 10.10.31.1 (firewall-gw)
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

- Immich server - `2283`
- Machine learning module - internal only
- PostgreSQL - internal only
- Redis - internal only

### Use cases

- Private photo/video backup
- Face/object detection
- Mobile and web access

### Documentation

- [Immich Main Site](https://immich.app/)
- [GitHub](https://github.com/immich-app/immich)
- [Official Documentation](https://immich.app/docs/)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
