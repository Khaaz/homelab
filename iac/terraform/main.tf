provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_user
  pm_password     = var.proxmox_password
  pm_tls_insecure = true
}

# Create 3 VMs from template
resource "proxmox_vm_qemu" "debian_vm" {
  count             = 3
  name              = "vm-debian-${count.index + 1}"
  target_node       = var.proxmox_node
  clone             = var.template_name
  full_clone        = true
  vmid              = 100 + count.index

  os_type           = "cloud-init"
  cores             = 2
  memory            = 2048
  agent             = 1

  network {
    model    = "virtio"
    bridge   = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "8G"
  }

  ssh_user          = "debian"

  lifecycle {
    ignore_changes = [network]
  }
}

output "vm_ips" {
  value = [
    for vm in proxmox_vm_qemu.debian_vm : vm.default_ipv4_address
  ]
}