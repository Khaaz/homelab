# vscode-server

## Context

Web-based VS Code instance for managing this repository remotely.

### Services

- code-server – remote VS Code instance

## Architecture

Two containers prepare the environment and run `code-server` on a dedicated
Docker network.

## Setup

### Initial setup

1. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set the host IP and domain.
2. Copy `src/config/.env.template` to `src/config/.env` and set a password in
   `VSCODE_SERVER_PASSWORD`.

### Environment files

- `.env`
  - `VSCODE_SERVER_PASSWORD` – hashed password generated with
    `./src/scripts/utils/encrypt-argon <password>`
- `networking.env`
  - `VSCODE_SERVER_HOST_IP` – IP address of the VM
  - `VSCODE_SERVER_DOMAIN` – subdomain for the code server

### Running

Start the stack with `./compose.sh up -d`.

### _setup directory

Initial configuration files are taken from the `_setup` directory when the
container starts for the first time.

## Details

### Services and ports

- code-server – `8086`

### Documentation

- <https://github.com/coder/code-server>
- <https://coder.com/docs/code-server/latest>
