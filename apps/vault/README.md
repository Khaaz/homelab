# vault

## Context

### Overview

Self-hosted password manager compatible with Bitwarden clients. This stack provides secure, private password management for your home or organization.

### Services

- **Vaultwarden**: Password manager

## Architecture

### Schema

(To be added)

### Features

- Single-container deployment: Vaultwarden runs in a dedicated Docker container on its own isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `vaultwarden/`
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

| Variable              | Description                                 | Example         |
|-----------------------|---------------------------------------------|-----------------|
| VAULTWARDEN_HOST_IP   | IP of the machine that hosts this stack     | 192.168.1.106   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable                | Description                                   | Example         |
|-------------------------|-----------------------------------------------|-----------------|
| VAULTWARDEN_ADMIN_TOKEN | Hashed admin token (see instructions in .env) | $argon2id$...   |

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

This will launch the Vaultwarden container and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:8087` (or your reverse proxy domain)
- **Default port:** `8087`

## Infrastructure

### Proxmox VM Configuration

```yaml
specs:
  cores: 1                    
  ram_size: 2048              
  disk_size: 10               
  additional_disks: []        

order_tier: 3                 

config:
  docker: true                
  router: false               
  routes:                     
    - network: 10.10.31.0/24  # Route to extern
      via: 10.10.32.2         # via firewall-srv
  dns_servers: [1.1.1.1, 8.8.8.8]

nics:                         
  - bridge: vmbr3             
    vlan: 32                  # VLAN ID (intern)
    ipv4: 10.10.32.15/24      
    gateway: 10.10.32.1       

nas: null
```

### Network Architecture

- **Network**: 10.10.32.0/24 (intern VLAN 32)
- **VM IP**: 10.10.32.15

### Firewall Rules

**Authorized traffic:**
- **SSH (port 22)**: From jump server (10.10.32.9)
- **All ports**: From reverse-proxy (10.10.32.10) and extern network
- **Docker**: Full container networking

## Details

### Services and ports

- Vaultwarden - `8087`

### Use cases

- Secure password management
- Bitwarden client compatibility

### Documentation

- [Vaultwarden Main Site](https://github.com/dani-garcia/vaultwarden)
- [Vaultwarden Wiki](https://github.com/dani-garcia/vaultwarden/wiki)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration
