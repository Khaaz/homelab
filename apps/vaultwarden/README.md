# vaultwarden

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
- `src/`: Docker Compose file and configuration templates for Vaultwarden.
  - `docker-compose.yaml`
  - `config/`: Stores environment files and configuration templates.
- `compose.sh`: main script to start the stack

### _setup directory

A `_setup` directory can be added in each app in the stack to help automating the setup of the app.

Configuration templates stored in `_setup` are automatically applied the first time the container is started, ensuring a consistent initial setup. 

- SQL files in `_setup/sql` are executed against the database (if any)
- Template files in `_setup/templates` are parsed and filled with environment variable values. 

These operations are handled via the `post_start` hook in the Docker Compose configuration, using scripts located in `src/scripts` at the root of the monorepo.

A setup directory look like this:
- `_setup/`: Initial configuration templates applied on first container start.
  - `_setup/sql/`: SQL files to be executed against the database (if any).
  - `_setup/templates/`: Template files parsed and filled with environment variable values.

## Setup

### Initial setup

1. Copy the networking environment template:
   ```bash
   cp src/config/networking.template.env src/config/networking.env
   ```
   Adjust the environment variables, see next section.
2. Copy the main environment template:
   ```bash
   cp src/config/.env.template src/config/.env
   ```
   Adjust the environment variables, see next section.

### Environment files

**networking.env**
| Variable              | Description                                 | Example         |
|-----------------------|---------------------------------------------|-----------------|
| VAULTWARDEN_HOST_IP   | IP of the machine that hosts this stack     | 192.168.1.106   |
| VAULTWARDEN_DOMAIN    | Custom subdomain (root domain should match) | vault.l.ab      |

**.env**
| Variable                | Description                                 | Example         |
|------------------------|---------------------------------------------|-----------------|
| VAULTWARDEN_ADMIN_TOKEN| Hashed admin token (see instructions above) | $argon2id$...   |

You may override any other environment variable as needed in either file.

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch the Vaultwarden container and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:8087` (or your reverse proxy domain)
- **Default port:** `8087`

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
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
