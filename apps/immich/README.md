
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
- `src/`: Docker Compose file and configuration templates for Immich.
  - `docker-compose.yaml`
  - `config/`: Stores environment files and configuration templates.
- `compose.sh`: main script to start the stack

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

**networking.env**: Used to configure network settings for the stack (see `networking.env.template`).

| Variable        | Description                                 | Example         |
|-----------------|---------------------------------------------|-----------------|
| IMMICH_HOST_IP  | IP of the machine that hosts this stack     | 192.168.1.101   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable     | Description                                 | Example           |
|--------------|---------------------------------------------|-------------------|
| DB_PASSWORD  | PostgreSQL database password                 | longpassword123   |

You may override any other environment variable as needed in either file.

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch the Immich container and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:2283` (or `https://immich.l.ab` with reverse proxy setup)
- **Default port:** `2283`

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
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
