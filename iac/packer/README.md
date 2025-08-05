Make sure you have:

A public key at ~/.ssh/id_rsa.pub

Your Proxmox API password (or token)

Then run:

```bash
export PACKER_VAR_proxmox_password='your-root-password'

cd packer
packer init .
packer build debian-template.pkr.hcl
```