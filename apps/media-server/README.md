# media-server

## Context

Media streaming stack running Plex with Overseerr for managing user requests.

### Services

- Plex – media server
- Overseerr – request management

## Architecture

`plex` and `overseerr` containers run on a dedicated Docker network.

## Setup

### Initial setup

1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set the host IP and domain used to expose Plex.
2. Copy `src/config/.env.template` to `src/config/.env` and provide the Plex
   claim token and Overseerr API keys.

### Environment files

- `.env`
  - `PLEX_CLAIM` – claim token from <https://plex.tv/claim>
  - `PLEX_MACHINE_IDENTIFIER` – server identifier from Plex `Preferences.xml`
  - `PLEX_USERNAME` – Plex account username
  - `PLEX_EMAIL` – Plex account email
  - `PLEX_FRIENDLY_NAME` – name displayed for the server
  - `API_KEY_OVERSEERR` – key used by Overseerr to access Plex
  - `WEBHOOK_OVERSEERR_DISCORD` – optional Discord webhook for Overseerr
  - `API_KEY_RADARR4K` – shared with the media-management stack
  - `API_KEY_RADARR` – shared with the media-management stack
  - `API_KEY_SONARR` – shared with the media-management stack
  - `API_KEY_SONARR4K` – shared with the media-management stack
- `networking.env`
  - `MEDIA_SERVER_HOST_IP` – IP address of the VM
  - `MEDIA_SERVER_DOMAIN` – internal domain name

### Running

Start the stack with `./compose.sh up -d`.

### _setup directory

Configuration templates within each service's `_setup` folder are copied on
first start.

## Details

### Services and ports

- Plex – `32400`
- Overseerr – `5055`

### Documentation

- <https://github.com/plexinc/pms-docker>
- <https://github.com/sct/overseerr>
- <https://support.plex.tv/articles/> 
- <https://docs.overseerr.dev/>
