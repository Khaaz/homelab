# cloud

## Context

### Overview

Self-hosted cloud/file storage platform built with Nextcloud, backed by MariaDB and Redis. This stack provides secure, private cloud storage and collaboration tools for your home or organization.

### Services

- **Nextcloud**: Main application for file storage and collaboration
- **MariaDB**: Database for Nextcloud
- **Redis**: Cache and lock management
- **Post-processing helper**: Additional automation tasks

## Architecture

### Schema

(To be added)

### Features

- Multi-container deployment: All services run in dedicated containers on an isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `nextcloud/`, `mariadb/`, `redis/`
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

| Variable           | Description                                 | Example         |
|--------------------|---------------------------------------------|-----------------|
| CLOUD_HOST_IP      | IP of the machine that hosts this stack     | 192.168.1.104   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable                | Description                                 | Example         |
|-------------------------|---------------------------------------------|-----------------|
| NEXTCLOUD_ADMIN_USER    | Nextcloud administrator username            | nextcloud       |
| NEXTCLOUD_ADMIN_PASSWORD| Nextcloud administrator password            | long_password   |
| MYSQL_USER              | Database user                               | nextcloud       |
| MYSQL_PASSWORD          | Database password (generate with openssl)   | long_password   |

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

This will launch all containers and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:8081` (or your reverse proxy domain)
- **Default port:** `8081`

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
    - network: 10.10.31.0/24  # Route to extern network
      via: 10.10.32.2         # via firewall-srv
  dns_servers: [1.1.1.1, 8.8.8.8]  # DNS servers

nics:                         # Network interface configuration
  - bridge: vmbr3             # Proxmox bridge (srv network)
    vlan: 32                  # VLAN ID (intern)
    ipv4: 10.10.32.12/24      # Static IP address
    gateway: 10.10.32.1       # Default gateway

nas: null                     # NAS mount configuration (null = not using NAS)
```

**Key concepts:**
- **order_tier**: Controls deployment order (1=infrastructure, 2=management, 3=applications)
- **docker**: Enables automatic Docker installation via cloud-init
- **routes**: Required for communication between VLANs (intern ↔ extern)
- **nas**: Optional NFS mount configuration for shared storage

### Network Architecture

This VM is deployed on the **intern network** (VLAN 32):
- **Network**: 10.10.32.0/24
- **VM IP**: 10.10.32.12
- **Gateway**: 10.10.32.1 (firewall-srv)
- **Access**: Reachable from reverse-proxy (10.10.32.10) and extern network (10.10.31.0/24)

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
    ip saddr 10.10.32.9 tcp dport 22 accept   # Allow SSH from jump server
    tcp dport 22 drop                          # Block SSH from everywhere else

    # Application Access
    ip saddr 10.10.32.10 accept        # Allow all ports from reverse-proxy
    ip saddr 10.10.31.0/24 accept      # Allow all ports from extern network
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
- **SSH (port 22)**: Only from jump server (10.10.32.9)
- **All ports**: From reverse-proxy (10.10.32.10) and extern network (10.10.31.0/24)
- **Docker**: Full container networking enabled
- **Outgoing**: All outgoing connections allowed

## Details

### Services and ports

- Nextcloud - `8081`
- MariaDB - internal only
- Redis - internal only
- Post-processing helper - internal only

### Use cases

- Private cloud storage
- File sharing and collaboration

### Documentation

- [Nextcloud Documentation](https://docs.nextcloud.com/)
- <https://mariadb.com/kb/en/documentation/>
- <https://redis.io/docs/>
- <https://chrisgrime.medium.com/deploy-nextcloud-with-docker-compose-935a76a5eb78>

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
