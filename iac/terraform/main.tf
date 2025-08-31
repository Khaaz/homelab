terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.83.0"
    }
  }
}

provider "proxmox" {
	endpoint = var.proxmox_api_url
	api_token = var.proxmox_api_token
	insecure = true

	ssh {
		agent = true
		username = "root"
	}
}

# --- reverse-proxy: NIC on vmbr1 and vmbr2
resource "proxmox_virtual_environment_vm" "reverse_proxy" {
  name      = "reverse-proxy"
  node_name = var.proxmox_node

  # Clone from existing template (by VMID)
  clone {
    node_name = var.proxmox_node
    vm_id     = var.proxmox_vm_template_id
  }

  agent {
    enabled = true
  }

  cpu { cores = 2 }
  memory { dedicated = 2048 }

  # NICs (order matters for ip_config below)
  network_device {
    model  = "virtio"
    bridge = "vmbr1" # 10.10.1.0/24
  }
  network_device {
    model  = "virtio"
    bridge = "vmbr2" # 10.10.2.0/24
  }

  # Cloud-Init
  initialization {
    # DNS servers (replaces 'nameserver')
    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }

    user_account {
      username = "admin"
      # keys     = [var.ssh_pubkey]
    }

    # One ip_config block per NIC, in the same order as network_device
    ip_config {
      ipv4 {
        address = "10.10.1.2/24"
        gateway = "10.10.1.1"
      }
    }
    ip_config {
      ipv4 {
        address = "10.10.2.2/24"
      }
    }
  }
}

# --- media-management: vmbr1, static 10.10.1.10
resource "proxmox_virtual_environment_vm" "media_management" {
  name      = "media-management"
  node_name = var.proxmox_node

  clone {
    node_name = var.proxmox_node
    vm_id     = var.proxmox_vm_template_id
  }

  agent { enabled = true }

  cpu { cores = 2 }
  memory { dedicated = 2048 }

  network_device {
    model  = "virtio"
    bridge = "vmbr1"
  }

  initialization {
    dns { servers = ["1.1.1.1", "8.8.8.8"] }

    user_account {
      username = "admin"
      # keys     = [var.ssh_pubkey]
    }

    ip_config {
      ipv4 {
        address = "10.10.1.10/24"
        gateway = "10.10.1.1"
      }
    }
  }
}

# --- media-server: vmbr2, static 10.10.2.10
resource "proxmox_virtual_environment_vm" "media_server" {
  name      = "media-server"
  node_name = var.proxmox_node

  clone {
    node_name = var.proxmox_node
    vm_id     = var.proxmox_vm_template_id
  }

  agent { enabled = true }

  cpu { cores = 4 }
  memory { dedicated = 4096 }

  network_device {
    model  = "virtio"
    bridge = "vmbr2"
  }

  initialization {
    dns { servers = ["1.1.1.1", "8.8.8.8"] }

    user_account {
      username = "admin"
      # keys     = [var.ssh_pubkey]
    }

    ip_config {
      ipv4 {
        address = "10.10.2.10/24"
        gateway = "10.10.2.1"
      }
    }
  }
}
