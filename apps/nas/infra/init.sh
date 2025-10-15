#!/bin/sh
set -eu

MOUNT_POINT="/data"

apk add --no-cache lsblk nfs-utils samba samba-common-tools >/dev/null 2>&1 || true

## DETERMINE DISK
detect_data_disk() {
	# Determine the root disk to avoid formatting/mounting it
	local root_part root_disk root_base
	root_part=$(awk '$2=="/"{print $1}' /proc/mounts | head -n1 || true)
	root_disk=""
	if [ -n "$root_part" ]; then
		root_base=$(lsblk -no PKNAME "$root_part" 2>/dev/null | head -n1 || true)
		if [ -n "$root_base" ]; then
			root_disk="/dev/$root_base"
		fi
	fi

	# Find a single non-boot whole-disk symlink in /dev/disk/by-id
	local disk_candidates
	disk_candidates=$(for L in /dev/disk/by-id/*; do
		[ -L "$L" ] || continue
		case "$L" in *-part[0-9]) continue ;; esac
		T=$(readlink -f "$L" 2>/dev/null || true)
		[ -b "$T" ] || continue
		[ "$T" = "$root_disk" ] && continue
		echo "$T"
	done | sort -u)

	local num
	num=$(printf "%s\n" "$disk_candidates" | sed '/^$/d' | wc -l | tr -d ' ')
	if [ "$num" != "1" ]; then
		echo "ERROR: expected exactly 1 non-boot disk in /dev/disk/by-id, found: $num" >&2
		printf "%s\n" "$disk_candidates" >&2
		return 1
	fi

	local disk_path
	disk_path=$(printf "%s\n" "$disk_candidates")
	printf "%s" "$disk_path"
}

DISK_PATH=$(detect_data_disk)
echo "Using disk: $DISK_PATH"

## DETERMINE TARGET (partition/disk)
# Prefer first partition if present; otherwise use the whole disk
first_part=$(lsblk -ln -o NAME "$DISK_PATH" 2>/dev/null | sed -n '2p' || true)
if [ -n "$first_part" ] && [ -b "/dev/$first_part" ]; then
	TARGET="/dev/$first_part"
else
	TARGET="$DISK_PATH"
fi
echo "Target: $TARGET"

## FORMAT DISK
# Format if no filesystem present
if ! blkid "$TARGET" >/dev/null 2>&1; then
	echo "Formatting $TARGET as ext4..."
	mkfs.ext4 -F "$TARGET"
fi

## DATA AND MOUNT
# Create data directories for exports
create_export_dir() {
  local dir="$1"
  mkdir -p "$dir"
  chown -R nobody:nogroup "$dir"
  chmod -R 2777 "$dir"
}

# Ensure mount point exists
create_export_dir "$MOUNT_POINT"

# Persist mount using UUID
if ! grep -q -F "$MOUNT_POINT" /etc/fstab; then
	UUID=$(blkid -s UUID -o value "$TARGET" 2>/dev/null || true)
	[ -n "$UUID" ] || { echo "ERROR: could not read UUID for $TARGET"; exit 1; }
	printf 'UUID=%s %s ext4 defaults,nofail 0 2\n' "$UUID" "$MOUNT_POINT" >> /etc/fstab
fi

# Mount
mountpoint -q "$MOUNT_POINT" || mount "$MOUNT_POINT"

create_export_dir "$MOUNT_POINT/media"
create_export_dir "$MOUNT_POINT/cloud"

## CONFIGURE NFS
# Force NFSv4-only server configuration
cat > /etc/nfs.conf <<EOF
[nfsd]
vers2=n
vers3=n
vers4=y
vers4.1=y
vers4.2=y
EOF

# Configure NFSv4 exports with v4 root (fsid=0)
# Allow extern, intern and local networks
cat > /etc/exports <<EOF
# NFSv4 exports for NAS
$MOUNT_POINT 10.10.31.0/24(rw,fsid=0,crossmnt,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534) 10.10.32.0/24(rw,fsid=0,crossmnt,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534) 192.168.1.0/24(rw,fsid=0,crossmnt,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
$MOUNT_POINT/media 10.10.31.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534) 10.10.32.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534) 192.168.1.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
$MOUNT_POINT/cloud 10.10.31.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534) 10.10.32.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
$MOUNT_POINT/share 192.168.1.0/24(rw,sync,no_subtree_check,all_squash,anonuid=65534,anongid=65534)
EOF

## CONFIGURE SAMBA
# Minimal guest-access Samba shares for Windows clients
mkdir -p /etc/samba
cat > /etc/samba/smb.conf <<EOF
[global]
   workgroup = WORKGROUP
   server role = standalone server
   security = user
   map to guest = Bad User
   guest account = nobody
   disable netbios = yes
   smb ports = 445
   server min protocol = SMB2

[media]
   path = /data/share
   browseable = yes
   read only = no
   guest ok = yes
   public = yes
   force user = nobody
   force group = nogroup
   create mask = 0666
   directory mask = 0777

[media]
   path = /data/media
   browseable = yes
   read only = no
   guest ok = yes
   public = yes
   force user = nobody
   force group = nogroup
   create mask = 0666
   directory mask = 0777

[cloud]
   path = /data/cloud
   browseable = yes
   read only = no
   guest ok = yes
   public = yes
   force user = nobody
   force group = nogroup
   create mask = 0666
   directory mask = 0777
EOF

echo "Shares: $MOUNT_POINT/media, $MOUNT_POINT/cloud"
## START NFS SERVICES
# Enable and start rpcbind and rpc.statd (OpenRC nfs requires it)
rc-service rpcbind restart || rc-service rpcbind start || true
rc-service rpc.statd restart || rc-service rpc.statd start || true

# Enable and start NFS server (v4-only)
rc-update add nfs boot || true
rc-service nfs restart || rc-service nfs start || true
exportfs -ra || true

echo "NFS services started"

## START SAMBA SERVICES
rc-update add samba default || true
rc-service samba restart || rc-service samba start || true

echo "SAMBA services started"
