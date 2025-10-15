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
