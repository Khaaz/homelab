variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL for Terraform provider authentication"
}

variable "proxmox_terraform_api_token" {
  type        = string
  description = "Proxmox API token for Terraform provider authentication (terraform user)"
}

variable "proxmox_node" {
  type        = string
  default     = "home"
  description = "Proxmox node name where VMs will be created"
}

variable "proxmox_datastore_id" {
  type        = string
  default     = "local"
  description = "Proxmox datastore ID for VM storage"
}

variable "proxmox_vm_template_virt_id" {
  type        = number
  default     = 9000
  description = "ID of the Proxmox VM template to use for VM creation (virt)"
}

variable "proxmox_vm_template_standard_id" {
  type        = number
  default     = 9001
  description = "ID of the Proxmox VM template to use for VM creation (standard)"
}

variable "dev_mode" {
  type        = bool
  default     = false
  description = "When in dev mode, use specific settings"
}
