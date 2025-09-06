## Proxmox
variable "proxmox_node" {
  type = string
}

variable "proxmox_datastore_id" {
  type = string
}

variable "proxmox_vm_template_id" {
  type = number
}

## VM
variable "vm_name" {
  type = string
}

# Per-VM config parsed from YAML. Keep flexible.
variable "vm_cfg" {
  type = any
}

## SSH
variable "admin_pubkey" {
  type = string
}

variable "automation_pubkey" {
  type = string
}
