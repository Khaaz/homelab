# vpn

## Context

Placeholder for a VPN solution (WireGuard or OpenVPN) to securely access the
home network remotely.

### Services
- VPN server (implementation pending)

## Architecture

Configuration and Docker files will be added here in the future. The stack will
expose a VPN server allowing remote clients to join the internal network.

## Setup

### Initial setup
1. Prepare the VPN configuration and compose files.
2. Copy `src/config/networking.template.env` to `src/config/networking.env` and
   set the appropriate ports and server address.

### Environment files
- `networking.env` – network information for the future VPN container

### Running
Start the stack with `./compose.sh up -d` when available.

### _setup directory
To be added when the VPN implementation is finalised.

## Details

### Services and ports
- VPN server – *(pending)*

### Documentation
*(add references here)*
