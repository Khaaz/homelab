# homelab

My personal Homelab setup.

## Contexte

Homelab that runs Plex, Servarr, Home Assistant and other things, on a NAS/server in my home.  

The setup is made to be entirely automated and customisable. Feel free to use anything from this repo if it helps you. It should be relatively easy for anyone to run a similar setup, by just tweaking the configuration / environment files.  

Built with automation, ease of customisation and a particular focus on security in mind.  
Some services are open to a few poeple of trust (eg: Plex, Overser...) from outside the network.  

### Hardware

- Motherboard: MSI PRO B760M-P
- CPU: Intel i5-14400
- RAM: Crucial pro ram DDR4 16GO (*2)
- SSD: Lexar NM620 SSD 256Go Interne, M.2 2280 PCIe Gen3x4 NVMe
- CPU fan: Be quiet! Pure Rock Slim 2
- PSU: Cooler Master MWE 550 Bronze
- HDD:

### Software

- media-server: Media server (Plex)
- media-management: Media download / management (Starr / Servarr stack)
- reverse-proxy: Entry point / DNS
- vpn: VPN to access home network from anywhere
- home-assistant: Home Assistant
- nextcloud: Cloud
- vaultwarden: Selfhosted Bitwarden
- vscode-server: Vscode server

## Architecture

### Nas server

![proxmox](./assets/proxmox.png)

### Network

![network](./assets/network.png)

## Setup

- debian preseed
- proxmox
- ansible / vagrant for automation
