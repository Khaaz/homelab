# home-automation

## Context

Central hub for all home automation tasks using Home Assistant.

### Services

- Home Assistant – orchestrates automations

## Architecture

The stack runs a single Home Assistant container on its own dedicated Docker
network.

## Setup

### Initial setup

1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set `HOME_AUTOMATION_HOST_IP` and `HOME_AUTOMATION_DOMAIN`.
2. Copy `src/config/.env.template` to `src/config/.env` and adjust any desired
   options.

### Environment files

- `.env` – no secrets are required. Override values from `default.env` if
  needed.
- `networking.env`
  - `HOME_AUTOMATION_HOST_IP` – IP address of the VM
  - `HOME_AUTOMATION_DOMAIN` – subdomain served by the reverse proxy

### Running

Start the stack with `./compose.sh up -d`.

### _setup directory

Configuration templates stored in `_setup` are applied the first time the
container is started.

## Details

### Services and ports

- Home Assistant – `8123`

### Documentation

- <https://www.home-assistant.io/>
- <https://www.home-assistant.io/docs/>
