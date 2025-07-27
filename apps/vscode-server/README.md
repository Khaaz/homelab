# vscode-server

## Context

### Overview

Web-based VS Code instance for managing this repository remotely. This stack provides secure, remote development access to your homelab codebase.

### Services

- **code-server**: Remote VS Code instance

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
  - `vscode-server/`
- `src/`: Docker Compose file and configuration templates for vscode-server.
  - `docker-compose.yaml`
  - `config/`: Stores environment files and configuration templates.
- `compose.sh`: main script to start the stack

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
   cp src/config/networking.template.env src/config/networking.env
   ```
   Adjust the environment variables, see next section.
2. Copy the main environment template:
   ```bash
   cp src/config/template.env src/config/.env
   ```
   Adjust the environment variables, see next section.

### Environment files

**networking.env**: Used to configure network settings for the stack (see `networking.env.template`).

| Variable                   | Description                                         | Example           |
|----------------------------|-----------------------------------------------------|-------------------|
| VSCODE_SERVER_HOST_IP      | IP address of the VM                                | 192.168.1.107     |

**.env**: Used to override values from `default.env` if needed (see `template.env`).

| Variable                   | Description                                         | Example           |
|----------------------------|-----------------------------------------------------|-------------------|
| VSCODE_SERVER_PASSWORD     | Hashed password for code-server                     | $argon2id$...     |

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch the code-server container and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:8086` (or your reverse proxy domain)
- **Default port:** `8086`

### Environment files

**networking.env**
| Variable               | Description                                 | Example         |
|------------------------|---------------------------------------------|-----------------|
| VSCODE_SERVER_HOST_IP  | IP of the machine that hosts this stack     | 192.168.1.107   |
| VSCODE_SERVER_DOMAIN   | Custom subdomain (root domain should match) | code.l.ab       |

**.env**
| Variable                | Description                                 | Example         |
|------------------------|---------------------------------------------|-----------------|
| VSCODE_SERVER_PASSWORD | Hashed password for code-server (see instructions above) | $argon2id$...   |

You may override any other environment variable as needed in either file.

## Details

### Services and ports

- code-server - `8086`

### Use cases

- Remote development
- Secure codebase access

### Documentation

- [code-server Main Site](https://github.com/coder/code-server)
- [code-server Docs](https://coder.com/docs/code-server/latest)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
