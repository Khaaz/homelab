# NAS VM

Simple NAS VM with NFS server and disk passthrough support.

## Configuration

The NAS VM is configured with:
- **Alpine Linux** base
- **NFS server** for network file sharing
- **Disk passthrough** for direct access to a physical disk
- **Network**: srv network (10.10.32.30/24)

## Setup

### 1. Configure Disk Passthrough

Before deploying, update the disk ID in `infra/proxmox.yml`:

```bash
# On Proxmox host, find your disk ID:
ls -la /dev/disk/by-id/

# Update proxmox.yml with the actual disk ID:
additional_disks:
  - device: "/dev/disk/by-id/ata-YOUR_DISK_ID_HERE"
```

### 2. Deploy the NAS VM

```bash
cd iac/terraform
terraform apply
```

The init script will automatically:
- Install NFS server
- Format and mount the passthrough disk at `/data`
- Configure NFS exports for the srv network
- Ensure NFS server starts on boot

## NFS Export

The NAS exports `/data` to the entire srv network (10.10.32.0/24) with:
- **Read/Write** access
- **No root squash** (root on client has root access to share)
- **Sync** writes

## Using NAS from Other VMs

To mount the NAS share from another VM, add the `nas` configuration to that VM's `proxmox.yml`:

```yaml
# Example: apps/cloud/infra/proxmox.yml
specs:
  cores: 2
  ram_size: 4096
  disk_size: 20
  additional_disks: []
order_tier: 3
config:
  docker: true
  router: false
  routes:
    - network: 10.10.31.0/24
      via: 10.10.32.2
  dns_servers: [1.1.1.1, 8.8.8.8]
nics:
  - bridge: vmbr3
    vlan: 32
    ipv4: 10.10.32.12/24
    gateway: 10.10.32.1
# Mount NAS share
nas:
  ip: "10.10.32.30"             # NAS VM IP
  mount_path: "/mnt/nas"        # Local mount point
  nfs_export: "/data"           # NFS export path
```

The vendor-data cloud-init will automatically:
- Install NFS client utilities
- Create the mount point
- Add fstab entry for persistence
- Mount the NFS share

## Future Enhancements

### Multiple Exports

You can configure multiple NFS exports for different purposes:

1. Update `/etc/exports` in the NAS init script:
```bash
/data/medias  10.10.31.0/24(rw,sync,no_subtree_check) 10.10.32.0/24(rw,sync,no_subtree_check)
/data/cloud   10.10.31.0/24(rw,sync,no_subtree_check) 10.10.32.0/24(rw,sync,no_subtree_check)
```

2. Mount different exports in different VMs:
```yaml
# Media server
nas:
  ip: "10.10.32.30"
  mount_path: "/mnt/medias"
  nfs_export: "/data/medias"

# Cloud storage
nas:
  ip: "10.10.32.30"
  mount_path: "/mnt/cloud"
  nfs_export: "/data/cloud"
```

## Troubleshooting

### Check NFS Server Status
```bash
ssh admin@10.10.32.30
rc-service nfs status
exportfs -v
```

### Check Mount on Client
```bash
mount | grep nfs
df -h | grep nfs
```

### Manual Mount
```bash
mount -t nfs 10.10.32.30:/data /mnt/nas
```

## detect disk for passthrough / detect pci passthrough

... lsblk
/dev/disk/by-id => uinque hardware coded

lspci -nn | grep -i "SATA"
lspci -nn | grep -i "VGA.*Intel"

## windows setup
Enable network storage on windows:
- windows + R
- `gpedit.msc`
- Computer Configuration / configuration ordinateur
- -> Administrative Templates / modèle d'administration
- ->-> Network / Réseau
- ->->-> Lanman Workstation / Station de travail LANMAN
- ->->->-> Enable insecure guest logons / Activer les ouvertures de session invité non sécurisé
- `gpupdate /force`

- in cmd: `net use Z: \\192.168.1.200\media`
- in cmd: `net use Z: \\192.168.1.200\media /persistent:yes`

## macbook

in /etc/fstab
`192.168.1.200:/share /Volumes/share nfs rw,bg,vers=4,intr,noresvport 0 0`

cmd + k: connecto to server
`nfs://192.168.1.200/share`
