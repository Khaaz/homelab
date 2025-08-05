packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "proxmox_url" {
  type    = string
  default = "https://YOUR_PROXMOX_IP:8006/api2/json"
}

variable "proxmox_username" {
  type    = string
  default = "root@pam"
}

variable "proxmox_password" {
  type    = string
  sensitive = true
}

variable "proxmox_node" {
  type    = string
  default = "proxmox"
}

variable "ansible_pubkey_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

source "proxmox-iso" "debian" {
  iso_url        = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.5.0-amd64-netinst.iso"
  node_name      = var.proxmox_node
  username       = var.proxmox_username
  password       = var.proxmox_password
  vm_id          = 9000
  vm_name        = "debian-template"
  storage_pool   = "local-lvm"
  disk_size      = 8000
  cores          = 2
  memory         = 2048
  ssh_username   = "debian"
  ssh_password   = "debian"
  ssh_timeout    = "20m"
  boot_wait      = "5s"
  preseed_path   = "http/preseed.cfg"
  http_directory = "http"
  qemu_agent     = true

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Add Ansible SSH key
  provisioner "file" {
    source      = var.ansible_pubkey_path
    destination = "/tmp/id_rsa.pub"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /home/debian/.ssh",
      "cat /tmp/id_rsa.pub >> /home/debian/.ssh/authorized_keys",
      "chown -R debian:debian /home/debian/.ssh",
      "chmod 700 /home/debian/.ssh",
      "chmod 600 /home/debian/.ssh/authorized_keys"
    ]
  }
}
