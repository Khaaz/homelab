## Proxmox config
variable "proxmox_api_url" {
  type        = string
  default     = env("PROXMOX_API_URL")
  description = "Proxmox API URL for Packer authentication"
}
variable "proxmox_node" {
  type        = string
  default     = env("PROXMOX_NODE")
  description = "Proxmox node name where VM templates will be created"
}
variable "proxmox_datastore_id" {
  type        = string
  default     = env("PROXMOX_DATASTORE_ID")
  description = "Proxmox datastore ID for VM template storage"
}

## Secret
variable "proxmox_packer_token_id" {
  type        = string
  default     = env("PROXMOX_PACKER_TOKEN_ID")
  description = "Proxmox API token ID for Packer authentication (packer user)"
}
variable "proxmox_packer_token_secret" {
  type        = string
  sensitive   = true
  default     = env("PROXMOX_PACKER_TOKEN_SECRET")
  description = "Proxmox API token secret for Packer authentication"
}

## Configuration
variable "proxmox_vm_template_name" {
  type        = string
  default     = env("PROXMOX_VM_TEMPLATE_NAME")
  description = "Name for the VM template created by Packer"
}
variable "proxmox_vm_template_id" {
  type        = string
  default     = env("PROXMOX_VM_TEMPLATE_ID")
  description = "ID for the VM template created by Packer"
}
variable "proxmox_vm_template_type" {
  type        = string
  default     = env("PROXMOX_VM_TEMPLATE_TYPE")
  description = "Type for the VM template created by Packer (virt, standard)"
}

## Preseed additional config
# Setup machine IP (to fetch answer and root.pub)
variable "control_node_ip" {
  type        = string
  default     = env("CONTROL_NODE_IP")
  description = "IP address of the control node to fetch preseed configuration and SSH keys"
}
# Customise root password
variable "root_password" {
  type        = string
  sensitive   = true
  default     = env("SSH_ROOT_PASSWORD")
  description = "Root password for the VM template during preseed installation"
}
# Customise keyboard layout
variable "keyboard_layout" {
  type        = string
  default     = env("KEYBOARD_LAYOUT")
  description = "Keyboard layout for the VM template during preseed installation"
}

variable "dev_mode" {
  type        = bool
  default     = env("DEV_MODE") == "true"
  description = "When in dev mode, use specific settings"
}
