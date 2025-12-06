## Proxmox
variable "proxmox_node" {
  type        = string
  description = "Proxmox node name where the VM will be created"
}

variable "proxmox_datastore_id" {
  type        = string
  description = "Proxmox datastore ID for VM storage"
}

variable "proxmox_vm_template_virt_id" {
  type        = number
  description = "Proxmox VM template ID to use for VM creation (virt)"
}

variable "proxmox_vm_template_standard_id" {
  type        = number
  description = "Proxmox VM template ID to use for VM creation (standard)"
}

variable "tier_vms" {
  type = map(object({
    kernel = optional(string, "virt") # virt or standard
    specs = object({
      cores     = number
      ram_size  = number
      disk_size = number
      # Additional disks (optional) - supports regular disks and passthrough
      additional_disks = optional(list(object({
        size         = optional(number)        # Size in GB (for regular disks)
        passthrough  = optional(string)        # For passthrough: "/dev/disk/by-id/ata-XXX"
      })))
      # PCI device passthrough (optional) - for SATA controllers, GPUs, etc.
      # Provide either 'id' (direct PCI address, requires root) OR 'mapping' (resource mapping, non-root)
      pci_devices = optional(list(object({
        id      = optional(string)        # Direct PCI address: "0000:00:17.0" (requires root)
        mapping = optional(string)        # Resource mapping: "pci_igpu_mapping" (non-root, recommended)
      })))
    })
    # tier 0 is GW
    # tier 1 is DNS and routing
    # tier 2 is management and other mandatory VMs
    # tier 3 is all the "app" VM
    order_tier  = number
    config = object({
      docker = bool
      router = bool
      routes = optional(list(object({
        network = string                # Target network (ip/mask)
        via     = string                # Gateway to access this network (ip)
      })))
      dns_servers = optional(list(string), ["1.1.1.1", "8.8.8.8"])
    })
    nics = list(object({
      bridge  = string                  # vmbr3
      ipv4    = optional(string)        # "10.10.x.x/24"
      gateway = optional(string)        # default GW for this NIC (if any)

      # For vlan, we can either tag the vlan, or use trunk
      # ipv4 is optional if we use trunk (as ipv4 will be specified inside the trunk)
      vlan   = optional(number)              # VLAN tag:  eg 30 31 32
      trunks = optional(list(object({
        id      = number                        # VLAN tag: eg 30 31 32
        ipv4    = string                        # IP on that VLAN
        gateway = optional(string)              # default GW for this vlan (if any)
      })))
    }))
    # NAS configuration (optional) - for VMs that need NFS mounts
    nas = optional(list(object({
      ip         = string              # IP address of the NAS VM
      mount_path = string              # Local mount point (e.g., "/mnt/nas")
      nfs_export = string              # NFS export path on NAS (e.g., "/data")
    })))
  }))
  description = "Map of VMs config (vm name => vm config) for this tier"
}

variable "vms_to_vmid" {
  type        = map(number)
  description = "Map of VMs id (vm name => vm id)"
}
