variable "proxmox_api_url" {
  type    = string
  default = "https://YOUR_PROXMOX_IP:8006/api2/json"
}

variable "proxmox_user" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type      = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "template_name" {
  type    = string
  default = "debian-template"
}