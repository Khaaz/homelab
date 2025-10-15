# media-server

## Context

### Overview

Media streaming stack running Plex with Overseerr for managing user requests. This stack provides centralized media streaming and request management for movies and TV shows.

### Services

- **Plex**: Media server for streaming content
- **Overseerr**: Request management for users

## Architecture

### Schema

(To be added)

### Features

- Multi-container deployment: Plex and Overseerr run in dedicated containers on an isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `plex/`, `overseerr/`
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

| Variable              | Description                                      | Example           |
|-----------------------|--------------------------------------------------|-------------------|
| MEDIA_SERVER_HOST_IP  | IP of the machine that hosts this stack          | 192.168.1.103     |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable                   | Description                                                         | Example                |
|----------------------------|---------------------------------------------------------------------|------------------------|
| EXTERNAL_DOMAIN            | External domain (reverse proxy)                                     | example.com            |
| INTERNAL_DOMAIN            | Internal domain (reverse proxy)                                     | l.ab            |
| PLEX_CLAIM                 | Plex claim token (from https://plex.tv/claim or Preferences.xml)    | claim-xxxx             |
| PLEX_MACHINE_IDENTIFIER    | Plex server machine identifier (Preferences.xml)                    | xxxxxxxx               |
| PLEX_USERNAME              | Plex account username                                               | user                   |
| PLEX_EMAIL                 | Plex account email                                                  | user@email.com         |
| PLEX_FRIENDLY_NAME         | Name of your Plex server in the UI (default: media-server)          | media-server           |
| API_KEY_OVERSEERR          | API key for Overseerr to access Plex                                | randomstring           |
| WEBHOOK_OVERSEERR_DISCORD  | Discord webhook URL for Overseerr notifications (optional)          | webhook-url            |
| API_KEY_RADARR4K           | API key for Radarr4K (shared with media-management stack)           | randomstring           |
| API_KEY_RADARR             | API key for Radarr (shared with media-management stack)             | randomstring           |
| API_KEY_SONARR             | API key for Sonarr (shared with media-management stack)             | randomstring           |
| API_KEY_SONARR4K           | API key for Sonarr4K (shared with media-management stack)           | randomstring           |

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

This will launch Plex and Overseerr containers and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:32400` (Plex) and `http://127.0.0.1:5055` (Overseerr), or via your reverse proxy domain.
- **Default ports:** Plex - `32400`, Overseerr - `5055`

## Infrastructure

### Proxmox VM Configuration

The `infra/proxmox.yml` file defines the VM specifications for Proxmox deployment:

```yaml
specs:
  cores: 2                    # CPU cores allocated to VM (higher for transcoding)
  ram_size: 3072              # RAM in MB (higher for media processing)
  disk_size: 10               # Disk size in GB
  additional_disks: []        # Additional disks (empty for this app)
  pci_devices:                # PCI passthrough devices for hardware transcoding
    - mapping: "pci_igpu_mapping"  # Intel iGPU for Plex hardware transcoding (Quick Sync)
    # Note: The mapping 'pci_igpu_mapping' is created by Ansible playbook 4.additional-setup
    # Find your Intel iGPU PCI address with: lspci | grep -i vga
    # Common PCI address: 0000:00:02.0 (Intel Integrated Graphics)

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
    ipv4: 10.10.31.11/24      # Static IP address
    gateway: 10.10.31.1       # Default gateway

nas:                          # NAS mount configuration for media storage
  ip: "10.10.32.30"           # NAS VM IP address
  mount_path: "/mnt/data"     # Local mount point
  nfs_export: "/media"        # NFS export path on NAS
```

**Key concepts:**
- **order_tier**: Controls deployment order (1=infrastructure, 2=management, 3=applications)
- **docker**: Enables automatic Docker installation via cloud-init
- **routes**: Required for communication between VLANs (extern ↔ intern)
- **pci_devices**: Intel iGPU passthrough for Plex hardware transcoding (Quick Sync)
- **nas**: NFS mount from NAS VM for media file storage

### Network Architecture

This VM is deployed on the **extern network** (VLAN 31):
- **Network**: 10.10.31.0/24
- **VM IP**: 10.10.31.11
- **Gateway**: 10.10.31.1 (firewall-gw)
- **Access**: Reachable from reverse-proxy (10.10.31.10), intern network (10.10.32.0/24), and LAN (192.168.1.0/24) for Plex

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

    # Plex local network discovery from LAN
    ip saddr 192.168.1.0/24 tcp dport 32400 accept         # Plex web/streaming
    ip saddr 192.168.1.0/24 udp dport 32410-32414 accept   # Plex network discovery
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
- **Plex (port 32400 TCP, 32410-32414 UDP)**: From LAN (192.168.1.0/24) for local streaming
- **Docker**: Full container networking enabled
- **Outgoing**: All outgoing connections allowed

## Details

### Services and ports

- Plex - `32400`
- Overseerr - `5055`

### Use cases

- Centralized media streaming
- User request management

### Documentation

- [Plex Main Site](https://www.plex.tv/)
- [Overseerr](https://overseerr.dev/)
- <https://github.com/plexinc/pms-docker>
- <https://github.com/sct/overseerr>
- <https://support.plex.tv/articles/> 
- <https://docs.overseerr.dev/>

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
