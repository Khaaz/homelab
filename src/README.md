# IaC

## ansible playbook

### Init

- setup proxmox
- create VM or LXC
- create users
- setup firewall
- mount storage, create folders if necessary
- clone repo git
- copy / paste additional config / envs
- start docker compose / apps

should be idempotent, should be runnable many times with same result
should, with everything in this repo, be able to instantly restart / reinstall the server

### Update

- update git repo
- repull local config
- restart docker compose
