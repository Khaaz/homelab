# media-management

## Context

### Overview

Automates downloads and organizes the media library. This stack combines qBittorrent for torrenting, Prowlarr for indexer management, Radarr and Sonarr for movies and series, plus supporting services like Bazarr, FlareSolverr, Homarr, Maintainerr, Gluetun (VPN), and Portainer.

### Services

- **qBittorrent**: Handles downloads
- **Prowlarr**: Manages indexers
- **Radarr/Radarr4K**: Movie organization
- **Sonarr/Sonarr4K**: Series organization
- **Bazarr**: Subtitle management
- **FlareSolverr**: Bypasses Cloudflare checks
- **Homarr**: Dashboard for quick links
- **Maintainerr**: Health overview
- **Gluetun**: Optional VPN tunnel
- **Portainer**: Container management UI

## Architecture

### Schema

(To be added)

### Features

- Multi-container deployment: All services run in dedicated containers on an isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- VPN support: Gluetun provides optional VPN connectivity for privacy.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `bazarr/`, `gluetun/`, `homarr/`, `maintainerr/`, `prowlarr/`, `qbittorrent/`, `radarr/`, `radarr4k/`, `sabnzbd/`, `sonarr/`, `sonarr4k/`, `tdarr/`, `unpackerr/`, etc.
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

| Variable                  | Description                                 | Example         |
|---------------------------|---------------------------------------------|-----------------|
| MEDIA_MANAGEMENT_HOST_IP  | IP of the machine that hosts this stack     | 192.168.1.102   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable                  | Description                                 | Example            |
|---------------------------|---------------------------------------------|--------------------|
| INTERNAL_DOMAIN           | Internal domain                             | l.ab               |
| VPN_SERVICE_PROVIDER      | VPN provider name (e.g., nordvpn, protonvpn)| protonvpn          |
| VPN_USERNAME              | VPN account username                        | user               |
| VPN_PASSWORD              | VPN account password                        | pass               |
| API_KEY_PROWLARR          | API key for Prowlarr                        | randomstring       |
| API_KEY_BAZARR            | API key for Bazarr                          | randomstring       |
| API_KEY_RADARR            | API key for Radarr                          | randomstring       |
| API_KEY_RADARR4K          | API key for Radarr4K                        | randomstring       |
| API_KEY_SONARR            | API key for Sonarr                          | randomstring       |
| API_KEY_SONARR4K          | API key for Sonarr4K                        | randomstring       |
| API_KEY_MAINTAINERR       | API key for Maintainerr                     | randomstring       |
| API_KEY_OVERSEERR         | API key for Overseerr                       | randomstring       |
| PLEX_CLAIM                | Plex claim token (https://plex.tv/claim)    | claim-xxxx         |
| PLEX_FRIENDLY_NAME        | Name of the Plex server (default: media-server) | media-server       |
| OPENSUBTITLE_USERNAME     | OpenSubtitles username (optional)            | user               |
| OPENSUBTITLE_PASSWORD     | OpenSubtitles password (optional)            | pass               |

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

- **URL:** Service URLs depend on your reverse proxy and port configuration.

## Details

### Services and ports

- qBittorrent - `8080`
- Prowlarr - `9696`
- Radarr - `7878`
- Radarr4k - `7879`
- Sonarr - `8989`
- Sonarr4k - `8988`
- Bazarr - `6767`
- Homarr - `7575`
- Maintainerr - `8081`
- Gluetun - internal only

### Use cases

- Automated downloads and organization of media
- Subtitle management
- Health monitoring
- VPN privacy for downloads

### Documentation

- [qBittorrent](https://www.qbittorrent.org/)
- [Prowlarr](https://wiki.servarr.com/prowlarr)
- [Radarr](https://wiki.servarr.com/radarr)
- [Sonarr](https://wiki.servarr.com/sonarr)
- [Bazarr](https://wiki.servarr.com/bazarr)
- [Bazarr](https://www.bazarr.media/)
- [Homarr](https://github.com/ajnart/homarr)
- [Maintainerr](https://github.com/jorenn92/maintainerr)
- [Qbittorrent](https://www.qbittorrent.org/)
- [Flaresolverr](https://github.com/FlareSolverr/FlareSolverr)
- [Gluetun](https://github.com/qdm12/gluetun)
- <https://trash-guides.info>
- <https://MediaStack.Guide>

### Additional links

- <https://fmhy.net/downloadpiracyguide>
- torrent:
  - <https://fmhy.net/videopiracyguide#torrent-sites>
- usenet:
  - <https://fmhy.net/downloadpiracyguide#usenet>
  - <https://docs.google.com/document/d/1TwUrRj982WlWUhrxvMadq6gdH0mPW0CGtHsTOFWprCo/mobilebasic>

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `config/`
- For network issues, verify your reverse proxy and DNS settings
- For Proxmox deployment issues, check the `infra/proxmox.yml` configuration

Each service provides templates and SQL files in its `_setup` folder which are
applied on first launch.
