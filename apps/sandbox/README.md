# template

## Context

### Overview

Central hub for all home automation tasks using Home Assistant. This stack enables orchestration of smart devices, automations, and integrations, providing a unified dashboard and control system for your home.

### Services

- **Home Assistant**:
  - Orchestrates automations, device integrations, and provides the main dashboard.
  - Connects smart devices (lights, sensors, switches, etc.)
  - Creates automations and routines
  - Monitors home status and events
  - Integrates with voice assistants (Google Assistant, Alexa) and third-party services

## Architecture

### Schema

(To be added)

### Features

- Single-container deployment: Runs Home Assistant in a dedicated Docker container on its own isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy (see the reverse-proxy stack) for secure external access and custom domains.
- Auto-discovery: Home Assistant will auto-discover supported devices on your network and allow you to set up automations via its web UI.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `home-assistant/`
- `src/`: Docker Compose file and configuration templates for Home Assistant.
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

| Variable                | Description                                 | Example         |
|-------------------------|---------------------------------------------|-----------------|
| HOME_AUTOMATION_HOST_IP | IP of the machine that hosts this stack     | 192.168.1.200   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable     | Description                                 | Example |
|--------------|---------------------------------------------|---------|
| (none)       | No secrets required for this stack           |         |

You may override any other environment variable as needed in either file.

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch the Home Assistant container and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:8123` (or `https://ha.l.ab` with reverse proxy setup)
- **Default port:** `8123`

## Details

### Services and ports

- Home assistant - `8123`

### Use cases

- Centralized control of smart home devices
- Automated routines (e.g., lights on at sunset, notifications for motion detection)
- Energy monitoring and reporting
- Voice assistant integration (Google Assistant, Alexa)

### Documentation

- [Home Assistant Main Site](https://www.home-assistant.io/)
- [Getting Started Guide](https://www.home-assistant.io/getting-started/)
- [Official Documentation](https://www.home-assistant.io/docs/)
- [Community Forums](https://community.home-assistant.io/)

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
