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
- `src/`: Docker Compose file and configuration templates for media-server.
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

| Variable              | Description                                      | Example           |
|-----------------------|--------------------------------------------------|-------------------|
| MEDIA_SERVER_HOST_IP  | IP of the machine that hosts this stack          | 192.168.1.103     |

**.env**: Used to override values from `default.env` if needed (see `template.env`).

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

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch Plex and Overseerr containers and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** `http://127.0.0.1:32400` (Plex) and `http://127.0.0.1:5055` (Overseerr), or via your reverse proxy domain.
- **Default ports:** Plex - `32400`, Overseerr - `5055`

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
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
