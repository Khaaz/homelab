# reverse-proxy

## Context

### Overview

Entry point for the homelab. Provides the public reverse proxy using SWAG (nginx) with Authelia for authentication, plus DNS and certificate utilities. This stack secures and routes external traffic to internal services, manages authentication, and provides DNS and certificate management for the homelab.

### Services

- **SWAG**: Nginx reverse proxy
- **Authelia**: Authentication gateway
- **Unbound**: Local DNS resolver
- **DDNS updater**: Updates public DNS records
- **Minica**: Generates internal certificates

## Architecture

### Schema

(To be added)

### Features

- Multi-container deployment: All services run in dedicated containers on an isolated Docker network for security and reliability.
- Configuration templates: Initial configuration is applied from the `_setup` directory on first start.
- Reverse proxy integration: Designed to work with a reverse proxy for secure external access and custom domains.
- DNS server: Unbound provides recursive lookups and local zones for internal services.
- Certificate authority: Minica generates a small internal CA for trusted SSL certificates.
- Extensible: Add functionality with integrations, add-ons, and custom scripts.

### File structure

- `apps/`: Contains all apps for this stack.
  - `authelia/`, `ca/`, `ddns-updater/`, `swag/`, `unbound/`
- `src/`: Docker Compose file and configuration templates for reverse-proxy.
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

### DNS server

`unbound` provides both recursive lookups and local zones. The domain `${INTERNAL_DOMAIN}` resolves to the reverse proxy itself while `*.srv.${INTERNAL_DOMAIN}` maps each service VM to its designated IP as defined in `networking.env`. To use these records set your computer's DNS server to the reverse proxy address:

- **Windows** – Control Panel → Network → Adapter Settings → set the DNS server
  to the VM IP
- **macOS** – System Settings → Network → DNS
- **Linux** – edit `/etc/resolv.conf` or your network manager configuration

### Reverse proxy

`swag` (an Nginx bundle) routes incoming requests to the correct internal service. `authelia` enforces authentication using individual user accounts and protects selected services.

### Certificate authority

`minica` generates a small internal certificate authority available at `https://<INTERNAL_DOMAIN>/ca`. Import the root certificate on each device so that the internal services are trusted:

- **Windows** – open the URL, save the `.crt` file then double click it to add it to the "Trusted Root Certification Authorities" store
- **macOS** – download the certificate and add it to Keychain Access under "System"
- **Linux** – copy the certificate to `/usr/local/share/ca-certificates/` and run `sudo update-ca-certificates`
- **Android** – download the certificate and install it via *Settings → Security → Encryption & credentials → Install a certificate*
- **iOS** – download the certificate, open it and follow the prompts in *Settings*

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

| Variable               | Description                                 | Example         |
|------------------------|---------------------------------------------|-----------------|
| REVERSE_PROXY_HOST_IP  | IP of the machine that hosts this stack     | 192.168.1.105   |

**.env**: Used to override values from `.env.default` if needed (see `.env.template`).

| Variable                  | Description                                                      | Example                |
|--------------------------|-------------------------------------------------------------------|------------------------|
| INTERNAL_DOMAIN          | Internal domain for DNS and certificates                          | l.ab                   |
| EXTERNAL_DOMAIN          | External domain for public access                                 | example.com            |
| ROOT_COMMON_NAME         | Common name for root certificate (minica)                         | Homelab                |
| DNSPLUGIN                | DNS provider for SWAG                                             | cloudflare             |
| AUTHELIA_JWT_SECRET      | Secret key for Authelia JWT                                       | a_very_important_secret|
| AUTHELIA_ENCRYPTION_KEY  | Encryption key for Authelia DB (min 20 chars)                     | randomstring           |
| AUTHELIA_USER_NAME       | Authelia admin username                                           | admin                  |
| AUTHELIA_USER_EMAIL      | Authelia admin email                                              | admin@gmail.com        |
| AUTHELIA_USER_PASSWORD   | Authelia admin password hash (see instructions in template)       | $argon2id$...          |

You may override any other environment variable as needed in either file.

### Running service

Start the stack with:

```bash
./compose.sh up -d
```

This will launch all containers and apply configuration templates from `_setup` on first start.

### Accessing service

- **URL:** Depends on your domain and service configuration. See your reverse proxy and DNS settings.
- **Root certificate:** `https://l.ab/ca`

## Details

### Services and ports

- SWAG (Nginx) - `443`/`80`
- Unbound - `53`
- Authelia - internal only
- DDNS updater - internal only
- Minica - internal only

### Domains

- `authelia.l.ab`, `auth.l.ab` – Authelia portal
- `ddns-updater.l.ab` – dynamic DNS status
- `ha.l.ab` – Home Assistant
- `photos.l.ab`, `immich.l.ab` – Immich
- `cloud.l.ab`, `nextcloud.l.ab` – Nextcloud
- `plex.l.ab` – Plex
- `plex.<DOMAIN>` – Plex external
- `request.l.ab`, `overseerr.l.ab` – Overseerr
- `request.<DOMAIN>`, `overseer.<DOMAIN>` – Overseerr external
- `qbit.l.ab`, `qbittorrent.l.ab` – qBittorrent
- `prowlarr.l.ab` – Prowlarr
- `radarr.l.ab` – Radarr
- `radarr4k.l.ab` – Radarr4K
- `sonarr.l.ab` – Sonarr
- `sonarr4k.l.ab` – Sonarr4K
- `bazarr.l.ab` – Bazarr
- `homarr.l.ab` – Homarr dashboard
- `maintainerr.l.ab` – Maintainerr health check
- `vault.l.ab`, `vaultwarden.l.ab` – Vaultwarden
- `code.l.ab` – VS Code server

### Certificate

- For certificate, import the root certificate on each device:
  - **Windows**: Save `.crt` file and add to Trusted Root Certification Authorities
  - **macOS**: Add to Keychain Access under System
  - **Linux**: Copy to `/usr/local/share/ca-certificates/` and run `sudo update-ca-certificates`
  - **Android**: Install via Settings > Security > Encryption & credentials > Install a certificate
  - **iOS**: Open and follow prompts in Settings

### Use cases

- Secure external access to internal services
- Centralized authentication
- Internal DNS and certificate management

### Documentation

- [SWAG Documentation](https://docs.linuxserver.io/images/docker-swag)
- [Authelia Documentation](https://www.authelia.com/docs/)
- [Unbound Documentation](https://nlnetlabs.nl/projects/unbound/)
- [ddns-updater](https://github.com/qdm12/ddns-updater#readme)
- [minica](https://github.com/jsha/minica)
- https://en.wikipedia.org/wiki/Comparison_of_DNS_server_software

### Troubleshooting

- Check container logs with `docker logs <container_name>`
- Review configuration files in `src/config/`
- For network issues, verify your reverse proxy and DNS settings
