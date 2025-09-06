variable "proxmox_api_url" {
  type = string
}

variable "proxmox_terraform_api_token" {
  type = string
}

variable "proxmox_node" {
  type    = string
  default = "home"
}

variable "proxmox_datastore_id" {
  type    = string
  default = "local"
}

variable "proxmox_vm_template_name" {
  type    = string
  default = "vm-alpine-template"
}

variable "proxmox_vm_template_id" {
  type    = number
  default = 9000
}
