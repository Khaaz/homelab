# vaultwarden

## Context

Self-hosted password manager compatible with the Bitwarden clients.

### Services

- Vaultwarden – main password manager

## Architecture

A single Vaultwarden container runs on its own dedicated Docker network.

## Setup

### Initial setup

1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   specify the host IP and domain.
2. Copy `src/config/.env.template` to `src/config/.env` and add the encrypted
   admin token.

### Environment files

- `.env`
  - `VAULTWARDEN_ADMIN_TOKEN` – hashed admin token generated with
    `./src/scripts/utils/encrypt-argon <password>` (replace `$` with `$$` when
    copying)
- `networking.env`
  - `VAULTWARDEN_HOST_IP` – IP address of the VM
  - `VAULTWARDEN_DOMAIN` – subdomain used for the password manager

### Running

Start the stack with `./compose.sh up -d`.

### _setup directory

Configuration templates inside `_setup` are applied automatically during the
first run.

## Details

### Services and ports

- Vaultwarden – `8087`

### Documentation

- <https://github.com/dani-garcia/vaultwarden>
- <https://github.com/dani-garcia/vaultwarden/wiki>
