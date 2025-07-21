# immich

## Context

Self-hosted photo and video backup solution built around the Immich project.

### Services
- Immich server – main application
- Machine learning module – used for face and object detection
- PostgreSQL – metadata database
- Redis – job queue

## Architecture

The stack runs `immich-server`, a machine-learning module, `redis` and
`postgres` containers on a dedicated Docker network.

## Setup

### Initial setup
1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   fill the host IP and domain values.
2. Copy `src/config/.env.template` to `src/config/.env` and provide the database
   password in `DB_PASSWORD`.

### Environment files
- `.env`
  - `DB_PASSWORD` – password for the PostgreSQL database. Generate one with
    `openssl rand -base64 32`.
- `networking.env`
  - `IMMICH_HOST_IP` – IP address of the Immich VM
  - `IMMICH_DOMAIN` – subdomain served by the reverse proxy

### Running
Start the stack with `./compose.sh up -d`.

### _setup directory
Templates and SQL seeds located in each service's `_setup` folder are applied on
first start.

## Details

### Services and ports
- Immich server – `2283`
- Machine learning module – internal only
- PostgreSQL – internal only
- Redis – internal only

### Documentation
- <https://github.com/immich-app/immich>
