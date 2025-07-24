# nextcloud

## Context

Self-hosted file storage platform built with Nextcloud backed by MariaDB and
Redis.

### Services
- Nextcloud – main application
- MariaDB – database
- Redis – cache and lock management
- Post-processing helper

## Architecture

The stack includes Nextcloud, MariaDB, Redis and a small post-processing
container, all running on a dedicated Docker network.

## Setup

### Initial setup
1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set the host IP and desired subdomain.
2. Copy `src/config/.env.template` to `src/config/.env` and provide database
   credentials.

### Environment files
- `.env`
  - `NEXTCLOUD_ADMIN_USER` – administrator username
  - `NEXTCLOUD_ADMIN_PASSWORD` – administrator password
  - `MYSQL_USER` – database user
  - `MYSQL_PASSWORD` – database password (generate with `openssl rand -base64 32`)
- `networking.env`
  - `NEXTCLOUD_HOST_IP` – IP address of the VM
  - `NEXTCLOUD_DOMAIN` – subdomain served by the reverse proxy

### Running
Start the stack with `./compose.sh up -d`.

### _setup directory
Configuration templates in `_setup` are copied to the container during the
first run.

## Details

### Services and ports
- Nextcloud – `8081`
- MariaDB – internal only
- Redis – internal only
- Post-processing helper – internal only

### Documentation
- <https://docs.nextcloud.com/>
