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
  - Seagate Ironwolf red 8TB

### Software

- ~ | [cloud](apps/cloud/README.md): Cloud (nextcloud)
- X | [home-automation](apps/home-automation/README.md): Home assistant and other home automation
- ~ | [immich](apps/immich/README.md): Photo cloud and gallery
- V | [media-server](apps/media-server/README.md): Media server (Plex and Overseerr)
- V | [media-management](apps/media-management/README.md): Media download and mana| gement (Starr / Servarr stack)
- V | [reverse-proxy](apps/reverse-proxy/README.md): Entry point, domain, routing and DNS
- ~ | [vault](apps/vault/README.md): Selfhosted password manager (vaultwarden (Bitwarden))
- X | [vpn](apps/vpn/README.md): VPN to access home network from anywhere
- ~ | [vscode-server](apps/vscode-server/README.md): Vscode server

## Architecture

### Server layout

The server runs Debian with **Proxmox** handling virtualization. Each
application stack sits in its own virtual machine so services remain
isolated from one another. The reverse proxy VM acts as the single entry
point for all external traffic and forwards requests to the other VMs.

![proxmox](./assets/proxmox.png)

The following VMs are planned:

- `cloud` – file storage
- `home-automation` – Home Assistant
- `immich` – photo management
- `media-management` – download automation tools
- `media-server` – Plex and Overseerr
- `reverse-proxy` – ingress, DNS and certificates
- `vault` – password manager
- `vscode-server` – remote development
- `vpn` – remote access gateway

Additional machines can easily be added using the Ansible playbooks.

### Network

![network](./assets/network.png)

### Repository structure

- `apps/` – Docker Compose projects for each app stack
- `iac/` – Infra as Code (ansible, terraform) for automatic deployment
- `preseed/` – Unattended / automatic Debian installer files
- `src/` – Scripts and utils for the repo
- `config/` – Shared and global configuration (global config and SSH keys)
- `assets/` – Diagrams and images

## Setup

### Prerequisites

- A server capable of running **Proxmox** or an existing Debian installation.
- Ansible installed on the machine used to run the playbooks.
- Git and SSH access to clone this repository.
- (Optional) The Debian netinst ISO if you plan on using the preseed installer.

### Hardware build

Assemble the hardware listed above or adapt the parts to your own
requirements.

### System install

1. **Install Debian** – build the automated installer in `preseed/` and boot
   from it. Skip this step if the machine already runs Debian or Proxmox and go
   directly to step 2 or 3.
2. **Provision the host** – run the playbooks in `src/ansible` to install and
   configure Proxmox on Debian. If Proxmox is already installed, move to the next
   step.
3. **Create the virtual machines** – one VM per application. The playbooks can
   create them automatically, but you may also create them manually if you
   prefer.
4. **Clone this repository** on the management VM or directly on the Proxmox
   host.

### Software install

1. For each application under `apps/`, copy
   `src/config/networking.template.env` to `src/config/networking.env` within the
   application's folder and set the VM IP address and subdomain.
2. Copy `.env.template` to `.env` in the same folder and fill in the required
   secrets (API keys, tokens and so on).
3. Bring the stack online with `./compose.sh up -d`. Use `down` to stop it when
   needed.

### Automation

Helper scripts will deploy and manage the VMs directly from Proxmox,
keeping code and environment files up to date. They are located under
`src/app-bootstrap` and will evolve alongside the infrastructure.

### Notes

TODO mvp:

- terraform + provision VMs
- setup VM + loading repo + conf
- setup on server
- handle "data" path
- handle plex hardware passthrough
- root README
- architecture schemas

TODO:

- finalise (setup + fixes + automation) cloud, immich, vault, vscode-server
- media-management/homarr
- global dashboard (root domain)
- whiteboard
- notes / todolist?
- vpn (in)
- truenas
- rebound/backup/master server (raspi?)
- setup HA
- pi hole / DNS filtering

Other tools todo:

- media-sharing: selfhostable transfer file: https://github.com/robinkarlberg/transfer.zip-web
- link sharing
- url shortener
- shopping list
- recipes?

Links:

- dashboard: https://trymotherboard.com/?utm_source=tldrfounders



Notes:
open a port (tcp): nc -lnvp <port>
request (syn) (tcp): nc -nvz <ip> <port>
