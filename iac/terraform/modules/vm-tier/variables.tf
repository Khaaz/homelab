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

variable "tier_vms" {
  type = map(object({
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
    # tier 0 is GW
    # tier 1 is DNS and routing
    # tier 2 is management and other mandatory VMs
    # tier 3 is all the "app" VM
    order_tier  = number
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
  }))
  description = "Map of VMs config (vm name => vm config) for this tier"
}

variable "vms_to_vmid" {
  type        = map(number)
  description = "Map of VMs id (vm name => vm id)"
}
