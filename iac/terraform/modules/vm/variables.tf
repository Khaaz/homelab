## Proxmox
variable "proxmox_node" {
  type        = string
  description = "Proxmox node name where the VM will be created"
}

variable "proxmox_datastore_id" {
  type        = string
  description = "Proxmox datastore ID for VM storage"
}

variable "proxmox_vm_template_id" {
  type        = number
  description = "Proxmox VM template ID to use for VM creation"
}

## VM
variable "vm_name" {
  type        = string
  description = "Name of the VM to be created"
}

# Per-VM config parsed from YAML
variable "vm_cfg" {
  type = object({
    specs = object({
      cores       = number
      memory_size = number
      disk_size   = number 
    })
    config = object({
      docker = bool
      router = bool
      routes = optional(list(object({
        network = string                # Target network (ip/mask)
        via     = string                # Gateway to access this network (ip)
      })))
    })
    order       = number
    dns_servers = optional(list(string), ["1.1.1.1", "8.8.8.8"])
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
  })
  description = "Per-VM configuration parsed from YAML, containing VM-specific settings like CPU, memory, disk, and network configuration"
}

variable "vm_id" {
  type        = number
  description = "Deterministic Proxmox VMID to assign"
}

## cloud-init user-data
variable "admin_pubkey" {
  type        = string
  description = "SSH public key for admin user access to the VM"
}

variable "automation_pubkey" {
  type        = string
  description = "SSH public key for automation user access to the VM"
}

## cloud-init vendor-data
variable "nft_rules_config" {
  type        = string
  default     = null
  description = "Nftable config as text, from /infra/nftable.conf (optional)"
}
## cloud-init vendor-data
variable "init_script" {
  type        = string
  default     = null
  description = "Additional init script.sh, from /infra/init.sh file (optional)"
}
