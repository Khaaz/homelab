# media-management

## Context

Automates downloads and organises the media library. It combines qBittorrent
for torrenting, Prowlarr for indexer management, Radarr and Sonarr for movies
and series, plus supporting services like Bazarr, FlareSolverr and others.

### Services
- qBittorrent – handles downloads
- Prowlarr – manages indexers
- Radarr/Radarr4K – movie organisation
- Sonarr/Sonarr4K – series organisation
- Bazarr – subtitle management
- FlareSolverr – bypasses Cloudflare checks
- Homarr – dashboard for quick links
- Maintainerr – health overview
- Gluetun – optional VPN tunnel
- Portainer – container management UI

## Architecture

Multiple containers share a dedicated Docker network with optional VPN
connectivity via Gluetun.

## Setup

### Initial setup
1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   update host IP, domain and port values as needed.
2. Copy `src/config/.env.template` to `src/config/.env` and fill in VPN
   credentials, API keys and other settings.

### Environment files
- `.env`
  - `VPN_SERVICE_PROVIDER` – provider name recognised by Gluetun
  - `VPN_USERNAME` / `VPN_PASSWORD` – account credentials for the VPN service
  - `API_KEY_PROWLARR` – API key for Prowlarr (any random string)
  - `API_KEY_BAZARR` – API key for Bazarr (any random string)
  - `API_KEY_RADARR` / `API_KEY_RADARR4K` – API keys for the Radarr instances
  - `API_KEY_SONARR` / `API_KEY_SONARR4K` – API keys for the Sonarr instances
  - `API_KEY_MAINTAINERR` – API key for Maintainerr
  - `API_KEY_OVERSEERR` – key used by Overseerr when connecting to this stack
  - `PLEX_CLAIM` – Plex claim token from <https://plex.tv/claim> (optional)
  - `PLEX_FRIENDLY_NAME` – name of the Plex server
  - `OPENSUBTITLE_USERNAME` / `OPENSUBTITLE_PASSWORD` – credentials from
    <https://www.opensubtitles.com/> (optional)
- `networking.env`
  - `MEDIA_MANAGEMENT_HOST_IP` – IP address of the VM
  - `MEDIA_MANAGEMENT_DOMAIN` – subdomain routed to this stack
  - port variables allow overriding each service port if required

### Running
Start the stack with `./compose.sh up -d`.

### _setup directory
Each service provides templates and SQL files in its `_setup` folder which are
applied on first launch.

## Details

### Services and ports
- qBittorrent – `8200` (web UI), `6881` (service)
- Prowlarr – `9696`
- Radarr – `7878`
- Radarr4K – `7879`
- Sonarr – `8989`
- Sonarr4K – `8988`
- Bazarr – `6767`
- FlareSolverr – `8191`
- Homarr – `7575`
- Maintainerr – `6246`
- Gluetun – `8320`
- Portainer – `9000`

### Documentation
- <https://trash-guides.info>
- <https://MediaStack.Guide>
