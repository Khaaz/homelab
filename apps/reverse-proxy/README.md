# reverse-proxy

## Context

Entry point for the homelab. Provides the public reverse proxy using SWAG
(nginx) with Authelia for authentication plus DNS and certificate utilities.

### Services
- SWAG – Nginx reverse proxy
- Authelia – authentication gateway
- Unbound – local DNS resolver
- DDNS updater – updates public DNS records
- Minica – generates internal certificates


## Architecture

Containers include `swag`, `authelia`, `unbound`, `ddns-updater` and `minica`.
All run on a dedicated `reverse-proxy` Docker network.

### DNS server
`unbound` provides both recursive lookups and local zones. The domain
`${INTERNAL_DOMAIN}` resolves to the reverse proxy itself while
`*.intra.${INTERNAL_DOMAIN}` maps each service VM to its designated IP as defined
in `networking.env`. To use these records set your computer's DNS server to the
reverse proxy address:

- **Windows** – Control Panel → Network → Adapter Settings → set the DNS server
  to the VM IP
- **macOS** – System Settings → Network → DNS
- **Linux** – edit `/etc/resolv.conf` or your network manager configuration

### Reverse proxy
`swag` (an Nginx bundle) routes incoming requests to the correct internal
service. `authelia` enforces authentication using individual user accounts and
protects selected services.

### Certificate authority
`minica` generates a small internal certificate authority available at
`https://<INTERNAL_DOMAIN>/ca`. Import the root certificate on each device so
that the internal services are trusted:

- **Windows** – open the URL, save the `.crt` file then double click it to add
  it to the "Trusted Root Certification Authorities" store
- **macOS** – download the certificate and add it to Keychain Access under
  "System"
- **Linux** – copy the certificate to `/usr/local/share/ca-certificates/` and run
  `sudo update-ca-certificates`
- **Android** – download the certificate and install it via *Settings → Security
  → Encryption & credentials → Install a certificate*
- **iOS** – download the certificate, open it and follow the prompts in
  *Settings*

## Setup

### Initial setup
1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set the public IP and domain names.
2. Copy `src/config/.env.template` to `src/config/.env` and add the Authelia
   secrets and DNS provider options.

### Environment files
- `.env`
  - `INTERNAL_DOMAIN` – domain used inside the home network
  - `EXTERNAL_DOMAIN` – public domain pointing to the reverse proxy
  - `DNSPLUGIN` – provider name for SWAG DNS validation
  - `ROOT_COMMON_NAME` – common name for the internal certificate authority
  - `AUTHELIA_JWT_SECRET` – secret used by Authelia to sign its JWTs
  - `AUTHELIA_ENCRYPTION_KEY` – encryption key for sensitive values
  - `AUTHELIA_USER_NAME` – admin username for Authelia
  - `AUTHELIA_USER_EMAIL` – admin email for Authelia
  - `AUTHELIA_USER_PASSWORD` – hashed password generated with
    `./src/scripts/utils/encrypt-argon <password>`
- `networking.env`
  - `REVERSE_PROXY_HOST_IP` – IP address reachable by other VMs

### Running
Start the stack with `./compose.sh up -d`.

### _setup directory
Each service has templates in `_setup` used to bootstrap configuration on the
first start.

## Details

### Services and ports
- SWAG – `443`/`80`
- Authelia – `9091`
- Unbound – `53`
- DDNS updater – `8310`
- Minica – internal only

### Domains
- `authelia.<INTERNAL_DOMAIN>` – Authelia portal
- `ddns-updater.<INTERNAL_DOMAIN>` – dynamic DNS status
- `home.<INTERNAL_DOMAIN>` – Home Assistant
- `photos.<IMMICH_DOMAIN>`, `immich.<IMMICH_DOMAIN>` – Immich
- `cloud.<NC_DOMAIN>`, `nextcloud.<NC_DOMAIN>` – Nextcloud
- `plex.<MEDIA_SERVER_DOMAIN>`, `plex.<EXTERNAL_DOMAIN>` – Plex
- `request.<MEDIA_SERVER_DOMAIN>`, `overseerr.<MEDIA_SERVER_DOMAIN>` – Overseerr
- `request.<EXTERNAL_DOMAIN>`, `overseer.<EXTERNAL_DOMAIN>` – Overseerr external
- `qbit.<MM_DOMAIN>`, `qbittorrent.<MM_DOMAIN>` – qBittorrent
- `prowlarr.<MM_DOMAIN>` – Prowlarr
- `radarr.<MM_DOMAIN>` – Radarr
- `radarr4k.<MM_DOMAIN>` – Radarr4K
- `sonarr.<MM_DOMAIN>` – Sonarr
- `sonarr4k.<MM_DOMAIN>` – Sonarr4K
- `bazarr.<MM_DOMAIN>` – Bazarr
- `homarr.<MM_DOMAIN>` – Homarr dashboard
- `maintainerr.<MM_DOMAIN>` – Maintainerr health check
- `vault.<VW_DOMAIN>`, `vaultwarden.<VW_DOMAIN>` – Vaultwarden
- `code.<VSCODE_SERVER_DOMAIN>` – VS Code server

### Documentation
*(add references here)*
