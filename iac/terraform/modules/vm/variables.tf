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

# Per-VM config parsed from YAML. Keep flexible.
variable "vm_cfg" {
  type        = any
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
  description = "NFT config as text, from vm file"
}
